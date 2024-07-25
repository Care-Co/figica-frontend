import 'package:fisica/index.dart';

import 'package:flutter/material.dart';

import 'package:fisica/index.dart';

class TesterMenu extends StatefulWidget {
  const TesterMenu({super.key});

  @override
  State<TesterMenu> createState() => _TesterMenuState();
}

class _TesterMenuState extends State<TesterMenu> {
  BluetoothDevice? targetDevice;
  BluetoothDevice? targetDevice1;
  BluetoothDevice? targetDevice2;
  bool isConnecting = false;

  Future<void> _disconnectConnectedDevices() async {
    List<BluetoothDevice> connectedDevices = await FlutterBluePlus.connectedDevices;
    for (BluetoothDevice device in connectedDevices) {
      await device.disconnect();
      targetDevice1 = null;
      targetDevice2 = null;
      print('연결 해제 ${device.platformName}');
    }
  }

  Future<bool> _searchAndConnect(String name) async {
    bool resultscan = false;
    setState(() {
      isConnecting = true;
    });
    await _disconnectConnectedDevices();
    await FlutterBluePlus.startScan(
      //withServices: [Guid("180D")],
      withNames: [name],
      timeout: Duration(seconds: 10),
    );

    var subscription = FlutterBluePlus.scanResults.listen(
      (results) async {
        for (ScanResult result in results) {
          print('${result.device.remoteId}: "${result.device.platformName}" found!');

          if (result.device.platformName == name) {
            targetDevice = result.device;
            FlutterBluePlus.stopScan();

            await targetDevice?.connect();
            setState(() {
              isConnecting = false;
            });

            if (targetDevice != null) {
              resultscan = true;
              print('Connected to ${targetDevice!.platformName}');
            } else {
              print('Failed to connect to the device');
            }
            break;
          }
        }
      },
    );
    await Future.delayed(Duration(seconds: 10));
    subscription.cancel();
    FlutterBluePlus.stopScan();

    setState(() {
      isConnecting = false;
    });
    return resultscan;
  }

  Future<bool> _searchAndConnectAll() async {
    print('_searchAndConnectAll');
    if ((targetDevice1 != null && targetDevice2 != null)) {}
    await _disconnectConnectedDevices();

    bool resultScan1 = false;
    bool resultScan2 = false;
    setState(() {
      isConnecting = true;
    });

    await FlutterBluePlus.startScan(
      withNames: ['AT+AUTO', 'Fisica Scale'],
      timeout: Duration(seconds: 10),
    );

    var subscription = FlutterBluePlus.scanResults.listen(
      (results) async {
        for (ScanResult result in results) {
          print('${result.device.remoteId}: "${result.device.platformName}" found!');

          if (result.device.platformName == 'AT+AUTO' && targetDevice1 == null) {
            print('AUTO');
            targetDevice1 = result.device;
            await targetDevice1?.connect();
            if (targetDevice1 != null) {
              resultScan1 = true;
              print('Connected to ${targetDevice1!.platformName}');
            } else {
              print('Failed to connect to the device AT+AUTO');
            }
          } else if (result.device.platformName == 'Fisica Scale' && targetDevice2 == null) {
            print('Scale');

            targetDevice2 = result.device;
            await targetDevice2?.connect();

            if (targetDevice2 != null) {
              resultScan2 = true;
              print('Connected to ${targetDevice2!.platformName}');
            } else {
              print('Failed to connect to the device Fisica Scale');
            }
          }
        }
      },
    );

    await Future.delayed(Duration(seconds: 15));
    subscription.cancel();
    FlutterBluePlus.stopScan();
    setState(() {
      isConnecting = false;
    });
    return resultScan1 & resultScan2;
  }

  void divice1() async {
    await _searchAndConnect('AT+AUTO').then((value) => value ? context.goNamed('Teseter_Scan', extra: 1) : null);
  }

  void divice2() async {
    await _searchAndConnect('Fisica Scale').then((value) => value ? context.goNamed('Teseter_Scan', extra: 2) : null);
  }

  void alldivice() async {
    await _searchAndConnectAll().then((value) => value ? context.goNamed('Teseter_Scan', extra: 2) : null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Black,
      appBar: AppBar(
        leading: AppIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.chevron_left,
            color: AppColors.primaryBackground,
            size: 30,
          ),
          onPressed: () async {
            context.pop();
          },
        ),
        backgroundColor: Color(0x00CCFF8B),
        automaticallyImplyLeading: false,
        title: Text('데이터 수집 진행', style: AppFont.s18.overrides(color: AppColors.primaryBackground)),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              LodingButtonWidget(
                text: '1번 기기 측정',
                onPressed: () => divice1(),
                options: LodingButtonOptions(
                  height: 100.0,
                  width: double.infinity,
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: AppColors.Gray700,
                  textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.primaryBackground),
                  elevation: 0,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              LodingButtonWidget(
                text: '2번 기기 측정',
                onPressed: () => divice2(),
                options: LodingButtonOptions(
                  height: 100.0,
                  width: double.infinity,
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: AppColors.Gray700,
                  textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.primaryBackground),
                  elevation: 0,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              LodingButtonWidget(
                text: '2번 기기 측정',
                onPressed: () => alldivice(),
                options: LodingButtonOptions(
                  height: 100.0,
                  width: double.infinity,
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: AppColors.Gray700,
                  textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.primaryBackground),
                  elevation: 0,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dispose() {
    targetDevice1?.disconnect();
    targetDevice2?.disconnect();
    super.dispose();
  }
}
