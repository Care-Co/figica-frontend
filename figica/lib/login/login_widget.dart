import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:figica/components/Login_Fail.dart';
import 'package:figica/flutter_set/figica_theme.dart';
import 'package:figica/login/custom_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
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

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController myController = TextEditingController();
  String inputType = 'none';
  TextInputType keyboardType = TextInputType.text;
  String? selectedDropdownValue;
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

  Future<bool> userExists(String phoneNumber) async {
    final text = myController.text;

    var url = Uri.parse('http://203.232.210.68:8080/api/user/validate');
    var headers = {'accept': '*/*', 'Content-Type': 'application/json'};
    var body = jsonEncode({'email': text});

    try {
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  void _updateInputType(String status) {
    setState(() {
      inputType = status;
    });
  }

  Future<bool> userExistsphone(String phoneNumber) async {
    final text = myController.text;
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

  @override
  void dispose() {
    dispose();

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
                              onChanged: (val) => setState(() => dropDownValue = val),
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
                          CustomInputField(
                            controller: myController,
                            onStatusChanged: _updateInputType,
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
                            child: FFButtonWidget(
                              onPressed: () async {
                                if (inputType == 'none') {
                                  print('none');
                                } else if (inputType == 'phone') {
                                  String id = myController.text;
                                  bool exists = await userExists(id);
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
                                    FocusScope.of(context).unfocus();
                                    String id = myController.text.substring(1);
                                    final phoneNumberVal = id;
                                    print(phoneNumberVal.toString());
                                    FirebaseAuth _auth = FirebaseAuth.instance;
                                    await _auth.verifyPhoneNumber(
                                        phoneNumber: phoneNumberVal,
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
                                            queryParameters: {
                                              'verificationId': _verificationId,
                                              'phone': phoneNumberVal,
                                            }.withoutNulls,
                                          );
                                        },
                                        codeAutoRetrievalTimeout: (String verificationId) {});
                                  }
                                } else if (inputType == 'email') {
                                  String id = myController.text;
                                  bool exists = await userExists(id);
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
                                                      myController?.clear(); // 텍스트 필드 초기화
                                                    });
                                                  },
                                                  message: inputType),
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => setState(() {}));
                                  } else if (!exists) {
                                    context.pushNamed(
                                      'Input_pw',
                                      queryParameters: {'email': id}.withoutNulls,
                                    );
                                    FocusScope.of(context).unfocus();
                                  }
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
