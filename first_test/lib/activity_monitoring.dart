import 'dart:async';
import 'dart:convert';

import 'package:first_test/provider/myProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'activity_blue.dart' as blue;
import 'activity_main.dart';
import 'activity_vision.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ActivityMonitoringWidget extends StatefulWidget {
  const ActivityMonitoringWidget({Key? key}) : super(key: key);
  @override
  _ActivityMonitoringWidgetState createState() =>
      _ActivityMonitoringWidgetState();
}

class _ActivityMonitoringWidgetState extends State<ActivityMonitoringWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String valueText = "";
  final myController = TextEditingController();
  late String img;
  late String weight;
  late int id;
  late bool isloading ;
  String text = "연결 하기";
  Map<String, List<int>> notifyDatas = {};
  late ScanResult ScanR;
  String stateText = 'Connecting';
  String connectButtonText = 'Disconnect';


  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }


  void disconnect(ScanResult r) {
    try {
      context.read<BlueState>().changeColor('Disconnect');
      r.device.disconnect();
    } catch (e) {}
  }
  void getdata(ScanResult r) async {
    List<int> lastvalue = [];
    List<String> hexvalue = [];
    int i = 0;
    String hexstring = '';
    List<BluetoothService> bleServices = await r.device.discoverServices();
    loading();
    for (BluetoothService service in bleServices) {
      for (BluetoothCharacteristic c in service.characteristics) {
        if (c.properties.write) {
          await c.write(utf8.encode("AT+START"));
          print("AT+START\n");

        }
        //c.isNotifying
        if (c.isNotifying) {
          print("listen\n");
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
            await Future.delayed(const Duration(milliseconds: 5000));
            // 설정 후 일정시간 지연

          } catch (e) {
            print('error ${c.uuid} $e');
          }
        } else {}

      }
    }
    for (int i in lastvalue) {
      final hexString = i.toRadixString(16);

      hexvalue.add(hexString.padLeft(2, '0'));
    }
    hexstring = hexvalue.join();
    print(hexstring);
    callAPI(hexstring);
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
      isloading = false;
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
      "id": id,
    };
    String body = json.encode(data);
    var response = await http.post(url1,
        headers: {"Content-Type": "application/json"}, body: body);
    print('post Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    emailok();
  }
  void emailDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
            ),
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
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ElevatedButton(
                        child: Text(
                          '이메일로 전송',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        onPressed: () {
                          callAPIemail(valueText);
                          setState(() {
                            //codeDialog = valueText;
                            Navigator.pop(context);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(300, 40),
                            backgroundColor: Color(0xFfB0FFA3),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    new BorderRadius.circular(40.0)
                            )
                        )
                    ),
                  ],
                ),
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
            ),
            title: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SvgPicture.asset(
                  'assets/send.svg',
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                  color: Color(0xFFB0FFA3),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                  child: Text(
                    '측정 결과 전송을 완료하였습니다.\n 작성하신 메일을 확인해주세요.',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                ElevatedButton(
                    child: Text(
                      '확인',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 30),
                        backgroundColor: Color(0xFf141514),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)))),
              ],
            ),

          );
        });
  }
  void loading() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          Future.delayed(Duration(seconds: 7), () {
            Navigator.pop(context);
          });

          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)
            ),
            content: SizedBox(
              height: 200,
              child: Center(
                  child:SizedBox(
                    child:
                    new CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation(Color(0xffB0FFA3)),
                        strokeWidth: 5.0
                    ),
                    height: 50.0,
                    width: 50.0,
                  )
              ),
            ),
          );

        });
  }
  String KgPrint(kg){
    String kgprint = kg.substring(0, 5);
    return kgprint;

  }

  void connecterror() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.pop(context);
          });
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
            ),
            title: Column(
              mainAxisSize: MainAxisSize.max,
              children: [

                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                  child: Text(
                    '블루투스 연결을 확인해 주세요',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),

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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 5, 5, 5),
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: context.watch<BlueState>().state,
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
                                                        blue.bluetooth()))
                                            as ScanResult;
                                        setState(() {
                                          text = conct.device.name;
                                          ScanR = conct;
                                          print(text);
                                        });
                                        context.read<BlueState>().changeColor('Connect');
                                      },
                                      child: Text(
                                        (text),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(160, 40),
                                          backgroundColor: Color(0xFF000000),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0))))
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
                                              height: 400,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFEBEBEB),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 30, 0, 10),
                                                    child: SvgPicture.asset(
                                                      'assets/body.svg',
                                                      width: 300,
                                                      height: 300,
                                                      fit: BoxFit.cover,
                                                      color: Color(0xffcccccc),
                                                    ),
                                                  ),
                                                  Text(
                                                    '디바이스에 올라선 후 측정하기를 눌러주세요',
                                                    style: TextStyle(
                                                      fontFamily: 'Pretendard',
                                                      color: Color(0xffcccccc),
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              )));
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
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
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
                            children: <Widget>[
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
                                              height: 200,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFEBEBEB),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                30, 0, 0, 0),
                                                    child: Text(
                                                      '체중 정보',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 30, 0),
                                                          child: Text(
                                                            'kg',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )));
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
                                              height: 200,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFEBEBEB),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                30, 0, 0, 0),
                                                    child: Text(
                                                      '체중 정보',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 30, 0),
                                                          child: Text(
                                                              KgPrint(snapshot.data
                                                                  .toString())
                                                             +
                                                                '      kg',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )));
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
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 10, 0),
                        child: ElevatedButton(
                            child: Text(
                              '나에게 보내기',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            onPressed: () => emailDialog(),
                            style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                  width: 1.0,
                                  color: Color(0xff141514),
                                ),
                                minimumSize: const Size(190, 50),
                                backgroundColor: Color(0xFFF7F8FA),
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ))),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                        child: ElevatedButton(
                            child: Text(
                              "측정하기",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            onPressed: () => {getdata(ScanR)},
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(190, 50),
                                backgroundColor: Color(0xFF141514),
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
                                  disconnect(ScanR);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ActivityMainWidget()),
                                  );
                                },
                                child: Text(
                                  '처음으로',
                                  style: Theme.of(context).textTheme.subtitle2,
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
