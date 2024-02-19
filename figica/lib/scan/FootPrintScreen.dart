import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:figica/index.dart';

class FootPrint extends StatefulWidget {
  const FootPrint({Key? key}) : super(key: key);

  @override
  State<FootPrint> createState() => _FootPrintState();
}

class _FootPrintState extends State<FootPrint> {
  BluetoothConnectionState _connectionState = BluetoothConnectionState.disconnected;

  late StreamSubscription<BluetoothConnectionState> _connectionStateSubscription;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String ids = '';
  String devicename = '';
  late BluetoothDevice device;
  bool isconnect = false;

  @override
  void initState() {
    super.initState();
    List<BluetoothDevice> devs = FlutterBluePlus.connectedDevices;
    if (devs.isNotEmpty) {
      isconnect = true;
    }
    FlutterBluePlus.events.onConnectionStateChanged.listen((event) {
      if (mounted) {
        if (event.connectionState == BluetoothConnectionState.disconnected) {
          setState(() {
            isconnect = false;
          });
        } else if (event.connectionState == BluetoothConnectionState.connected) {
          setState(() {
            isconnect = true;
          });
        }
      }
    });
    blue();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  void blue() async {
    await UserController.getdevicename().then((value) {
      devicename = value!;
    });
  }

  @override
  void dispose() {
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
                ? Container()
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
        ),
      ),
    );
  }
}
