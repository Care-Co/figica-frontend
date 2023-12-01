import 'package:figica/flutter_set/App_icon_button.dart';
import 'package:figica/flutter_set/figica_theme.dart';

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

class GetidWidget extends StatefulWidget {
  const GetidWidget({Key? key}) : super(key: key);

  @override
  _GetidWidgetState createState() => _GetidWidgetState();
}

class _GetidWidgetState extends State<GetidWidget> {
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
                        child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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
                              autofocus: false,
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
                                    autofocus: false,
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
                        ]),
                      ),
                    ),
                    if (_errorText1 != null && _errorText2 != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Container(
                          width: double.infinity,
                          height: 56.0,
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: SetLocalizations.of(context).getText(
                              'c8ovbs6n' /* 다음 */,
                            ),
                            options: FFButtonOptions(
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
                    if (_errorText1 == null || _errorText2 == null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Container(
                          width: double.infinity,
                          height: 56.0,
                          decoration: BoxDecoration(),
                          child: FFButtonWidget(
                            onPressed: () async {
                              String input = _model.phoneController.text;
                              if (inputType == 'email') {
                                context.pushNamed(
                                  'Set_pw',
                                  queryParameters: {'email': input}.withoutNulls,
                                );
                              }
                              if (inputType == 'phone') {
                                final phoneNumberVal = _model.dropDownValueController2!.value.toString() + input;

                                await authManager.beginPhoneAuth(
                                  context: context,
                                  phoneNumber: phoneNumberVal,
                                  onCodeSent: (context) async {
                                    context.goNamedAuth(
                                      'certify',
                                      context.mounted,
                                      ignoreRedirect: true,
                                    );
                                  },
                                );
                              }
                            },
                            text: SetLocalizations.of(context).getText(
                              '0sekgm29' /* 다음 */,
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
