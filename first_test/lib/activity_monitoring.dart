import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'activity_blue.dart' as blue;
import 'activity_main.dart';
import 'activity_vision.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'activite_state.dart';


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
  late String weight;
  late int id;

  String text = "연결 하기";
  Map<String, List<int>> notifyDatas = {};

  late ScanResult ScanR;

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }
  bool connectblue(){

    if (text != "연결 하기"){
      return true;
    }
    else{
      return false;
    }


  }

  void getdata(ScanResult r) async {
    List<int> lastvalue = [];
    List<String> hexvalue = [];
    String hexstring = '';
    List<BluetoothService> bleServices = await r.device.discoverServices();

    for (BluetoothService service in bleServices) {
      for (BluetoothCharacteristic c in service.characteristics) {
        if (c.properties.write) {
          await c.write(utf8.encode("AT+START"));
          print(utf8.encode("AT+START"));
        }
        if (c.isNotifying) {
          print("print\n");
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
    hexstring = hexvalue.join();
    print(hexstring);
    callAPI(hexstring );

  }
  void callAPI(String hexdata) async {
    var url1 = Uri.parse(
      'http://35.78.251.14:9080/foot-prints/create',
    );
    Map data = {
      "email": "njt9905@naver.com",
      "name": "string",
      "rawData": hexdata
    };
    String body = json.encode(data);
    var response = await http.post(url1,
        headers: {"Content-Type": "application/json"}, body: body);
    print('post Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    String bodydata = '${response.body}';
    id = jsonDecode(bodydata)['id'];
    int setid = id;

    var url2 = Uri.parse(
      'http://35.78.251.14:9080/foot-prints/image/' + '$setid',
    );
    var imgresponse = await http.get(url2);
    String imgdata = '${imgresponse.body}';
    print('post Response status: ${imgresponse.statusCode}');
    print('Response body: ${imgresponse.body}');



    setState(() {
      img = jsonDecode(imgdata)['image'];
      weight = jsonDecode(imgdata)['weight'];
    });
  }

  Future<String> _fetch1() async {
    setState(() {
      img;
    });
    return img;
  }
  Future<String> _fetch2() async {
    setState(() {
      weight;
    });
    return weight;
  }
  void callAPIemail(String email) async {
    var url1 = Uri.parse(
      'http://35.78.251.14:9080/foot-prints/mail',
    );
    Map data = {
      "email": email,
      "id" : id,
    };
    String body = json.encode(data);
    var response = await http.post(url1,
        headers: {"Content-Type": "application/json"}, body: body);
    print('post Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  void emailDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('측정 결과 전송'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: myController,
              decoration: InputDecoration(hintText: "이메일 주소 입력해주세요"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('이메일로 전송',
                ),
                onPressed: () {
                  callAPIemail(valueText);

                  setState(() {
                    //codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(400, 70),
                      backgroundColor: Color(0xFfB0FFA3),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          new BorderRadius.circular(40.0)))
              ),
            ],
          );
        });
  }
  void emailok() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.network(
                    img,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                    child: Text(
                      'Hello World',
                    ),
                  ),
                  ElevatedButton(
                      child: Text('이메일로 전송',
                      ),
                      onPressed: () {
                        callAPIemail(valueText);

                        setState(() {
                          //codeDialog = valueText;
                          Navigator.pop(context);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 30),
                          backgroundColor: Color(0xFfB0FFA3),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(30.0)))
                  ),
                ],
              )
              ,

            ),
            actions: <Widget>[
              ElevatedButton(
                  child: Text('이메일로 전송',
                  ),
                  onPressed: () {
                    callAPIemail(valueText);

                    setState(() {
                      //codeDialog = valueText;
                      Navigator.pop(context);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(400, 70),
                      backgroundColor: Color(0xFfB0FFA3),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          new BorderRadius.circular(40.0)))
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
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
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 100,
                              decoration: BoxDecoration(),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: Color( connectblue()? 0xFF27FF42: 0xffF45B5A),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 100,
                              decoration: BoxDecoration(),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        final conct = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    blue.bluetooth( ))) as ScanResult;
                                        setState(() {
                                          text = conct.device.name;
                                          ScanR = conct;
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
                      )
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
                                            width: 400,
                                            height:400,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFEBEBEB),
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
                                        child:ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child:  Image.network(
                                            snapshot.data.toString(),
                                            width: 400,
                                            height: 400,
                                          ), // Text(key['title']),
                                        ),

                                      );
                                    }
                                  })
                            ],
                          ),
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

                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  <Widget>[
                                FutureBuilder(
                                    future: _fetch2(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                                      if (snapshot.hasData == false) {
                                        // return CircularProgressIndicator();
                                        return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 400,
                                              height:200,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFEBEBEB),
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                "체중 정보"
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
                                            child: Container(
                                              width: 400,
                                              height:200,
                                              decoration: BoxDecoration(
                                                color: Color(0xEBEBEB),
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                  snapshot.data.toString()
                                              ),
                                            ));
                                      }
                                    })
                              ],
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
                            onPressed: () => {getdata(ScanR)},

                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(150, 40),
                                backgroundColor: Color(0xFFCCCCCC),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0)
                                )
                            )
                        ),
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
