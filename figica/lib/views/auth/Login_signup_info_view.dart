import 'package:bottom_picker/bottom_picker.dart';

import 'package:fisica/widgets/flutter_drop_down.dart';
import 'package:fisica/auth/auth_service.dart';

import 'package:fisica/utils/form_field_controller.dart';
import 'package:flutter/material.dart';

import 'package:fisica/index.dart';

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({Key? key}) : super(key: key);

  @override
  _UserInfoWidgetState createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  final AuthService _authService = AuthService();

  DateTime? selectedDate;
  String selectedGender = 'none';
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  final TextEditingController fiController = TextEditingController();
  final fiFocusNode = FocusNode();

  final TextEditingController namController = TextEditingController();
  final namFocusNode = FocusNode();

  final TextEditingController biController = TextEditingController();
  final biFocusNode = FocusNode();

  final TextEditingController heController = TextEditingController();
  final heFocusNode = FocusNode();

  final TextEditingController weController = TextEditingController();
  final weFocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Locale? locale = SetLocalizations.getStoredLocale();
    if (locale != null) {
      setState(() {
        dropDownValue = ('${locale.languageCode}' != 'en') ? '🇰🇷 Republic of Korea' : '🇮🇹 Italy';
      });
    } else {
      dropDownValue = '🇰🇷 Republic of Korea';

      print('No locale stored');
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  void _showDatePicker() {
    BottomPicker.date(
      title: "",
      titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
      onSubmit: (date) {
        setState(() {
          selectedDate = date;
          print(date); // For debugging, to see the selected date in the console
        });
      },
      onClose: () {
        print("Picker closed");
      },
      dismissable: true,
      height: 360,
      displayCloseIcon: false,
      buttonWidth: 300,
      buttonText: SetLocalizations.of(context).getText('select'),
      displayButtonIcon: false,
      buttonTextStyle: const TextStyle(color: Colors.white),
      buttonSingleColor: AppColors.Black,
      minDateTime: DateTime(1800, 1, 1),
      maxDateTime: DateTime.now(),
    ).show(context);
  }

  bool get areFieldsValid {
    return fiController.text.isNotEmpty && namController.text.isNotEmpty;
  }

  @override
  void dispose() {
    fiController.dispose();
    namController.dispose();
    biController.dispose();
    heController.dispose();
    weController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.primaryBackground,
        appBar: AppBar(
          elevation: 1,
          surfaceTintColor: AppColors.primaryBackground,
          shadowColor: AppColors.Gray100,
          automaticallyImplyLeading: false,
          leading: AppIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () async {
              await showCustomDialog(
                context: context,
                checkButtonColor: AppColors.red,
                titleText: SetLocalizations.of(context).getText('popupDecideSignupLabel'),
                descriptionText: SetLocalizations.of(context).getText('popupDecideSignupDescription'),
                upperButtonText: SetLocalizations.of(context).getText('popupDecideSignupButtonReturnLabel'),
                upperButtonFunction: () async {
                  await _authService.deleteUser();
                  await AppStateNotifier.instance.logout();
                  context.goNamed('login');
                },
                lowerButtonText: SetLocalizations.of(context).getText('popupDecideSignupButtonContinueLabel'),
                /* 계속 작성하기 */
                lowerButtonFunction: () {
                  context.safePop();
                },
              ).then((value) => setState(() {}));
            },
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                child: Text(
                    SetLocalizations.of(context).getText(
                      'signupUserInfoButtonReturnLabel' /* Page Title */,
                    ),
                    style: AppFont.s18.overrides(color: AppColors.Black)),
              ),
              Text(
                SetLocalizations.of(context).getText('signupUserinfoScript'),
                style: AppFont.s12.overrides(color: AppColors.Gray300, fontSize: 12),
              )
            ],
          ),
          actions: [],
          centerTitle: false,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 8, 0),
                                child: TextFormField(
                                  controller: fiController,
                                  focusNode: fiFocusNode,
                                  textInputAction: TextInputAction.next,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    label: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          SetLocalizations.of(context).getText(
                                            'signupUserInfoInputLastNameLabel' /*성 */,
                                          ),
                                          style: AppFont.s12.overrides(color: AppColors.Black),
                                        ),
                                        Container(
                                          height: 6, // Height of the dot
                                          width: 6, // Width of the dot
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.red, // Color of the dot
                                          ),
                                        ),
                                      ],
                                    ),
                                    labelStyle: AppFont.s12.overrides(color: AppColors.Black),
                                    hintStyle: AppFont.s12,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.Gray200,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.Gray200,
                                        width: 1,
                                      ),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.Gray200,
                                        width: 1,
                                      ),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.Gray200,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  style: AppFont.s12,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Field cannot be empty';
                                    }
                                    bool isKorean = RegExp(r"[\uac00-\ud7af]").hasMatch(value);
                                    bool isJapanese = RegExp(r"[\u3040-\u30ff\u3400-\u4dbf\u4e00-\u9faf]").hasMatch(value);
                                    if (isKorean && value.length > 2) {
                                      return '한글은 2자 이하로 입력해주세요';
                                    } else if (isJapanese && value.length > 20) {
                                      return '日本語は20文字以内で入力してください';
                                    } else if (!isKorean && !isJapanese && value.length > 12) {
                                      return '영어는 12자 이하로 입력해주세요';
                                    }
                                    return null; // null means input is valid
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(8, 20, 0, 0),
                                child: TextFormField(
                                  controller: namController,
                                  focusNode: namFocusNode,
                                  textInputAction: TextInputAction.next,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    label: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          SetLocalizations.of(context).getText(
                                            'signupUserInfoInputFirstNameLabel' /* 이름 */,
                                          ),
                                          style: AppFont.s12.overrides(color: AppColors.Black),
                                        ),
                                        Container(
                                          height: 6, // Height of the dot
                                          width: 6, // Width of the dot
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.red, // Color of the dot
                                          ),
                                        ),
                                      ],
                                    ),
                                    hintStyle: AppFont.s12,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.Gray200,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.Gray200,
                                        width: 1,
                                      ),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.Gray200,
                                        width: 1,
                                      ),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.Gray200,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  style: AppFont.s12,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Field cannot be empty';
                                    }
                                    bool isKorean = RegExp(r"[\uac00-\ud7af]").hasMatch(value);
                                    bool isJapanese = RegExp(r"[\u3040-\u30ff\u3400-\u4dbf\u4e00-\u9faf]").hasMatch(value);
                                    if (isKorean && value.length > 15) {
                                      return '한글은 15자 이하로 입력해주세요';
                                    } else if (isJapanese && value.length > 20) {
                                      return '日本語は20文字以内で入力してください';
                                    } else if (!isKorean && !isJapanese && value.length > 20) {
                                      return '영어는 20자 이하로 입력해주세요';
                                    }
                                    return null; // null means input is valid
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      SetLocalizations.of(context).getText('signupUserInfoInputBirthLabel'),
                                      style: AppFont.s12.overrides(color: AppColors.Black),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: _showDatePicker,
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: AppColors.Gray200,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            selectedDate != null
                                                ? "${selectedDate!.year}/${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.day.toString().padLeft(2, '0')}"
                                                : "00/00/00",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 32, 0, 10),
                          child: Row(
                            children: [
                              Text(
                                SetLocalizations.of(context).getText('signupUserInfoButtonGenderLabel'),
                                style: AppFont.s12.overrides(color: AppColors.Black),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                child: LodingButtonWidget(
                                  onPressed: () {
                                    setState(() {
                                      selectedGender = 'male';
                                    });
                                  },
                                  text: SetLocalizations.of(context).getText(
                                    'signupUserInfoButtonGenderMaleLabel' /* 남성 */,
                                  ),
                                  options: LodingButtonOptions(
                                    height: 40,
                                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                    color: selectedGender == 'male' ? Colors.black : AppColors.primaryBackground,
                                    textStyle: AppFont.s12.overrides(color: selectedGender == 'male' ? Colors.white : AppColors.Gray300),
                                    elevation: 0,
                                    borderSide: BorderSide(
                                      color: AppColors.Gray300,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: LodingButtonWidget(
                                  onPressed: () {
                                    setState(() {
                                      selectedGender = 'female';
                                    });
                                  },
                                  text: SetLocalizations.of(context).getText(
                                    'signupUserInfoButtonGenderFemaleLabel' /* 여성 */,
                                  ),
                                  options: LodingButtonOptions(
                                    height: 40,
                                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                    color: selectedGender == 'female' ? Colors.black : AppColors.primaryBackground,
                                    textStyle: AppFont.s12.overrides(color: selectedGender == 'female' ? Colors.white : AppColors.Gray300),
                                    elevation: 0,
                                    borderSide: BorderSide(
                                      color: AppColors.Gray300,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 32, 8, 0),
                                child: TextFormField(
                                    controller: heController,
                                    focusNode: heFocusNode,
                                    textInputAction: TextInputAction.next,
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                        labelText: SetLocalizations.of(context).getText(
                                          'signupUserInfoInputHeightLabel' /* 신장 */,
                                        ),
                                        labelStyle: AppFont.s12.overrides(color: AppColors.Black),
                                        hintStyle: AppFont.s12,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.Gray200,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.Gray200,
                                            width: 1,
                                          ),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.Gray200,
                                            width: 1,
                                          ),
                                        ),
                                        focusedErrorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.Gray200,
                                            width: 1,
                                          ),
                                        ),
                                        suffix: Text(
                                          'Cm',
                                          style: AppFont.r16.overrides(color: AppColors.Gray200),
                                        )),
                                    style: AppFont.r16),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(8, 32, 0, 0),
                                child: TextFormField(
                                  controller: weController,
                                  focusNode: weFocusNode,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                      labelText: SetLocalizations.of(context).getText(
                                        'signupUserInfoInputWeightLabel' /* 체중 */,
                                      ),
                                      labelStyle: AppFont.s12.overrides(color: AppColors.Black),
                                      hintStyle: AppFont.s12,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.Gray200,
                                          width: 1,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.Gray200,
                                          width: 1,
                                        ),
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.Gray200,
                                          width: 1,
                                        ),
                                      ),
                                      focusedErrorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.Gray200,
                                          width: 1,
                                        ),
                                      ),
                                      suffix: Text(
                                        'Kg',
                                        style: AppFont.r16.overrides(color: AppColors.Gray200),
                                      )),
                                  style: AppFont.r16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 32, 0, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                child: Text(
                                    SetLocalizations.of(context).getText(
                                      'signupUserInfoSelectCountryLabel' /* 국가 */,
                                    ),
                                    style: AppFont.s12),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                child: FlutterDropDown<String>(
                                  controller: dropDownValueController ??= FormFieldController<String>(dropDownValue),
                                  options: [
                                    '🇰🇷 Republic of Korea',
                                    '🇮🇹 Italy',
                                  ],
                                  onChanged: (val) async {
                                    setState(() => dropDownValue = val!);
                                    if (val == '🇰🇷 Republic of Korea') {
                                      setAppLanguage(context, 'ko');
                                    } else if (val == '🇮🇹 Italy') {
                                      setAppLanguage(context, 'en');
                                    }
                                  },
                                  width: double.infinity,
                                  height: 38.0,
                                  textStyle: AppFont.r16.overrides(color: AppColors.Gray500),
                                  hintText: dropDownValue,
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
                            ],
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
                              print(areFieldsValid);
                              if (areFieldsValid) {
                                String? data = selectedDate != null
                                    ? "${selectedDate!.year}/${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.day.toString().padLeft(2, '0')}"
                                    : null;
                                String finame = fiController.text;
                                String name = namController.text;
                                double height = heController.text.isEmpty ? 0.0 : double.parse(heController.text);
                                double weight = weController.text.isEmpty ? 0.0 : double.parse(weController.text);
                                print('{$finame , $name , $height ,$selectedGender, $weight , $data $dropDownValue}');

                                await UserController.signUpInputData(data, finame, name, selectedGender, height, weight, dropDownValue ?? 'KR')
                                    .then((userData) async {
                                  userData
                                      ? {
                                          await AppStateNotifier.instance.apicall(),
                                          AppStateNotifier.instance.updateSignUpState(false),
                                          context.goNamed('home'),
                                        }
                                      : {
                                          await UserController.deleteUser().then((value) => context.goNamed('home')),
                                          AppStateNotifier.instance.updateSignUpState(false),
                                          AppStateNotifier.instance.removefirebaseToken(),
                                        };
                                }).catchError((error) {
                                  print('Error fetching user data: $error');
                                });
                              }
                            },
                            text: SetLocalizations.of(context).getText(
                              'signupUserInfoButtonCompleteLabel' /* 완료 */,
                            ),
                            options: LodingButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                              color: areFieldsValid ? Colors.black : AppColors.Gray200, // Change color based on validation
                              textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.primaryBackground),
                              elevation: 0,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          )),
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
