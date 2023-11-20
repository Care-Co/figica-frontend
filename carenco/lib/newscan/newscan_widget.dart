import 'dart:async';
import 'dart:convert';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../newresult/newresult_widget.dart';
import '../provider/myProvider.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../newblue/newblue_widget.dart' as blue;

import 'newscan_model.dart';
export 'newscan_model.dart';

class NewscanWidget extends StatefulWidget {
  const NewscanWidget({Key? key}) : super(key: key);

  @override
  _NewscanWidgetState createState() => _NewscanWidgetState();
}

class _NewscanWidgetState extends State<NewscanWidget> {
  late NewscanModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  String valueText = "";
  final myController = TextEditingController();
  late String img;
  late String weight;
  late int id;
  late bool isloading;
  int testcount = 52;
  String text = "연결 하기";
  String bodydata = "";
  Map<String, List<int>> notifyDatas = {};
  late ScanResult ScanR;
  StreamSubscription<BluetoothDeviceState>? _stateListener;
  BluetoothDeviceState deviceState = BluetoothDeviceState.disconnected;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewscanModel());
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  void disconnect(ScanResult r) {
    try {
      r.device.disconnect();
    } catch (e) {}
  }

  void conn(ScanResult r) async {
    List<BluetoothService> bleServices = await r.device.discoverServices();
    for (BluetoothService service in bleServices) {
      for (BluetoothCharacteristic c in service.characteristics) {
        if (c.properties.write) {
          await c.write(utf8.encode("AT+CONN"));
          print("AT+CONN\n");
        }
        if (true) {
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
              });
            });
            await Future.delayed(const Duration(milliseconds: 100));
            // 설정 후 일정시간 지연
          } catch (e) {
            print('error ${c.uuid} $e');
          }
        } else {}
      }
    }
  }

  void mode(ScanResult r) async {
    List<BluetoothService> bleServices = await r.device.discoverServices();
    for (BluetoothService service in bleServices) {
      for (BluetoothCharacteristic c in service.characteristics) {
        if (c.properties.write) {
          await c.write(utf8.encode("AT+MODE=3"));
          print("AT+MODE\n");
          print(utf8.encode("AT+MODE=3"));
        }
        if (true) {
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
              });
            });
            await Future.delayed(const Duration(milliseconds: 100));
            // 설정 후 일정시간 지연
          } catch (e) {
            print('error ${c.uuid} $e');
          }
        } else {}
      }
    }
  }

  void stop(ScanResult r) async {
    List<BluetoothService> bleServices = await r.device.discoverServices();
    for (BluetoothService service in bleServices) {
      for (BluetoothCharacteristic c in service.characteristics) {
        if (c.properties.write) {
          await c.write(utf8.encode("AT+STOP"));
          print("AT+STOP\n");
        }
      }
    }
  }

  void loading() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          Future.delayed(Duration(seconds: 7), () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewresultWidget(bodydata)
                )
            );
          });

          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            content: SizedBox(
              height: 200,
              child: Center(
                  child: SizedBox(
                child: new CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation(Color(0xffB0FFA3)),
                    strokeWidth: 5.0),
                height: 50.0,
                width: 50.0,
              )),
            ),
          );
        });
  }


  void getdata(ScanResult r) async {
    List<int> lastvalue = [];
    List<int> lastvalue2 = [];
    List<String> hexvalue = [];
    String hexstring = '';
    conn(r);
    mode(r);
    DateTime start = DateTime.now();
    int i = 1;

    List<BluetoothService> bleServices = await r.device.discoverServices();
    loading();
    for (BluetoothService service in bleServices) {
      for (BluetoothCharacteristic c in service.characteristics) {
        if (c.properties.write) {
          await c.write(utf8.encode("AT+AUTO"));
          print("AT+AUTO\n");
        }
        //c.isNotifying
        if (true) {
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
              i++;
              if (i == 35) {
                stop(r);
              }
            });
            print("===========lastvalue");

            await Future.delayed(const Duration(milliseconds: 3000));
            // 설정 후 일정시간 지연
          } catch (e) {
            print('error ${c.uuid} $e');
          }
        } else {}
      }

    }
    print(lastvalue);
    for (int i in lastvalue) {
      if ( i != 0){
        if (i >= 225 ){
          lastvalue2.add( 255 );
        }
        else{
          lastvalue2.add( i + 30);
        }

      }
      else{
        lastvalue2.add( i );
      }
    }
    print(lastvalue2);
    int j = 0;
    for (int i in lastvalue2) {
      if ( i != 0 && j < 10){
      }
      else{
        final hexString = i.toRadixString(16) ;
        hexvalue.add(hexString.padLeft(2, '0'));
      }
      j++;

    }
    DateTime end = DateTime.now();
    print("소요시간: ${end.difference(start)}");
    hexstring = hexvalue.join();

    print(hexstring);
    callAPI(hexstring);
    testcount += 1;
    print("===========================");
    print(testcount);
    //logAPI(hexstring, start, end);

  }
  void logAPI(String hexdata,DateTime start, DateTime end) async {
    var url1 = Uri.parse(
      'http://54.238.73.13:8080/log/performanceTest/save'
    );
    DateTime now = DateTime.now();
    String nowDate = DateFormat('yyyy-MM-dd –kk:mm').format(now);
    String enddata = DateFormat('yyyy-MM-dd –kk:mm').format(end);
    String startdata = DateFormat('yyyy-MM-dd –kk:mm').format(start);
    Duration speed = end.difference(start);
    Map data = {
      "data": 0,
      "endTime": enddata,
      "remark": "string",
      "startTime": startdata,
      "testCount": testcount,
      "transmissionSpeed": speed.toString()
    };
    print(data);
    String body = json.encode(data);
    var response = await http.post(url1,
        headers: {"Content-Type": "application/json"}, body: body);
    print('post Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    setState(() {
      bodydata = '${response.body}';
    });
    print (bodydata);
    DateTime dt = DateTime.now();
    print(dt);
  }

  void callAPI(String hexdata) async {
    DateTime start = DateTime.now();
    var url1 = Uri.parse(
      'http://ecs-spring-alb-637551136.ap-northeast-2.elb.amazonaws.com/foot-prints/create'
      ,
    );
    Map data = {
      "id":0,
      "rawData": hexdata
    };

    String body = json.encode(data);

    var response = await http.post(url1,
        headers: {"Content-Type": "application/json"}, body: body);

    DateTime end = DateTime.now();

    logAPI("0", start, end);
    print('post Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    setState(() {
      bodydata = '${response.body}';

    });
    print (bodydata);
    DateTime dt = DateTime.now();
    print(dt);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: FlutterFlowTheme.of(context).white),
          automaticallyImplyLeading: true,
          centerTitle: true,
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          elevation: 0,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
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
                          color: context.watch<BlueState>().color,
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
                        // onPressed: () async {
                        //   final conct = await Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) =>
                        //                   blue.bluetooth()))
                        //       as ScanResult;
                        //   setState(() {
                        //     text = conct.device.name;
                        //     ScanR = conct;
                        //     //연결상태 검사 시작
                        //     connectstate();
                        //   });
                        // },

                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => blue.bluetooth()));

                          setState(() {
                            ScanR = context.watch<BlueState>().scanresult;
                          });
                        },
                        child: Text(
                          (context.watch<BlueState>().connecttext),
                          style:
                              FlutterFlowTheme.of(context).subtitle1.override(
                                    fontFamily: 'Pretendard',
                                    color: FlutterFlowTheme.of(context).white,
                                    fontWeight: FontWeight.w600,
                                    useGoogleFonts: false,
                                  ),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(160, 40),
                          backgroundColor: Color(0xFF000000),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          side: BorderSide(
                              color: context.watch<BlueState>().color),
                        ))
                  ],
                ),
              ),
            ],
          ),
          actions: [],
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 124, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                      },
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          gradient: RadialGradient(radius: 0.8, colors: [
                            FlutterFlowTheme.of(context).black,
                            context.watch<BlueState>().color,
                            context.watch<BlueState>().color,
                            context.watch<BlueState>().color,
                            FlutterFlowTheme.of(context).black,
                          ], stops: [
                            0.5,
                            0.5,
                            0.505,
                            0.505,
                            0.55,
                          ]),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: SvgPicture.asset(
                                  context.watch<BlueState>().connecttext == "연결하기" ? 'assets/svg/footprint_failure.svg' :'assets/svg/footprint_loading.svg',
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (context.watch<BlueState>().connecttext == "연결하기")
                Text(
                  '기기 연결을 확인해주세요',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).subtitle1.override(
                        fontFamily: 'Pretendard',
                        color: context.watch<BlueState>().color,
                        fontSize: 16,
                        useGoogleFonts: false,
                      ),
                ),
              if (context.watch<BlueState>().connecttext != "연결하기")
              // Generated code for this Button Widget...
                 Padding(
                    padding:
                    EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                    child: ElevatedButton(
                        child: Text(
                          "측정하기",
                          style: FlutterFlowTheme.of(context)
                              .subtitle2
                              .override(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            useGoogleFonts: false,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () => {
                           getdata(
                               context.watch<BlueState>().scanresult)
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff141514),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                new BorderRadius.circular(10.0)))),
                  ),


              // Text(
                //   '기기위로 올라서서\n측정 버튼을 눌러주세요',
                //   textAlign: TextAlign.center,
                //   style: FlutterFlowTheme.of(context).subtitle1.override(
                //         fontFamily: 'Pretendard',
                //         color: context.watch<BlueState>().color,
                //         fontSize: 16,
                //         useGoogleFonts: false,
                //       ),
                // ),

            ],
          ),
        ),
      ),
    );
  }
}
