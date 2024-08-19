import 'dart:convert';

import 'package:fisica/utils/service/Foot_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fisica/index.dart';
import 'package:provider/provider.dart';

class TesterScan extends StatefulWidget {
  final int divice;
  const TesterScan({Key? key, required this.divice}) : super(key: key);

  @override
  State<TesterScan> createState() => _TesterScanState();
}

class _TesterScanState extends State<TesterScan> {
  late StreamSubscription<BluetoothConnectionState> _connectionStateSubscription;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String ids = '';
  String devicename = '';
  late BluetoothDevice cndevice;
  bool isconnect = false;
  late dynamic subscription;
  late String rawdata = '';
  bool isscaning = false;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    final device = FlutterBluePlus.connectedDevices;

    if (device.isEmpty) {
      isconnect = false;
    } else if (device.isNotEmpty) {
      isconnect = true;
      cndevice = device[0];
    }

    subscription = FlutterBluePlus.events.onConnectionStateChanged.listen((event) {
      if (mounted) {
        if (event.connectionState == BluetoothConnectionState.disconnected) {
          setState(() {
            isconnect = false;
          });
        } else if (event.connectionState == BluetoothConnectionState.connected) {
          setState(() {
            isconnect = true;
            cndevice = event.device;
          });
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  void testergetRawData2() async {
    String printUTCTime() {
      DateTime nowUTC = DateTime.now().toLocal();
      print(nowUTC);
      String utcString = nowUTC.toIso8601String();
      print(utcString);

      String result = utcString.substring(0, utcString.length - 1) + '+00:00';
      //String result = '2024-03-13T02:23:04.909893+00:00';
      return result;
    }

    List<Map<String, dynamic>> data = [];
    String finalData = '';
    String temdata = '';
    List<BluetoothService> services = await cndevice.discoverServices();
    String time = printUTCTime();
    int measureCount = 0;

    for (var service in services) {
      var characteristics = service.characteristics;
      for (BluetoothCharacteristic c in characteristics) {
        if (c.properties.write) {
          await c.write(utf8.encode("AT+MODE=1"));
          List<int> value = await c.read();
          String decodedString = String.fromCharCodes(value);
          print(decodedString);
          await c.setNotifyValue(true);

          await c.write(utf8.encode("AT+AUTO"));
          data = [];
          final subscription = c.lastValueStream.listen((value) {
            String hexString = value.map((number) => number.toRadixString(16).padLeft(2, '0').toUpperCase()).join('');

            const String atAutoHex = "41542B4155544F"; // "AT+AUTO"의 ASCII 값을 16진수로 변환한 값

            if (!hexString.contains(atAutoHex)) {
              if (hexString.endsWith('F00F') && hexString.length + temdata.length >= 1290) {
                temdata += hexString;
                finalData = temdata.substring(temdata.length - 1290);
                Map<String, dynamic> entry = {"rawData": finalData, "mesuredTime": time, "deviceType": 2};
                data.add(entry);
                print(finalData);
                temdata = '';
                print(data.length);
                measureCount++;
                _updateProgress(measureCount / 11.0);
                if (data.length >= 10) {
                  c.setNotifyValue(false);
                }
              } else {
                temdata += hexString;
              }
            }
          });

          await Future.delayed(const Duration(milliseconds: 10000));
          c.setNotifyValue(false);
          subscription.cancel();

          await FootprintApi.testfootScan(data).then((value) {
            _updateProgress(1.0); // API 업로드 완료 후 프로그래스 바를 100%로 설정

            print('footScanbool ' + value.toString());
            if (value == true) {
              context.pushNamed('testFootresult', extra: 'tester');
              AppStateNotifier.instance.testdivice2Up();
            }
            isscaning = false;
            _updateProgress(0.0);
          });
        }
      }
    }
  }

  void _updateProgress(double value) {
    setState(() {
      _progress = value;
    });
  }

  void testergetRawData1() async {
    List<String> testdata = [];
    String finalData = '';
    String temdata = '';
    List<BluetoothService> services = await cndevice.discoverServices();

    for (var service in services) {
      var characteristics = service.characteristics;
      for (BluetoothCharacteristic c in characteristics) {
        if (c.properties.write) {
          await c.setNotifyValue(true);
          await c.write(utf8.encode("AT+AUTO"));
          print('AT+AUTO');

          testdata = [];
          final subscription = c.lastValueStream.listen((value) {
            String hexString = value.map((number) => number.toRadixString(16).padLeft(2, '0').toUpperCase()).join('');
            print(hexString);
            const String atAutoHex = "41542B4155544F"; // "AT+AUTO"의 ASCII 값을 16진수로 변환한 값

            if (!hexString.contains(atAutoHex)) {
              if (hexString.endsWith('F00F') && hexString.length + temdata.length >= 2320) {
                temdata += hexString;
                finalData = temdata.substring(temdata.length - 2320);
                testdata.add(finalData);
                print(finalData);

                temdata = '';
                print(testdata.length);
                if (testdata.length >= 10) {
                  c.setNotifyValue(false);
                }
              } else {
                temdata += hexString;
              }
            }
          });

          await Future.delayed(const Duration(milliseconds: 10000));
          c.setNotifyValue(false);
          subscription.cancel();

          // await TesterScanApi.testfootScan(testdata).then((value) {
          //   print('footScanbool ' + value.toString());
          //   if (value == true) {
          //     context.pushNamed('testFootresult', extra: 'tester');
          //   }
          //   isscaning = false;
          // });
        }
      }
    }
  }

  @override
  void dispose() {
    // also, make sure you cancel the subscription when done!
    subscription.cancel();
    super.dispose();
  }

  bool isConnecting = false;
  BluetoothDevice? targetDevice;
  BluetoothDevice? targetDevice1;
  BluetoothDevice? targetDevice2;

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
      withNames: [name, 'Scale2'],
      timeout: Duration(seconds: 10),
    );

    var subscription = FlutterBluePlus.scanResults.listen(
      (results) async {
        for (ScanResult result in results) {
          print('${result.device.remoteId}: "${result.device.platformName}" found!');

          if (result.device.platformName == name || result.device.platformName == 'Scale2') {
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
    await Future.delayed(Duration(milliseconds: 500)); // 딜레이를 추가하여 안정성 확보
    subscription.cancel(); // 구독 취소
    await FlutterBluePlus.stopScan(); // 스캔 종료

    setState(() {
      isConnecting = false;
    });
    return resultscan;
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return Consumer<AppStateNotifier>(builder: (context, AppStateNotifier, child) {
      return GestureDetector(
        child: Scaffold(
            key: scaffoldKey,
            backgroundColor: AppColors.Black,
            appBar: AppBar(
              backgroundColor: Color(0x00CCFF8B),
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Icon(
                      Icons.circle,
                      size: 10,
                      color: isconnect ? AppColors.primary : AppColors.red,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Container(
                      height: 32,
                      width: 128,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: isconnect ? AppColors.primary : AppColors.red,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStateNotifier.device!,
                            style: AppFont.s12.overrides(color: AppColors.primaryBackground),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.cancel,
                    size: 20,
                  ),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment(0.0, 0.35),
                      width: double.infinity,
                      height: 400,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            AppColors.Black,
                            isconnect ? AppColors.primary : AppColors.red,
                            isconnect ? AppColors.primary : AppColors.red,
                            isconnect ? const Color.fromARGB(182, 205, 255, 139) : Color.fromARGB(89, 233, 88, 88),
                            Color.fromARGB(18, 26, 28, 33)
                          ],
                          center: Alignment(0.0, 0.3),
                          radius: 0.38,
                          stops: [0.85, 0.85, 0.86, 0.86, 1.0],
                        ),
                      ),
                      child: isconnect ? Image.asset('assets/images/footprint.png') : Image.asset('assets/images/footno.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Text(
                        isconnect
                            ? SetLocalizations.of(context).getText('scanPlantarPressureDescription')
                            : SetLocalizations.of(context).getText('scanPlantarPressureNoConnectionDescription'),
                        style: AppFont.r16.overrides(
                          color: isconnect ? AppColors.primary : AppColors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                      child: LinearProgressIndicator(
                        value: _progress,
                        backgroundColor: Colors.grey.shade300,
                        color: AppColors.DarkenGreen, // 프로그래스 바 색상
                        minHeight: 8.0,
                      ),
                    ),
                  ],
                ),
                isconnect
                    ? Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 40),
                        child: Container(
                          width: double.infinity,
                          height: 56.0,
                          child: LodingButtonWidget(
                            onPressed: () async {
                              setState(() {
                                isscaning = true;
                              });
                              widget.divice == 1 ? testergetRawData1() : testergetRawData2();
                            },
                            text: isscaning
                                ? SetLocalizations.of(context).getText('scanPlantarPressureButtonScanLabel')
                                : SetLocalizations.of(context).getText('scanPlantarPressureButtonStartLabel'),
                            options: LodingButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                              color: isscaning ? AppColors.Black : AppColors.primaryBackground,
                              textStyle: AppFont.s18.overrides(fontSize: 16, color: isscaning ? AppColors.Gray300 : AppColors.Black),
                              elevation: 0,
                              borderSide: BorderSide(
                                color: isscaning ? AppColors.Gray300 : AppColors.Black,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 40),
                        child: Container(
                          width: double.infinity,
                          height: 56.0,
                          child: LodingButtonWidget(
                            onPressed: () async {
                              await _searchAndConnect('Fisica Scale');
                              //t();
                            },
                            text: SetLocalizations.of(context).getText(
                              'scanPlantarPressureNoConnectionButtonConnectLabel' /* 다시연결 */,
                            ),
                            options: LodingButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                              color: AppColors.Black,
                              textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.primaryBackground),
                              elevation: 0,
                              borderSide: BorderSide(
                                color: AppColors.primaryBackground,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                      ),
              ],
            )),
      );
    });
  }
}
