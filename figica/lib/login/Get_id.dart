import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:fisica/User_Controller.dart';
import 'package:fisica/components/SignUp_Fail.dart';
import 'package:fisica/flutter_set/App_icon_button.dart';
import 'package:fisica/flutter_set/fisica_theme.dart';
import 'package:fisica/login/custom_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/auth/firebase_auth/auth_util.dart';
import '../flutter_set/flutter_util.dart';
import '../flutter_set/Loding_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GetidWidget extends StatefulWidget {
  const GetidWidget({Key? key}) : super(key: key);

  @override
  _GetidWidgetState createState() => _GetidWidgetState();
}

class _GetidWidgetState extends State<GetidWidget> {
  final TextEditingController myController = TextEditingController();
  TextInputType keyboardType = TextInputType.text;
  String selectedValue = '+82';
  late String _verificationId;

  String inputType = 'none'; // 'email', 'phone', 'none'
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    authManager.handlePhoneAuthStateChanges(context);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    myController.dispose();

    super.dispose();
  }

  void _updateInputType(String status) {
    setState(() {
      inputType = status;
    });
  }

  String? get _emailValidator {
    String value = myController.text;
    if (value.isEmpty) {
      return '이메일을 입력해주세요.';
    } else if (!value.contains('@')) {
      return SetLocalizations.of(context).getText(
        '8u5gojh7' /* @를 포함한 정확한 이메일을 입력해 주세요 */,
      );
    }
    return null; // 유효한 경우 null을 반환
  }

  String? get _phoneValidator {
    String value = myController.text;
    if (value.isEmpty) {
      return '전화번호를 입력해주세요.';
    } else if (!value.startsWith('010')) {
      return SetLocalizations.of(context).getText(
        '8u5gojhdg' /* 010 */,
      );
    }
    return null;
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
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0x00CCFF8B),
          automaticallyImplyLeading: false,
          leading: AppIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 40.0,
            icon: Icon(
              Icons.chevron_left,
              color: AppColors.Gray700,
              size: 24.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
              SetLocalizations.of(context).getText(
                'tetwnigg' /* 계정 생성 */,
              ),
              style: AppFont.s18.overrides(color: AppColors.Gray700)),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        backgroundColor: AppColors.primaryBackground,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.9,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 30.0, 24.0, 0.0),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 22.0, 0.0, 0.0),
                        child: Text(
                            SetLocalizations.of(context).getText(
                              '3787orgg' /* ! */,
                            ),
                            style: AppFont.b24),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 190),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                child: Text(
                                    SetLocalizations.of(context).getText(
                                      'n7oaur8t' /* 전화 번호 또는 */,
                                    ),
                                    style: AppFont.s12),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 100.0),
                                child: CustomInputField(
                                  controller: myController,
                                  onStatusChanged: _updateInputType,
                                  onSelected: (value) {
                                    selectedValue = value;
                                    print("Selected value: $selectedValue");
                                  },
                                ),
                              ),
                              if (_emailValidator != null && _phoneValidator != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 56.0,
                                    child: LodingButtonWidget(
                                      onPressed: () {
                                        print('Button pressed ...');
                                      },
                                      text: SetLocalizations.of(context).getText(
                                        'c8ovbs6n' /* 다음 */,
                                      ),
                                      options: LodingButtonOptions(
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                        color: AppColors.Gray200,
                                        textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.primaryBackground),
                                        elevation: 0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                ),
                              if (_emailValidator == null || _phoneValidator == null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 56.0,
                                    decoration: BoxDecoration(),
                                    child: LodingButtonWidget(
                                      onPressed: () async {
                                        String input = myController.text;

                                        if (inputType == 'email') {
                                          bool exists = await UserController.validate(input, inputType);
                                          if (!exists) {
                                            FocusScope.of(context).unfocus();
                                            await showAlignedDialog(
                                              context: context,
                                              isGlobal: true,
                                              avoidOverflow: false,
                                              targetAnchor: AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
                                              followerAnchor: AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
                                              builder: (dialogContext) {
                                                return Material(
                                                  color: Colors.transparent,
                                                  child: GestureDetector(
                                                    child: Container(
                                                      height: 432,
                                                      width: 327,
                                                      child: SignupFailWidget(
                                                          onConfirmed: () {
                                                            setState(() {
                                                              myController.clear(); // 텍스트 필드 초기화
                                                            });
                                                          },
                                                          message: inputType),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then((value) => setState(() {}));
                                          } else {
                                            context.pushNamed('Set_pw', extra: input);
                                          }
                                        }
                                        if (inputType == 'phone') {
                                          final phoneNumberVal = selectedValue + myController.text.substring(1);

                                          bool exists = await UserController.validate(phoneNumberVal, inputType);
                                          if (!exists) {
                                            FocusScope.of(context).unfocus();
                                            await showAlignedDialog(
                                              context: context,
                                              isGlobal: true,
                                              avoidOverflow: false,
                                              targetAnchor: AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
                                              followerAnchor: AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
                                              builder: (dialogContext) {
                                                return Material(
                                                  color: Colors.transparent,
                                                  child: GestureDetector(
                                                    child: Container(
                                                      height: 432,
                                                      width: 327,
                                                      child: SignupFailWidget(
                                                          onConfirmed: () {
                                                            setState(() {
                                                              myController.clear(); // 텍스트 필드 초기화
                                                            });
                                                          },
                                                          message: inputType),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then((value) => setState(() {}));
                                          } else {
                                            FirebaseAuth _auth = FirebaseAuth.instance;
                                            await _auth.verifyPhoneNumber(
                                                phoneNumber: phoneNumberVal,
                                                //timeout: const Duration(minutes: 5),
                                                verificationCompleted: (PhoneAuthCredential credential) async {
                                                  print('인증 문자 수신');
                                                },
                                                verificationFailed: (FirebaseAuthException e) {
                                                  print(e);
                                                  print('인증 문자 전송 실패');
                                                },
                                                codeSent: (String verificationId, int? resendToken) async {
                                                  print('인증 문자 전송');
                                                  _verificationId = verificationId;
                                                  context.goNamed(
                                                    'smscode',
                                                    extra: {'verificationId': _verificationId, 'phone': phoneNumberVal, 'setinfo': 'true'},
                                                  );
                                                },
                                                codeAutoRetrievalTimeout: (String verificationId) {});
                                          }
                                        }
                                      },
                                      text: SetLocalizations.of(context).getText(
                                        '0sekgm29' /* 다음 */,
                                      ),
                                      options: LodingButtonOptions(
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                        color: AppColors.Black,
                                        textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.primaryBackground),
                                        elevation: 0,
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
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
