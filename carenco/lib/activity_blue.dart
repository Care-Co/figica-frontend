import 'dart:async';
import 'dart:convert';

import 'package:carenco/provider/myProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';
import 'activity_blue_device.dart';
import 'activity_monitoring.dart' as monitoring;
import 'flutter_flow/flutter_flow_theme.dart';

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
  final String targetDeviceName = 'Scale2';


  @override
  initState() {
    super.initState();
    scan();
    flutterBlue.stopScan();
    initBle();
    setState(() {});
  }


  void initBle() async{
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
             if (element.device.name == targetDeviceName) {
            //   // 장치의 ID를 비교해 이미 등록된 장치인지 확인
              if (scanResultList
                  .indexWhere((e) => e.device.id == element.device.id) <
                  0) {
                // 찾는 장치명이고 scanResultList에 등록된적이 없는 장치라면 리스트에 추가
                scanResultList.add(element);
              }
             }
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
  void onTap(ScanResult r) async{
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

  /* 장치 아이템 위젯 */
  Widget listItem(ScanResult r) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),


      tileColor: Colors.white,
      textColor: Color(0xffB0B0B0),

      onTap: () => onTap(r),
      // leading: leading(r),
      title: deviceName(r),
      // subtitle: deviceMacAddress(r),
      // trailing: deviceSignal(r),
    );
  }

  /* UI */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffdddddd),
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
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child:Column(
            mainAxisSize: MainAxisSize.max,
            children: [
            Container(
            width: 380,
            height: 380,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hello World',
                  style: FlutterFlowTheme.of(context).subtitle1.override(
                    fontFamily: 'Pretendard',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    useGoogleFonts: false,
                  ),
                ),
              ],
            ),
            ),

              Container(
                width: 400,
                height: 400,
                child: ListView.separated(
                  itemCount: scanResultList.length,
                  itemBuilder: (context, index) {
                    return listItem(scanResultList[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                ),

              ),
            ],
          )

          ,
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
      floatingActionButton: FloatingActionButton(
        onPressed: scan,
        // 스캔 중이라면 stop 아이콘을, 정지상태라면 search 아이콘으로 표시
        child: Icon(_isScanning ? Icons.stop : Icons.search),
        backgroundColor: Color(0xFF27FF42),
      ),
    );
  }
}
