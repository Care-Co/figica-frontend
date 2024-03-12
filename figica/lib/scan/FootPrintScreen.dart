import 'dart:convert';

import 'package:figica/scan/scandata.dart';
import 'package:figica/scan/Foot_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:figica/index.dart';

class FootPrint extends StatefulWidget {
  const FootPrint({Key? key}) : super(key: key);

  @override
  State<FootPrint> createState() => _FootPrintState();
}

class _FootPrintState extends State<FootPrint> {
  late StreamSubscription<BluetoothConnectionState> _connectionStateSubscription;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String ids = '';
  String devicename = '';
  late BluetoothDevice cndevice;
  bool isconnect = false;
  late dynamic subscription;
  late String rawdata = '';
  bool isscaning = false;

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

  Future<void> getData() async {
    String? tempData = await FootprintData.getdevicename();
    devicename = tempData!;
    print(devicename);
  }

  void getRawData() async {
    String finalData = '';
    String temdata = '';

    List<BluetoothService> services = await cndevice.discoverServices();
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

          final subscription = c.lastValueStream.listen((value) {
            String hexString = value.map((number) => number.toRadixString(16).padLeft(2, '0').toUpperCase()).join('');

            const String atAutoHex = "41542B4155544F"; // "AT+AUTO"의 ASCII 값을 16진수로 변환한 값

            if (!hexString.contains(atAutoHex)) {
              if (hexString.endsWith('F00F') && hexString.length + temdata.length >= 1290) {
                temdata += hexString;
                finalData = temdata.substring(temdata.length - 1290);
                c.setNotifyValue(false);
              } else {
                temdata += hexString;
              }
            } else {
              print('start');
            }
          });

          await Future.delayed(const Duration(milliseconds: 2000));
          subscription.cancel();
          print(finalData.length);
          if (finalData.isNotEmpty && finalData.length == 1290) {
            await FootprintData.footScan(finalData).then((value) {
              print('footScanbool ' + value.toString());
              if (value == true) {
                context.pushNamed('Footresult');
              }
              isscaning = false;
            });
            print("Final Data: $finalData");
          }
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
                        devicename,
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
        body: FutureBuilder(
            future: getData(), // 비동기 데이터 로드 함수
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("데이터 로딩 중 에러 발생"));
              }

              return Column(
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
                          isconnect ? SetLocalizations.of(context).getText('cmrwjdwnd') : SetLocalizations.of(context).getText('rlrldusrufhgkrdls'),
                          style: AppFont.r16.overrides(
                            color: isconnect ? AppColors.primary : AppColors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  isconnect
                      ? Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 12),
                          child: Container(
                            width: double.infinity,
                            height: 56.0,
                            child: LodingButtonWidget(
                              onPressed: () async {
                                setState(() {
                                  isscaning = true;
                                });
                                getRawData();
                              },
                              text: isscaning ? '측정중...' : '측정 시작하기',
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
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 12),
                          child: Container(
                            width: double.infinity,
                            height: 56.0,
                            child: LodingButtonWidget(
                              onPressed: () async {
                                context.goNamed('FindBlue');
                              },
                              text: SetLocalizations.of(context).getText(
                                'elqkdltmdus' /* 다시연결 */,
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
              );
            }),
      ),
    );
  }
}
