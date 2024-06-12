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
                _buildLanguageDropDown(context),
                _buildPhoneNumberInput(context),
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
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

    String id = getIdForInputType();
    bool exists = await UserController.validate(id, _inputType);
    print(exists);
    if (exists) {
      await _showLoginFailDialog();
    } else {
      if (_inputType == 'phone') {
        await _authService.sendSmsCode(id, false, _onSmsCodeSent);
      } else if (_inputType == 'email') {
        _navigateToPasswordInput(id);
      }
    }
  }

  String getIdForInputType() {
    return _inputType == 'phone' ? selectedValue + _myController.text.substring(1) : _myController.text;
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

  void _onSmsCodeSent() {
    print("SMS 코드가 성공적으로 전송되었습니다!");
    context.pushNamed('smscode');
  }

  Future<void> _handlePhoneVerification(String id) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.verifyPhoneNumber(
      phoneNumber: id,
      verificationCompleted: (PhoneAuthCredential credential) async {
        if (mounted) {
          print('인증 문자 수신');
          // 필요한 추가 로직
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        if (mounted) {
          print('인증 문자 전송 실패');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        if (mounted) {
          print('인증 문자 전송');
          _verificationId = verificationId;
          Navigator.of(context).pushNamed('smscode', arguments: {'verificationId': _verificationId, 'phone': id, 'setinfo': 'false'});
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        if (mounted) {
          // 타임아웃 로직 처리
        }
      },
    );
  }

  void _navigateToPasswordInput(String id) {
    context.pushNamed('Input_pw', extra: id);
    FocusScope.of(context).unfocus();
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
              'zvrvccdi' /* 만나서 반가워요! */,
            ),
            style: AppFont.b24),
        const SizedBox(height: 4),
        Text(
            SetLocalizations.of(context).getText(
              'yf2ziwdh' /* 시작하기 위해서는 로그인이 필요해요 */,
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
        // Include your Dropdown code here
      ],
    );
  }

  Widget _buildPhoneNumberInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            SetLocalizations.of(context).getText(
              'n7oaur8t' /* 전화 번호 또는 */,
            ),
            style: AppFont.s12),
        const SizedBox(height: 8),
        CustomInputField(
          controller: _myController,
          onStatusChanged: _updateInputType,
          onSelected: (value) {
            selectedValue = value;
            print("Selected value: $selectedValue");
          },
        )
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 56.0,
        child: LodingButtonWidget(
          onPressed: _handleOnPressed,
          text: SetLocalizations.of(context).getText('20tycjvp'), // "로그인"
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
          'f1vk38cs' /* 전화번호 변경 */,
        ),
      ),
    );
  }

  void _login() {
    // Implement your login logic here
  }
}
