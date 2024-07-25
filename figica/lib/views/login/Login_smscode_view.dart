import 'dart:math';

import 'package:fisica/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SmscodeWidget extends StatefulWidget {
  const SmscodeWidget({Key? key}) : super(key: key);

  @override
  _SmscodeWidgetState createState() => _SmscodeWidgetState();
}

class _SmscodeWidgetState extends State<SmscodeWidget> {
  int _seconds = 300; // 5 minutes in seconds
  bool _isActive = false;
  late Timer _timer;
  final TextEditingController myController = TextEditingController();
  final myfocusNode = FocusNode();

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_seconds == 0) {
        _resetTimer();
        // Perform any action when the timer reaches 0
      } else {
        setState(() {
          _seconds--;
        });
      }
    });
    setState(() {
      _isActive = true;
    });
  }

  void _resetTimer() {
    _timer.cancel();
    setState(() {
      _seconds = 300; // Reset to 5 minutes
      _isActive = false;
    });
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _isActive ? null : _startTimer();
    myController.addListener(() {
      if (myController.text == myController.text) {
      } else {}
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  bool _errorText1() {
    final smsCodeVal = myController.text;
    if (smsCodeVal == null || smsCodeVal.isEmpty || smsCodeVal.length != 6) {
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
    String seconds = (_seconds % 60).toString().padLeft(2, '0');
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.primaryBackground,
        appBar: AppBar(
          backgroundColor: Color(0x00CCFF8B),
          automaticallyImplyLeading: false,
          leading: AppIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
              SetLocalizations.of(context).getText(
                'changePhoneCertifyButtonReturnLabel' /* 인증 번호 입력 */,
              ),
              style: AppFont.s18.overrides(color: AppColors.Black)),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 200.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 32.0, 0.0, 0.0),
                        child: Text(
                            SetLocalizations.of(context).getText(
                              'changePhoneCertifyInputNumberLabel' /* 인증번호 */,
                            ),
                            style: AppFont.s12),
                      ),
                      TextFormField(
                        controller: myController,
                        focusNode: myfocusNode,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.Gray200,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.Gray200,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.Gray200,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.Gray200,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          suffixIcon: InkWell(
                              focusNode: FocusNode(skipTraversal: true),
                              onTap: () {
                                _resetTimer();

                                _startTimer();
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    SetLocalizations.of(context).getText(
                                      'changePhoneCertifyButtonRetryLabel' /* 인증번호 재전송*/,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        style: AppFont.r16,
                      ),
                      Text('$minutes:$seconds')
                    ],
                  ),
                ),
                if (_errorText1())
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 40.0),
                    child: Container(
                      width: double.infinity,
                      height: 56.0,
                      child: LodingButtonWidget(
                        onPressed: () async {
                          await UserController.AuthPhone(AppStateNotifier.instance.verificationId!, myController.text).then((value) {
                            if (value) {
                              if (AppStateNotifier.instance.isSignUp) {
                                context.goNamed('singup_userinfo');
                              } else {
                                AppStateNotifier.instance.updateloginState(false);
                                context.goNamed('home');
                              }
                            }
                          });
                        },
                        text: SetLocalizations.of(context).getText(
                          'changePhoneCertifyButtonConfirmLabel' /* 인증하기 */,
                        ),
                        options: LodingButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                          color: AppColors.Black,
                          textStyle: AppFont.s12.overrides(fontSize: 16, color: AppColors.primaryBackground),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                if (!_errorText1())
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 40.0),
                    child: Container(
                      width: double.infinity,
                      height: 56.0,
                      child: LodingButtonWidget(
                        onPressed: () async {
                          print('no');
                        },
                        text: SetLocalizations.of(context).getText(
                          'changePhoneCertifyButtonConfirmLabel' /* 인증하기 */,
                        ),
                        options: LodingButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                          color: AppColors.Gray200,
                          textStyle: AppFont.s12.overrides(fontSize: 16, color: AppColors.primaryBackground),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
