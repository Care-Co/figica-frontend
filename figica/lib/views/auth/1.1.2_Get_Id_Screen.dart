import 'dart:developer';

import 'package:fisica/auth/auth_service.dart';
import 'package:fisica/utils/DialogManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fisica/index.dart';

class GetidWidget extends StatefulWidget {
  const GetidWidget({Key? key}) : super(key: key);

  @override
  _GetidWidgetState createState() => _GetidWidgetState();
}

class _GetidWidgetState extends State<GetidWidget> {
  final TextEditingController myController = TextEditingController();
  TextInputType keyboardType = TextInputType.text;
  String selectedValue = '+82';
  final AuthService _authService = AuthService();
  bool isLoading = false; // 로딩 상태 변수 추가

  String _inputType = 'none'; // 'email', 'phone', 'none'
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void _updateInputType(String newInputType) {
    if (_inputType != newInputType) {
      setState(() => _inputType = newInputType);
    }
  }

  String? get _emailValidator {
    String value = myController.text;
    if (value.isEmpty) {
      return '이메일을 입력해주세요.';
    } else if (!value.contains('@')) {
      return SetLocalizations.of(context).getText(
        'signupIdInputEmailError' /* @를 포함한 정확한 이메일을 입력해 주세요 */,
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
        'signupIdInputPhoneError' /* 010 */,
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

    Future<void> next() async {
      print('next');
      String input = myController.text;

      if (_inputType == 'email') {
        bool exists = await UserController.validate(input, _inputType);
        if (!exists) {
          FocusScope.of(context).unfocus();
          await DialogManager.showDialogByType(
              context: context,
              dialogType: _inputType + "sign",
              getupperButtonFunction: () {
                context.pushNamed('LandingScreen');
              },
              getlowerButtonFunction: () {
                context.safePop();
              }).then((value) => setState(() {}));
        } else {
          context.pushNamed('Set_pw', extra: input);
        }
      } else if (_inputType == 'phone') {
        final phoneNumberVal = selectedValue + myController.text.substring(1);
        setState(() {
          isLoading = true;
        }); // 로딩 상태를 true로 설정

        await UserController.validate(phoneNumberVal, _inputType).then((exists) async {
          if (!exists) {
            FocusScope.of(context).unfocus();
            await DialogManager.showDialogByType(
                context: context,
                dialogType: _inputType + "sign",
                getupperButtonFunction: () {
                  context.pushNamed('LandingScreen');
                },
                getlowerButtonFunction: () {
                  context.safePop();
                }).then((value) => setState(() {
                  isLoading = false;
                }));
          } else {
            await FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: phoneNumberVal,
              verificationCompleted: (PhoneAuthCredential credential) async {
                try {
                  await FirebaseAuth.instance.signInWithCredential(credential);
                  print("자동 인증 성공!");
                  setState(() {
                    isLoading = false;
                  });
                } catch (e) {
                  print('자동 인증 실패: $e');
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              verificationFailed: (FirebaseAuthException error) {
                print("인증 실패: ${error.message}");
                setState(() {
                  isLoading = false;
                });
              },
              codeSent: (String verificationId, int? forceResendingToken) {
                print("SMS 코드가 성공적으로 전송되었습니다!");
                AppStateNotifier.instance.updateSignUpState(true);
                AppStateNotifier.instance.UpverificationId(verificationId);
                context.pushNamed('singup_smscode');
                setState(() {
                  isLoading = false;
                });
              },
              codeAutoRetrievalTimeout: (String verificationId) {
                print("자동 검색 시간 초과");
              },
            );
          }
        });
      }
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
              'signupIdButtonReturnLabel' /* 계정 생성 */,
            ),
            style: AppFont.s18.overrides(color: AppColors.Gray700),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        backgroundColor: AppColors.primaryBackground,
        body: Stack(
          children: [
            SafeArea(
              top: true,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 40.0),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        SetLocalizations.of(context).getText(
                          'signupIdLabel' /* Fisica 아이디로 사용할 */,
                        ),
                        style: AppFont.b24,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomInputField(
                            controller: myController,
                            onStatusChanged: _updateInputType,
                            onSelected: (value) {
                              selectedValue = value;
                            },
                            onSubmitted: (p0) {
                              print("Selected value: $selectedValue");
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Container(
                          width: double.infinity,
                          height: 56.0,
                          child: LodingButtonWidget(
                            onPressed: () async {
                              print(_emailValidator != null && _phoneValidator != null);
                              _emailValidator != null && _phoneValidator != null ? print('Button pressed ...') : await next();
                            },
                            text: SetLocalizations.of(context).getText(
                              'signupIdButtonNextLabel' /* 다음 */,
                            ),
                            options: LodingButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                              color: _emailValidator != null && _phoneValidator != null ? AppColors.Gray200 : AppColors.Black,
                              textStyle: AppFont.s18.overrides(
                                fontSize: 16,
                                color: AppColors.primaryBackground,
                              ),
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
            ),
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.1),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
