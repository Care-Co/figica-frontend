import 'dart:async';
import 'dart:convert';

import 'package:carenco/flutter_flow/flutter_flow_util.dart';
import 'package:carenco/provider/myProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';

class bluetooth extends StatefulWidget {
  @override
  _bluetoothState createState() => _bluetoothState();
}

class _bluetoothState extends State<bluetooth> {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  List<ScanResult> scanResultList = [];
  bool _isScanning = false;
  Map<String, List<int>> notifyDatas = {};
  List<int> lastvalue = [];
  List<String> hexvalue = [];
  final String targetDeviceName = 'Care&Co. 1';

  @override
  initState() {
    super.initState();
    scan();
    flutterBlue.stopScan();
    initBle();
    setState(() {});
  }

  void initBle() async {
    // BLE 스캔 상태 얻기 위한 리스너
    flutterBlue.isScanning.listen((isScanning) {
      _isScanning = isScanning;
      setState(() {});
    });
  }

  /*
  스캔 시작/정지 함수
  */
  scan() async {
    if (!_isScanning) {
      // 스캔 중이 아니라면
      // 기존에 스캔된 리스트 삭제
      scanResultList.clear();
      // 스캔 시작, 제한 시간 4초
      flutterBlue.startScan(timeout: Duration(seconds: 4));
      // 스캔 결과 리스너

      flutterBlue.scanResults.listen((results) {
        results.forEach((element) {
          //찾는 장치명인지 확인
          // if (element.device.name == targetDeviceName) {
          //   // 장치의 ID를 비교해 이미 등록된 장치인지 확인
          if (scanResultList
                  .indexWhere((e) => e.device.id == element.device.id) <
              0) {
            // 찾는 장치명이고 scanResultList에 등록된적이 없는 장치라면 리스트에 추가
            scanResultList.add(element);
          }
          // }
        });
        // UI 갱신
        setState(() {});
      });
    } else {
      // 스캔 중이라면 스캔 정지
      flutterBlue.stopScan();
    }
  }

  /*  장치의 신호값 위젯  */
  Widget deviceSignal(ScanResult r) {
    return Text(r.rssi.toString());
  }

  /* 장치의 MAC 주소 위젯  */
  Widget deviceMacAddress(ScanResult r) {
    return Text(r.device.id.id);
  }

  /* 장치의 명 위젯  */
  Widget deviceName(ScanResult r) {
    String name = '';

    if (r.device.name.isNotEmpty) {
      // device.name에 값이 있다면
      name = r.device.name;
    } else if (r.advertisementData.localName.isNotEmpty) {
      // advertisementData.localName에 값이 있다면
      name = r.advertisementData.localName;
    } else {
      // 둘다 없다면 이름 알 수 없음...
      name = 'N/A';
    }
    return Text(name);
  }

  void connectToDevice(ScanResult r) async {
//flutter_blue makes our life easier
    await r.device.connect();
    context.read<BlueState>().connectstate(r);
    context.read<BlueState>().getscan(r);
    context.read<BlueState>().changeState(BluetoothDeviceState.connected);
    print('===============================');
    print(context.watch<BlueState>().connecttext);
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  /* 장치 아이템을 탭 했을때 호출 되는 함수 */
  void onTap(ScanResult r) async {
    // 단순히 이름만 출력
    print('${r.device.name}');
    connectToDevice(r);
    await Future.delayed(const Duration(milliseconds: 500));
    Navigator.pop(context);

    // Navigator.pop(context,r);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => DeviceScreen(device: r.device)),
    // );
  }
  void connetdialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: FlutterFlowTheme.of(context).grey850,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            actions: <Widget>[
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          height: 300,
                          width: 200,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '디바이스 등록 완료',
                                style: FlutterFlowTheme.of(context)
                                    .subtitle1
                                    .override(
                                  fontFamily: 'Pretendard',
                                  color: FlutterFlowTheme.of(context).white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: false,
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                child: Text(
                                  '연결이 완료되었습니다',
                                  style: FlutterFlowTheme.of(context)
                                      .subtitle1
                                      .override(
                                    fontFamily: 'Pretendard',
                                    color: FlutterFlowTheme.of(context)
                                        .grey500,
                                    useGoogleFonts: false,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Generated code for this Button Widget...
                        Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(12, 12, 12, 6),
                          child: ElevatedButton(
                              child: Text(
                                '홈으로 이동',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              onPressed: () {
                                setState(() {
                                  context.pushNamed('newscan');
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(300, 56),
                                  backgroundColor: Color(0xFfB0FFA3),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      new BorderRadius.circular(12.0)))),
                        ),
                        Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(12, 6, 12, 12),
                          child: ElevatedButton(
                              child: Text(
                                'Footprint 분석하기',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              onPressed: () {
                                setState(() {
                                  context.pushNamed('newscan');
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(300, 56),
                                  backgroundColor: Color(0xFfB0FFA3),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      new BorderRadius.circular(12.0)))),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }
  /* 장치 아이템 위젯 */
  Widget listItem(ScanResult r) {
    return ListTile(

      contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
      title:  deviceName(r),

      tileColor: Color(0x5D4B4D51),
      textColor: Color(0xffB0B0B0),
      //subtitle: deviceMacAddress(r),

      onTap: () => onTap(r),
      // leading: leading(r),
      //trailing: deviceSignal(r),
      dense: false,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      ),

    );
  }

  /* UI */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).black,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          child: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Color(0xFF141515)),
            automaticallyImplyLeading: true,
            centerTitle: true,
            toolbarHeight: MediaQuery.of(context).size.height * 0.1,
            elevation: 0,
          ),
        ),
        body: SafeArea(
          top: true,

          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/notext.png') ,
                fit: BoxFit.cover,
              )
            ),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.4,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: scanResultList.length,
                            itemBuilder: (context, index) {
                              return listItem(scanResultList[index]);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 84, 0, 0),
                  child: Text(
                    '제품의 전원을 켜고 스마트폰 설정에서\n'
                        '블루투스 연결을 켜주세요',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).subtitle1.override(
                      fontFamily: 'Pretendard',
                      color: FlutterFlowTheme.of(context).figicoGreen,
                      fontSize: 16,
                      useGoogleFonts: false,
                    ),
                  ),
                ),
                if (_isScanning == true)
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 50, 24, 0),
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: FFButtonWidget(
                        onPressed: scan,
                        text: '검색중',
                        options: FFButtonOptions(
                          height: 40,
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: FlutterFlowTheme.of(context).black,
                          textStyle: FlutterFlowTheme.of(context).subtitle1.override(
                            fontFamily: 'Pretendard',
                            color: FlutterFlowTheme.of(context).white,
                            useGoogleFonts: false,
                          ),
                          elevation: 2,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                if (_isScanning != true)
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 80, 24, 0),
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: FFButtonWidget(
                        onPressed: scan,
                        text: '검색',
                        options: FFButtonOptions(
                          height: 40,
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: FlutterFlowTheme.of(context).white,
                          textStyle: FlutterFlowTheme.of(context).subtitle1.override(
                            fontFamily: 'Pretendard',
                            color: FlutterFlowTheme.of(context).black,
                            useGoogleFonts: false,
                          ),
                          elevation: 2,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // child: ListView.separated(
          //   itemCount: scanResultList.length,
          //   itemBuilder: (context, index) {
          //     return listItem(scanResultList[index]);
          //   },
          //   separatorBuilder: (BuildContext context, int index) {
          //     return Divider();
          //   },
          // ),
          //
          // /* 장치 리스트 출력 */
        ),
        /* 장치 검색 or 검색 중지  */
        );
  }
}
