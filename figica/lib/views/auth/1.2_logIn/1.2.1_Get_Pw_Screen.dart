import 'package:fisica/auth/auth_service.dart';
import 'package:fisica/components/resetPw.dart';
import 'package:fisica/utils/DialogManager.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/index.dart';

class getPwScreen extends StatefulWidget {
  final String email;
  const getPwScreen({Key? key, required this.email}) : super(key: key);

  @override
  _getPwScreenState createState() => _getPwScreenState();
}

class _getPwScreenState extends State<getPwScreen> {
  final AuthService _authService = AuthService();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController pwController = TextEditingController();
  final pwFocusNode = FocusNode();
  bool pwVisibility = true;
  int count = 0;
  String? Function(BuildContext, String?)? pwControllerValidator;

  @override
  void initState() {
    super.initState();

    pwController.addListener(() {
      if (_isValidPassword(pwController.text)) {
      } else {}
      setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
      FocusScope.of(context).requestFocus(pwFocusNode);
    });
  }

  bool _isValidPassword(String password) {
    return password.length >= 6;
  }

  Future<bool> _userExists() async {
    final pw = pwController.text;
    print(widget.email);
    print(pw);
    await UserController.signInWithEmail(widget.email, pw).then((value) async {
      if (value) {
        await UserController.validateLogin(true, widget.email);
        AppStateNotifier.instance.updateloginState(false);
        context.goNamed('home');
      } else {
        UserController.validateLogin(false, widget.email).then((validateData) async {
          print(validateData);
          if (validateData != null) {
            int attemptsCount = validateData.attemptsCount;
            if (attemptsCount < 5) {
              await DialogManager.showDialogByType(
                context: context,
                dialogType: 'pwfail',
                getupperButtonFunction: () {
                  setState(() {
                    pwController.clear();
                    findPw();
                  });
                },
                getlowerButtonFunction: () {
                  context.safePop();
                },
              ).then((value) => setState(() {}));
            } else if (attemptsCount >= 5) {
              //context.goNamed('home');
              await DialogManager.showDialogByType(
                context: context,
                dialogType: 'over',
                getupperButtonFunction: () {
                  context.goNamed('home');
                },
                getlowerButtonFunction: () {},
              );
              // Timer(Duration(seconds: 5), () {
              //   if (Navigator.canPop(context)) {
              //     Navigator.pop(context);
              //   }
              // });
            }
          } else {
            print('Login validation failed or user does not exist.');
          }
        });
      }
    });
    return true;
  }

  void findPw() async {
    print(widget.email);
    try {
      await _authService.resetPassword(
        email: widget.email,
        context: context,
      );
      await DialogManager.showDialogByType(
              context: context,
              dialogType: 'resetPW',
              getupperButtonFunction: () {
                context.goNamed('LandingScreen');
              },
              getlowerButtonFunction: () {})
          .then((value) => setState(() {}));
    } on FirebaseAuthException catch (e) {
      print(e.code);
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  String? get _errorText1 {
    final text = pwController.text;
    if (!_isValidPassword(text)) {
      return SetLocalizations.of(context).getText(
        'changePasswordInputPasswordError' /* 8 - 24자의 영문 대/소문자, 숫자, 특수문자를 사용해 주세요 */,
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
      onVerticalDragStart: (details) => FocusScope.of(context).unfocus(), // 수직 드래그 종료 시 키보드 숨김

      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.primaryBackground,
        appBar: AppBar(
          backgroundColor: AppColors.primaryBackground,
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
                'completeLoginButtonReturnLabel' /* 로그인 */,
              ),
              style: AppFont.s18.overrides(color: AppColors.Gray700)),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
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
                          'completeLoginLabel' /* 비밀번호를\n입력해주세요*/,
                        ),
                        style: AppFont.b24),
                  ),
                  Container(
                    child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                        child: Text(
                            SetLocalizations.of(context).getText(
                              'completeLoginInputPasswordLabel' /* 전화 번호 또는 */,
                            ),
                            style: AppFont.s12),
                      ),
                      TextFormField(
                        controller: pwController,
                        focusNode: pwFocusNode,
                        autofocus: false,
                        obscureText: pwVisibility,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () => setState(
                              () => pwVisibility = !pwVisibility,
                            ),
                            focusNode: FocusNode(skipTraversal: true),
                            child: Icon(
                              pwVisibility ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: Color(0xFF757575),
                              size: 15,
                            ),
                          ),
                          hintText: SetLocalizations.of(context).getText(
                            'completeLoginInputPasswordHint', /* password */
                          ),
                          hintStyle: AppFont.r16.overrides(color: AppColors.Gray300),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.Gray200,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.Gray200,
                              width: 2.0,
                            ),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.red,
                              width: 2.0,
                            ),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.red,
                              width: 2.0,
                            ),
                          ),
                        ),
                        style: AppFont.r16.overrides(color: AppColors.Gray700),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: () async {
                              findPw();
                              print('pw');
                            },
                            child: Text(
                              style: AppFont.r16.overrides(
                                fontSize: 12,
                                color: AppColors.Gray500,
                                decoration: TextDecoration.underline,
                              ),
                              SetLocalizations.of(context).getText(
                                'completeLoginButtonFindPasswordLabel' /* 비밀번호 찾기 */,
                              ),
                            ),
                          ),
                        ),
                        if (_errorText1 != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Container(
                              width: double.infinity,
                              height: 56.0,
                              child: LodingButtonWidget(
                                onPressed: () {
                                  print('Button pressed ...');
                                },
                                text: SetLocalizations.of(context).getText(
                                  'completeLoginButtonReturnLabel' /* 다음 */,
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
                        if (_errorText1 == null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Container(
                              width: double.infinity,
                              height: 56.0,
                              decoration: BoxDecoration(),
                              child: LodingButtonWidget(
                                onPressed: _userExists,
                                text: SetLocalizations.of(context).getText(
                                  'completeLoginButtonReturnLabel' /* 다음 */,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}