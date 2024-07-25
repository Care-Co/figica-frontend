import 'dart:developer';

import 'package:fisica/auth/auth_service.dart';

import '../../widgets/flutter_drop_down.dart';
import '../../utils/form_field_controller.dart';
import 'package:flutter/material.dart';

import '/index.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final AuthService _authService = AuthService();
  final TextEditingController _myController = TextEditingController();
  String _inputType = 'none';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextInputType keyboardType = TextInputType.text;
  String selectedValue = '+82';

  late String _verificationId;
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;

  @override
  void initState() {
    super.initState();
    Locale? locale = SetLocalizations.getStoredLocale();
    if (locale != null) {
      dropDownValue = '${locale.languageCode}' == 'ko' ? '한국어' : 'English';
      print(dropDownValue);
      print('Stored locale: ${locale.languageCode}_${locale.countryCode}');
    } else {
      print('No locale stored');
    }
  }

  void _updateInputType(String newInputType) {
    if (_inputType != newInputType) {
      setState(() => _inputType = newInputType);
    }
  }

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      onVerticalDragStart: (details) => FocusScope.of(context).unfocus(), // 수직 드래그 종료 시 키보드 숨김
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.primaryBackground,
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 30.0, 24.0, 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeader(context),
                CustomInputField(
                  controller: _myController,
                  onStatusChanged: _updateInputType,
                  onSelected: (value) {
                    selectedValue = value;
                    print("Selected value: $selectedValue");
                  },
                  onSubmitted: (value) {
                    print("Selected value: $selectedValue");
                    _handleOnPressed;
                  },
                ),
                _buildLanguageDropDown(context),
                SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    _buildLoginButton(context),
                    _buildphoneButton(context),
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
                    _buildSingupButton(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleOnPressed() async {
    if (_inputType == 'none') return;
    String id = _inputType == 'phone' ? selectedValue + _myController.text.substring(1) : _myController.text;
    bool exists = await UserController.validate(id, _inputType);
    print(exists);
    if (exists) {
      await _showLoginFailDialog();
    } else {
      if (_inputType == 'phone') {
        AppStateNotifier.instance.Uptype('phone');
        await _handlePhoneVerification(id);
        FocusScope.of(context).unfocus();
      } else if (_inputType == 'email') {
        AppStateNotifier.instance.Uptype('email');
        AppStateNotifier.instance.updateSignUpState(false);
        AppStateNotifier.instance.updateloginState(true);
        context.pushNamed('Input_pw', extra: id);
        FocusScope.of(context).unfocus();
      }
    }
  }

  Future<void> _showLoginFailDialog() async {
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
                  setState(_myController.clear);
                },
                message: _inputType,
              ),
            ),
          ),
        );
      },
    ).then((value) => setState(() {}));
  }

  Future<void> _handlePhoneVerification(String id) async {
    print(id);

    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: id,
      verificationCompleted: (PhoneAuthCredential) {},
      verificationFailed: (error) {
        // 오류 메시지 출력 및 처리
        print("인증 실패: ${error.code}");
        print("인증 실패: ${error.message}");
        print("인증 실패: ${error.tenantId}");
        AppStateNotifier.instance.updateloginState(false);
      },
      codeSent: (verificationId, forceResendingToken) {
        print("SMS 코드가 성공적으로 전송되었습니다!");
        AppStateNotifier.instance.updateSignUpState(false);
        AppStateNotifier.instance.updateloginState(true);
        AppStateNotifier.instance.UpverificationId(verificationId);
        // Navigator.push(context, MaterialPageRoute(builder: (context) => SmscodeWidget(verificationId: verificationId, isSingUp: true)));
        context.pushNamed('smscode');
      },
      codeAutoRetrievalTimeout: (verificationId) {
        print("자동 검색 시간 초과");
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/symbol.png',
                width: 83,
                height: 79,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                Text(version),
                LodingButtonWidget(
                  onPressed: () async {
                    context.goNamed('Test_guide');
                  },
                  text: '테스트 모드',
                  options: LodingButtonOptions(
                    height: 30.0,
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
              ],
            ), // Version should be dynamic if needed
          ],
        ),
        const SizedBox(height: 8),
        Text(
            SetLocalizations.of(context).getText(
              'loginHomeLabel',
              /* 만나서 반가워요! */
            ),
            style: AppFont.b24),
        const SizedBox(height: 4),
        Text(
            SetLocalizations.of(context).getText('loginHomeDescription' /* 시작하기 위해서는 로그인이 필요해요 */
                ),
            style: AppFont.r16),
      ],
    );
  }

  Widget _buildLanguageDropDown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Language', style: TextStyle(fontSize: 12)),
        const SizedBox(height: 8),
        FlutterDropDown<String>(
          controller: dropDownValueController ??= FormFieldController<String>(dropDownValue),
          options: [
            '한국어',
            'English',
            //'日本語',
          ],
          onChanged: (val) async {
            setState(() => dropDownValue = val);
            if (val == '한국어') {
              setAppLanguage(context, 'ko');
            } else if (val == 'English') {
              setAppLanguage(context, 'en');
            }
            // else if (val == '日本語') {
            //   setAppLanguage(context, 'ja');
            // }
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
        // Include your Dropdown code here
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 56.0,
        child: LodingButtonWidget(
          onPressed: _handleOnPressed,
          text: SetLocalizations.of(context).getText('loginHomeButtonLoginLabel'), // "로그인"
          options: LodingButtonOptions(
            height: 40.0,
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
            iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
            color: AppColors.Black,
            textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.primaryBackground),
            elevation: 0,
            borderSide: BorderSide(color: Colors.transparent, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ));
  }

  Widget _buildSingupButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56.0,
      child: LodingButtonWidget(
        onPressed: () async {
          context.pushNamed('agree_tos');
        },
        text: SetLocalizations.of(context).getText('loginHomeButtonSignupLabel' /* 회원 가입하기 */
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
    );
  }

  Widget _buildphoneButton(BuildContext context) {
    return InkWell(
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
          'loginHomeButtonFindPasswordLabel' /* 전화번호 변경 */,
        ),
      ),
    );
  }

  void _login() {
    // Implement your login logic here
  }
}
