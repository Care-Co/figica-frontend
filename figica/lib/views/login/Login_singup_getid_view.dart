import 'package:fisica/auth/auth_service.dart';
import 'package:fisica/views/login/login_components/Login_SignUp_Fail.dart';

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

  String inputType = 'none'; // 'email', 'phone', 'none'
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

  void _onSmsCodeSent() {
    print("SMS 코드가 성공적으로 전송되었습니다!");
    context.pushNamed('smscode');
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
                                            await _authService.sendSmsCode(phoneNumberVal, true, _onSmsCodeSent);
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
