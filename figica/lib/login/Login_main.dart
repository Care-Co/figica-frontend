import '../flutter_set/flutter_drop_down.dart';
import '../flutter_set/Loding_button_widget.dart';
import '../flutter_set/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/index.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController myController = TextEditingController();
  String inputType = 'none';
  TextInputType keyboardType = TextInputType.text;
  String selectedValue = '+82';

  late String _verificationId;
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    authManager.handlePhoneAuthStateChanges(context);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  void _updateInputType(String status) {
    setState(() {
      inputType = status;
    });
  }

  @override
  void dispose() {
    myController.dispose();
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
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.primaryBackground,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.97,
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
                              controller: dropDownValueController ??= FormFieldController<String>(null),
                              options: [
                                '한국어',
                                'English',
                                '日本語',
                              ],
                              onChanged: (val) async {
                                setState(() => dropDownValue = val);
                                if (val == '한국어') {
                                  setAppLanguage(context, 'ko');
                                } else if (val == 'English') {
                                  setAppLanguage(context, 'en');
                                } else if (val == '日本語') {
                                  setAppLanguage(context, 'ja');
                                }
                              },
                              width: double.infinity,
                              height: 38.0,
                              textStyle: AppFont.r16.overrides(color: AppColors.Gray500),
                              hintText: '한국어',
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
                          //입력 필드
                          CustomInputField(
                            controller: myController,
                            onStatusChanged: _updateInputType,
                            onSelected: (value) {
                              selectedValue = value;
                              print("Selected value: $selectedValue");
                            },
                          )
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
                            child: LodingButtonWidget(
                              onPressed: () async {
                                if (inputType == 'none') {
                                } else if (inputType == 'phone') {
                                  String id = selectedValue + myController.text.substring(1);
                                  bool exists = await UserController.validate(id, inputType);
                                  //계정이 있으면
                                  if (exists) {
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
                                              child: LoginFailWidget(
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
                                  } else if (!exists) {
                                    FirebaseAuth _auth = FirebaseAuth.instance;
                                    await _auth.verifyPhoneNumber(
                                        phoneNumber: id,
                                        //timeout: const Duration(minutes: 5),
                                        verificationCompleted: (PhoneAuthCredential credential) async {
                                          print('인증 문자 수신');
                                        },
                                        verificationFailed: (FirebaseAuthException e) {
                                          print('인증 문자 전송 실패');
                                        },
                                        codeSent: (String verificationId, int? resendToken) async {
                                          print('인증 문자 전송');
                                          _verificationId = verificationId;
                                          context.pushNamed(
                                            'smscode',
                                            queryParameters: {'verificationId': _verificationId, 'phone': id, 'setinfo': 'false'},
                                          );
                                          setState(() {});
                                        },
                                        codeAutoRetrievalTimeout: (String verificationId) {});
                                  }
                                } else if (inputType == 'email') {
                                  String id = myController.text;
                                  bool exists = await UserController.validate(id, inputType);
                                  if (exists) {
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
                                              child: LoginFailWidget(
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
                                  } else if (!exists) {
                                    context.pushNamed('Input_pw', extra: id);
                                    FocusScope.of(context).unfocus();
                                  }
                                }
                              },
                              text: SetLocalizations.of(context).getText(
                                '20tycjvp' /* 로그인 */,
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
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () async {
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
                              child: LodingButtonWidget(
                                onPressed: () async {
                                  context.pushNamed('agree_tos');
                                },
                                text: SetLocalizations.of(context).getText(
                                  'f1vk38nh' /* 회원 가입하기 */,
                                ),
                                options: LodingButtonOptions(
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
