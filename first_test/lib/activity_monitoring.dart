import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'activity_blue.dart' as blue;
import 'activity_main.dart';
import 'activity_vision.dart';
import 'package:http/http.dart' as http;

class ActivityMonitoringWidget extends StatefulWidget {
  const ActivityMonitoringWidget({Key? key}) : super(key: key);
  @override
  _ActivityMonitoringWidgetState createState() =>
      _ActivityMonitoringWidgetState();
}

class _ActivityMonitoringWidgetState extends State<ActivityMonitoringWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _buttonState = "OFF";
  String valueText = "";
  final myController = TextEditingController();
  late String img;
  late String id;
  String text = "연결 하기";
  Map<String, List<int>> notifyDatas = {};
  List<int> lastvalue = [];
  List<String> hexvalue = [];
  ScanResult conct = '' as ScanResult;
  String hexstring = '';
  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  void getdata(ScanResult r) async {
    List<BluetoothService> bleServices = await r.device.discoverServices();

    for (BluetoothService service in bleServices) {
      for (BluetoothCharacteristic c in service.characteristics) {
        if (c.properties.write) {
          await c.write(utf8.encode("AT+START"));
          print(utf8.encode("AT+START"));
        }
        if (c.isNotifying) {
          try {
            await c.setNotifyValue(true);
            // 받을 데이터 변수 Map 형식으로 키 생성
            notifyDatas[c.uuid.toString()] = List.empty();
            c.value.listen((value) {
              // 데이터 읽기 처리!
              setState(() {
                // 받은 데이터 저장 화면 표시용
                notifyDatas[c.uuid.toString()] = value;
                lastvalue += value;
              });
            });

            // 설정 후 일정시간 지연
            await Future.delayed(const Duration(milliseconds: 5000));
          } catch (e) {
            print('error ${c.uuid} $e');
          }
        } else {}
      }
    }
    print('ok\n');
    print(lastvalue);
    for (int i in lastvalue) {
      final hexString = i.toRadixString(16);

      hexvalue.add(hexString.padLeft(2, '0'));
    }
    String str = hexvalue.join();
    print(str);
  }
  // void bleDialog() {
  //   showDialog(
  //       context: context,
  //       //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         Future.delayed(Duration(seconds: 5), () {
  //           Navigator.pop(context);
  //         });
  //         return AlertDialog(
  //           // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(30.0)),
  //           backgroundColor: Color(0xffffffff),
  //           //Dialog Main Title
  //           title: Column(
  //             children: <Widget>[
  //
  //             ],
  //           ),
  //           //
  //         );
  //       });
  // }

  void emailDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('login form'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: myController,
              decoration: InputDecoration(hintText: "이메일을 입력해주세요"),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('전송'),
                onPressed: () {
                  setState(() {
                    //codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    void _callAPI() async {
      var url1 = Uri.parse(
        'http://35.78.251.14:9080/foot-prints/create',
      );

      Map data = {
        "email": "njt9905@naver.com",
        "name": "string",
        "rawData": hexstring
      };

      String body = json.encode(data);
      var response = await http.post(url1,
          headers: {"Content-Type": "application/json"}, body: body);
      print('post Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      String bodydata = '${response.body}';
      int myJson = jsonDecode(bodydata)['id'];

      var url2 = Uri.parse(
        'http://35.78.251.14:9080/foot-prints/image/' + '$myJson',
      );
      var imgresponse = await http.get(url2);
      String imgdata = '${imgresponse.body}';
      print('post Response status: ${imgresponse.statusCode}');
      print('Response body: ${imgresponse.body}');
      img = jsonDecode(imgdata)['image'];
    }

    Future<String> _fetch1() async {
      return img;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 100,
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 10),
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Color(0xFF27FF42),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            //연결하기----------------------------------------------------------------------------
                            ElevatedButton(
                                onPressed: () async {
                                  conct = (Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              blue.bluetooth()))) as ScanResult;
                                  print(conct);
                                  setState(() {
                                    text = conct.device.name;
                                    print(text);
                                  });
                                },
                                child: Text(
                                  (text),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xffffffff),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(160, 40),
                                    backgroundColor: Color(0xFF000000),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0))))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(30, 30, 30, 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FutureBuilder(
                                  future: _fetch1(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                                    if (snapshot.hasData == false) {
                                      // return CircularProgressIndicator();
                                      return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 300,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFaaaaaa),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ));
                                    }
                                    //error가 발생하게 될 경우 반환하게 되는 부분
                                    else if (snapshot.hasError) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Error: ${snapshot.error}',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      );
                                    }
                                    // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                                    else {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.network(
                                          snapshot.data.toString(),
                                        ),
                                      );
                                    }
                                  })
                            ],
                          ),
                          // child: Container(
                          //   width: MediaQuery.of(context).size.width,
                          //   height: MediaQuery.of(context).size.height * 1,
                          //   decoration: BoxDecoration(
                          //     color: Color(0xFFaaaaaa),
                          //     borderRadius: BorderRadius.circular(10),
                          //   ),
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.12,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(30, 10, 30, 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 1,
                            decoration: BoxDecoration(
                              color: Color(0xFFCCCCCC),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: ElevatedButton(
                            child: Text(
                              '나에게 보내기',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFFCCCCCC),
                              ),
                            ),
                            onPressed: () => emailDialog(),
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(150, 40),
                                backgroundColor: Color(0xFFffffff),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0)))),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: ElevatedButton(
                            child: Text("측정하기"),
                            onPressed: _callAPI,
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(150, 40),
                                backgroundColor: Color(0xFFCCCCCC),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0)))),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ActivityMainWidget()),
                                  );
                                },
                                child: Text(
                                  '처음으로',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xffffffff),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    minimumSize:
                                        const Size(double.infinity, 50),
                                    backgroundColor: Color(0xFF000000),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0))))
                          ],
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
