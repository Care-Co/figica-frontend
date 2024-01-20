import 'package:figica/flutter_set/App_icon_button.dart';
import 'package:figica/flutter_set/figica_theme.dart';
import 'package:figica/User_Controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../flutter_set/flutter_flow_util.dart';
import '../flutter_set/Loding_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_model.dart';
export 'login_model.dart';

class SetPwWidget extends StatefulWidget {
  final String email;

  const SetPwWidget({Key? key, required this.email}) : super(key: key);

  @override
  _SetPwWidgetState createState() => _SetPwWidgetState();
}

class _SetPwWidgetState extends State<SetPwWidget> {
  late LoginModel _model;
  String inputType = 'none'; // 'email', 'phone', 'none'
  String? selectedDropdownValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    print(widget.email);
    _model = createModel(context, () => LoginModel());

    _model.pwController ??= TextEditingController();
    _model.pwFocusNode ??= FocusNode();

    _model.pw2Controller ??= TextEditingController();
    _model.pw2FocusNode ??= FocusNode();

    _model.pwController!.addListener(() {
      if (_isValidPassword(_model.pwController!.text)) {
      } else {}
      setState(() {});
    });

    // 비밀번호 확인 텍스트필드의 리스너 추가
    _model.pw2Controller!.addListener(() {
      if (_model.pw2Controller!.text == _model.pwController!.text) {
      } else {}
      setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  bool _isValidPassword(String password) {
    return password.length >= 8 && password.length <= 24 && RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[\W_]).+$').hasMatch(password);
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  String? get _errorText1 {
    final text = _model.pwController!.text;
    if (!_isValidPassword(text)) {
      return SetLocalizations.of(context).getText(
        '8u5gojhte' /* 8 - 24자의 영문 대/소문자, 숫자, 특수문자를 사용해 주세요 */,
      );
    }
    return null;
  }

  String? get _errorText2 {
    final text = _model.pw2Controller!.text;
    final originalPassword = _model.pwController!.text;
    if (text != originalPassword) {
      setState(() {});
      return SetLocalizations.of(context).getText(
        '8u5gojhch' /* 입력한 비밀번호가 일치하지 않습니다. */,
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
      onTap: () => _model.unfocusNode.canRequestFocus ? FocusScope.of(context).requestFocus(_model.unfocusNode) : FocusScope.of(context).unfocus(),
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
                'tetwnipp' /* 계정 생성 */,
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
                            '3787orpp' /* 만나서 반가워요! */,
                          ),
                          style: AppFont.b24),
                    ),
                    Container(
                      child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                          child: Text(
                              SetLocalizations.of(context).getText(
                                'c8ovbspp' /* 전화 번호 또는 */,
                              ),
                              style: AppFont.s12),
                        ),
                        TextFormField(
                          controller: _model.pwController,
                          focusNode: _model.pwFocusNode,
                          autofocus: false,
                          obscureText: !_model.pwVisibility,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () => setState(
                                () => _model.pwVisibility = !_model.pwVisibility,
                              ),
                              focusNode: FocusNode(skipTraversal: true),
                              child: Icon(
                                _model.pwVisibility ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                color: Color(0xFF757575),
                                size: 15,
                              ),
                            ),
                            hintText: SetLocalizations.of(context).getText(
                              '0sekgmpp', /* password */
                            ),
                            hintStyle: AppFont.r16.overrides(color: AppColors.Gray300),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.Gray200,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.Gray200,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.red,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.red,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorText: _errorText1,
                          ),
                          style: AppFont.r16.overrides(color: AppColors.Gray700),
                          validator: _model.pwControllerValidator.asValidator(context),
                        ),
                        /*-----------------------비밀번호 확인-----------------------------*/
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                          child: Text(
                              SetLocalizations.of(context).getText(
                                'soukj6pp' /* 비밀번호 확인 */,
                              ),
                              style: AppFont.s12),
                        ),
                        TextFormField(
                          controller: _model.pw2Controller,
                          focusNode: _model.pw2FocusNode,
                          autofocus: false,
                          obscureText: !_model.pw2Visibility,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () => setState(
                                () => _model.pw2Visibility = !_model.pw2Visibility,
                              ),
                              focusNode: FocusNode(skipTraversal: true),
                              child: Icon(
                                _model.pw2Visibility ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                color: Color(0xFF757575),
                                size: 15,
                              ),
                            ),
                            hintText: SetLocalizations.of(context).getText(
                              '0sekgmpp', /* password */
                            ),
                            hintStyle: AppFont.r16.overrides(color: AppColors.Gray300),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.Gray200,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.Gray200,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.red,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.red,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorText: _errorText2,
                          ),
                          style: AppFont.r16.overrides(color: AppColors.Gray700),
                          validator: _model.pw2ControllerValidator.asValidator(context),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 94, 0, 0),
                      child: Column(
                        children: [
                          if (_errorText1 != null || _errorText2 != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 40),
                              child: Container(
                                width: double.infinity,
                                height: 56.0,
                                child: LodingButtonWidget(
                                  onPressed: () {},
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
                          if (_errorText1 == null && _errorText2 == null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 40),
                              child: Container(
                                width: double.infinity,
                                height: 56.0,
                                decoration: BoxDecoration(),
                                child: LodingButtonWidget(
                                  onPressed: () async {
                                    GoRouter.of(context).prepareAuthEvent();

                                    try {
                                      bool singup = await UserController.signUpWithEmail(widget.email, _model.pwController.text);
                                      if (singup) {
                                        context.goNamedAuth('userinfo', context.mounted);
                                      } else {
                                        print('Failed to create ');
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text("회원가입 실패"),
                                          ),
                                        );
                                      }
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'weak-password') {
                                        print('The password provided is too weak.');
                                      } else if (e.code == 'email-already-in-use') {
                                        print('The account already exists for that email.');
                                      }
                                    } catch (e) {
                                      print(e);
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
