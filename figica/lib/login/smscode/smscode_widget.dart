import 'dart:async';

import 'package:figica/User_Controller.dart';
import 'package:figica/flutter_set/figica_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../flutter_set/App_icon_button.dart';
import '../../../flutter_set/flutter_flow_util.dart';
import '../../../flutter_set/Loding_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'smscode_model.dart';
export 'smscode_model.dart';

class SmscodeWidget extends StatefulWidget {
  final String verificationId;
  final String phone;
  const SmscodeWidget({Key? key, required this.verificationId, required this.phone}) : super(key: key);

  @override
  _SmscodeWidgetState createState() => _SmscodeWidgetState();
}

class _SmscodeWidgetState extends State<SmscodeWidget> {
  late SmscodeModel _model;
  int _seconds = 300; // 5 minutes in seconds
  bool _isActive = false;
  late Timer _timer;

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
    _model = createModel(context, () => SmscodeModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    _isActive ? null : _startTimer();
    _model.textController!.addListener(() {
      if (_model.textController!.text == _model.textController!.text) {
      } else {}
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  bool _errorText1() {
    final smsCodeVal = _model.textController.text;
    if (smsCodeVal == null || smsCodeVal.isEmpty || smsCodeVal.length != 6) {
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _model.dispose();
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
      onTap: () => _model.unfocusNode.canRequestFocus ? FocusScope.of(context).requestFocus(_model.unfocusNode) : FocusScope.of(context).unfocus(),
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
                '71suwd6k' /* 인증 번호 입력 */,
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
                              '952lmtxg' /* 인증번호 */,
                            ),
                            style: AppFont.s12),
                      ),
                      TextFormField(
                        controller: _model.textController,
                        focusNode: _model.textFieldFocusNode,
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
                                      'wowjsthd' /* 인증번호 재전송*/,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        style: AppFont.r16,
                        validator: _model.textControllerValidator.asValidator(context),
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
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: _model.textController.text);
                          try {
                            final getfiretoken = await FirebaseAuth.instance.signInWithCredential(credential);
                            final String? token = await getfiretoken.user?.getIdToken();
                            print("Token: $token");
                            await UserController.signUpWithPhone(token!, widget.phone);

                            context.goNamedAuth('userinfo', context.mounted);
                          } on FirebaseAuthException catch (e) {
                            print(e.code);
                            if (e.code == 'invalid-verification-code') {
                              print('틀림');
                              return false;
                            }
                          } catch (e) {
                            print(e);
                          }
                          return true;

                          //context.goNamedAuth('homePage', context.mounted);
                        },
                        text: SetLocalizations.of(context).getText(
                          't0ydhdm1' /* 인증하기 */,
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
                          't0ydhdm1' /* 인증하기 */,
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
