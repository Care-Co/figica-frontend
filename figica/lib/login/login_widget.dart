import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:figica/components/Login_Fail.dart';
import 'package:figica/flutter_set/figica_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/auth/firebase_auth/auth_util.dart';
import '../flutter_set/flutter_drop_down.dart';
import '../flutter_set/flutter_flow_theme.dart';
import '../flutter_set/flutter_flow_util.dart';
import '../flutter_set/flutter_flow_widgets.dart';
import '../flutter_set/form_field_controller.dart';
import '../flutter_set/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'login_model.dart';
export 'login_model.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late LoginModel _model;
  String inputType = 'none'; // 'email', 'phone', 'none'
  String? selectedDropdownValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginModel());

    _model.phoneController ??= TextEditingController();
    _model.phoneFocusNode ??= FocusNode();

    _model.phoneController!.addListener(_onTextChanged);

    authManager.handlePhoneAuthStateChanges(context);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  void _onTextChanged() {
    String input = _model.phoneController!.text;
    if (input.length >= 2) {
      if (isNumeric(input.substring(0, 2))) {
        setState(() {
          inputType = 'phone';
        });
      } else if (isAlphabet(input.substring(0, 2))) {
        setState(() {
          inputType = 'email';
        });
      } else {
        setState(() {
          inputType = 'none';
        });
      }
    } else {
      setState(() {
        inputType = 'none';
      });
    }
  }

  String? get _errorText1 {
    final text = _model.phoneController!.text;
    if (!text.contains('@')) {
      return SetLocalizations.of(context).getText(
        '8u5gojh7' /* @를 포함한 정확한 이메일을 입력해 주세요 */,
      );
    }
    return null;
  }

  String? get _errorText2 {
    final text = _model.phoneController!.text;
    if (!text.startsWith('010')) {
      return SetLocalizations.of(context).getText(
        '8u5gojhdg' /* @를 포함한 정확한 이메일을 입력해 주세요 */,
      );
    }
    return null;
  }

  Future<bool> userExists(String phoneNumber) async {
    final text = _model.phoneController!.text;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: text, password: "!");
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'wrong-password') {
        print('중복');
        return false;
      }
    } catch (e) {
      print(e);
    }
    return true;
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  bool isAlphabet(String s) {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(s);
  }

  @override
  void dispose() {
    _model.dispose();

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
      onTap: () => _model.unfocusNode.canRequestFocus ? FocusScope.of(context).requestFocus(_model.unfocusNode) : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.primaryBackground,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 30.0, 24.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/symbol.png',
                            width: 83.0,
                            height: 79.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 22.0, 0.0, 0.0),
                          child: Text(
                              SetLocalizations.of(context).getText(
                                'zvrvccdi' /* 만나서 반가워요! */,
                              ),
                              style: AppFont.b24),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                          child: Text(
                              SetLocalizations.of(context).getText(
                                'yf2ziwdh' /* 시작하기 위해서는 로그인이 필요해요 */,
                              ),
                              style: AppFont.r16),
                        ),
                      ],
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                            child: Text(
                                SetLocalizations.of(context).getText(
                                  'z3hfyqtu' /* Language */,
                                ),
                                style: AppFont.s12),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                            child: FlutterDropDown<String>(
                              controller: _model.dropDownValueController ??= FormFieldController<String>(null),
                              options: [
                                SetLocalizations.of(context).getText(
                                  'cghjktxl' /* 한국어(Korea) */,
                                ),
                                SetLocalizations.of(context).getText(
                                  'b6fc2qid' /* 영어 */,
                                ),
                                SetLocalizations.of(context).getText(
                                  'hnwpccrg' /* 일본어 */,
                                )
                              ],
                              onChanged: (val) => setState(() => _model.dropDownValue = val),
                              width: double.infinity,
                              height: 38.0,
                              textStyle: AppFont.r16.overrides(color: AppColors.Gray500),
                              hintText: SetLocalizations.of(context).getText(
                                'o2i52qph' /* 한국어 */,
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: AppColors.Gray500,
                                size: 20.0,
                              ),
                              elevation: 2.0,
                              borderColor: AppColors.Gray200,
                              borderWidth: 1.0,
                              borderRadius: 8.0,
                              borderStyle: 'all',
                              margin: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                              hidesUnderline: true,
                              isSearchable: false,
                              isMultiSelect: false,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                            child: Text(
                                SetLocalizations.of(context).getText(
                                  'n7oaur8t' /* 전화 번호 또는 */,
                                ),
                                style: AppFont.s12),
                          ),
                          if (inputType == 'none')
                            TextFormField(
                              controller: _model.phoneController,
                              focusNode: _model.phoneFocusNode,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: SetLocalizations.of(context).getText(
                                  'n7oaur8tc',
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
                                    color: AppColors.Gray200,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.Gray200,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                suffixIcon: _model.phoneController.text.isNotEmpty
                                    ? InkWell(
                                        child: Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                            color: AppColors.Gray100, // 연한 회색 배경
                                            shape: BoxShape.circle,
                                          ),
                                          margin: EdgeInsets.all(14),
                                          child: Icon(
                                            Icons.clear, // 취소 아이콘 사용
                                            color: AppColors.Gray500, size: 10,
                                          ),
                                        ),
                                        onTap: () {
                                          _model.phoneController?.clear();
                                        },
                                      )
                                    : null,
                              ),
                              style: AppFont.r16.overrides(color: AppColors.Gray700),
                              validator: _model.phoneControllerValidator.asValidator(context),
                            ),
                          if (inputType == 'email')
                            TextFormField(
                              controller: _model.phoneController,
                              focusNode: _model.phoneFocusNode,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelStyle: AppFont.r16.overrides(color: AppColors.Gray500),
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
                                    color: AppColors.Gray200,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.Gray200,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                suffixIcon: _model.phoneController.text.isNotEmpty
                                    ? InkWell(
                                        child: Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                            color: AppColors.Gray100, // 연한 회색 배경
                                            shape: BoxShape.circle,
                                          ),
                                          margin: EdgeInsets.all(14),
                                          child: Icon(
                                            Icons.clear, // 취소 아이콘 사용
                                            color: AppColors.Gray500, size: 10,
                                          ),
                                        ),
                                        onTap: () {
                                          _model.phoneController?.clear();
                                        },
                                      )
                                    : null,
                                errorText: _errorText1,
                              ),
                              style: AppFont.r16.overrides(color: AppColors.Gray700),
                              keyboardType: TextInputType.emailAddress,
                              validator: _model.phoneControllerValidator.asValidator(context),
                            ),
                          if (inputType == 'phone')
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10.5, 0, 0),
                                    child: Column(
                                      children: [
                                        FlutterDropDown<String>(
                                          controller: _model.dropDownValueController2 ??= FormFieldController<String>(null),
                                          hintText: '+82',
                                          options: ['+1', '+91', '+82', '+81'],
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedDropdownValue = newValue;
                                            });
                                          },
                                          height: 38.0,
                                          textStyle: AppFont.r16.overrides(color: AppColors.Gray500),
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: AppColors.Gray500,
                                            size: 20.0,
                                          ),
                                          elevation: 2.0,
                                          borderColor: AppColors.Gray200,
                                          borderWidth: 1.0,
                                          borderRadius: 8.0,
                                          borderStyle: 'bottom',
                                          margin: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 4.0),
                                          hidesUnderline: true,
                                          isSearchable: false,
                                          isMultiSelect: false,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller: _model.phoneController,
                                    focusNode: _model.phoneFocusNode,
                                    autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelStyle: AppFont.r16,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.Gray200,
                                          width: 1.0,
                                        ),
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
                                      ),
                                      suffixIcon: _model.phoneController.text.isNotEmpty
                                          ? InkWell(
                                              child: Container(
                                                height: 10,
                                                width: 10,
                                                decoration: BoxDecoration(
                                                  color: AppColors.Gray100, // 연한 회색 배경
                                                  shape: BoxShape.circle,
                                                ),
                                                margin: EdgeInsets.all(14),
                                                child: Icon(
                                                  Icons.clear, // 취소 아이콘 사용
                                                  color: AppColors.Gray500, size: 10,
                                                ),
                                              ),
                                              onTap: () {
                                                _model.phoneController?.clear();
                                              },
                                            )
                                          : null,
                                      errorText: _errorText2,
                                    ),
                                    style: AppFont.r16.overrides(color: AppColors.Gray700),
                                    keyboardType: TextInputType.phone,
                                    validator: _model.phoneControllerValidator.asValidator(context),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 56.0,
                            child: FFButtonWidget(
                              onPressed: () async {
                                String id = _model.phoneController.text; // 전화번호 입력 필드에서 번호 가져오기
                                bool exists = await userExists(id);
                                if (!exists) {
                                  String email = _model.phoneController.text;
                                  // 로그인 화면으로 이동
                                  context.pushNamed(
                                    'Input_pw',
                                    queryParameters: {'email': email}.withoutNulls,
                                  );
                                } else {
                                  // 회원가입 화면으로 이동
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
                                          onTap: () => _model.unfocusNode.canRequestFocus
                                              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                              : FocusScope.of(context).unfocus(),
                                          child: Container(
                                            height: 432,
                                            width: 327,
                                            child: LoginFailWidget(
                                                onConfirmed: () {
                                                  setState(() {
                                                    _model.phoneController?.clear(); // 텍스트 필드 초기화
                                                  });
                                                },
                                                message: inputType),
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) => setState(() {}));
                                }
                              },
                              text: SetLocalizations.of(context).getText(
                                '20tycjvp' /* 로그인 */,
                              ),
                              options: FFButtonOptions(
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
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () {
                                print('object');
                                context.pushNamed('check_email');
                              },
                              child: Text(
                                style: AppFont.r16.overrides(
                                  fontSize: 12,
                                  color: AppColors.Gray500,
                                  decoration: TextDecoration.underline,
                                ),
                                SetLocalizations.of(context).getText(
                                  'f1vk38cs' /* 전화번호 변경 */,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Divider(
                                  color: AppColors.Gray200,
                                  thickness: 1.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text('OR', style: AppFont.r16.overrides(color: AppColors.Gray200, fontSize: 12)),
                              ),
                              Expanded(
                                child: Divider(
                                  color: AppColors.Gray200,
                                  thickness: 1.0,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              width: double.infinity,
                              height: 56.0,
                              child: FFButtonWidget(
                                onPressed: () async {
                                  context.pushNamed('agree_tos');
                                },
                                text: SetLocalizations.of(context).getText(
                                  'f1vk38nh' /* 회원 가입하기 */,
                                ),
                                options: FFButtonOptions(
                                  height: 40.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                  color: AppColors.primaryBackground,
                                  textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.Black),
                                  elevation: 0,
                                  borderSide: BorderSide(
                                    color: AppColors.Black,
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
