import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'activity_blue_device.dart';

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
  @override
  initState() {
    super.initState();
    // 블루투스 초기화
    initBle();
  }

  void initBle() {
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
        // List<ScanResult> 형태의 results 값을 scanResultList에 복사
        scanResultList = results;
        // UI 갱신
        setState(() {});
      });
    } else {
      // 스캔 중이라면 스캔 정지
      flutterBlue.stopScan();
    }
  }

  /*
   여기서부터는 장치별 출력용 함수들
  */
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
  void getdata(ScanResult r) async{

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
    for (int i in lastvalue){
      final hexString =  i.toRadixString(16);

      hexvalue.add( hexString.padLeft(2, '0'));
    }
    String str = hexvalue.join();
    print(str);
  }

  void connectToDevice(ScanResult r) async {
//flutter_blue makes our life easier
    await r.device.connect();
  }

  /* BLE 아이콘 위젯 */
  Widget leading(ScanResult r) {
    return CircleAvatar(
      child: Icon(
        Icons.bluetooth,
        color: Colors.white,
      ),
      backgroundColor: Colors.cyan,
    );
  }

  /* 장치 아이템을 탭 했을때 호출 되는 함수 */
  void onTap(ScanResult r) async{
    // 단순히 이름만 출력
    print('${r.device.name}');
    String data = '${r.device.name}';
    connectToDevice(r);
    await Future.delayed(const Duration(milliseconds: 500));
    Navigator.pop(context,r);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => DeviceScreen(device: r.device)),
    // );
  }

  /* 장치 아이템 위젯 */
  Widget listItem(ScanResult r) {
    return ListTile(
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
      body: Center(
        /* 장치 리스트 출력 */
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
      /* 장치 검색 or 검색 중지  */
      floatingActionButton: FloatingActionButton(
        onPressed: scan,
        // 스캔 중이라면 stop 아이콘을, 정지상태라면 search 아이콘으로 표시
        child: Icon(_isScanning ? Icons.stop : Icons.search),
      ),
    );
  }
}
