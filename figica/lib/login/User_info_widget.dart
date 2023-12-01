import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/widgets/date_picker.dart';
import 'package:figica/auth/firebase_auth/auth_util.dart';
import 'package:figica/components/SignUP_Cancel.dart';
import 'package:figica/flutter_set/App_icon_button.dart';
import 'package:figica/flutter_set/figica_theme.dart';
import 'package:figica/flutter_set/flutter_flow_model.dart';
import 'package:figica/flutter_set/flutter_flow_util.dart';
import 'package:figica/flutter_set/flutter_flow_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'User_info_model.dart';
export 'User_info_model.dart';

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({Key? key}) : super(key: key);

  @override
  _UserInfoWidgetState createState() => _UserInfoWidgetState();
}

enum Gender { male, female }

class _UserInfoWidgetState extends State<UserInfoWidget> {
  late UserInfoModel _model;
  DateTime? selectedDate;
  Gender? selectedGender;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserInfoModel());

    _model.fiController ??= TextEditingController();
    _model.fiFocusNode ??= FocusNode();

    _model.namController ??= TextEditingController();
    _model.namFocusNode ??= FocusNode();

    _model.biController ??= TextEditingController();
    _model.biFocusNode ??= FocusNode();

    _model.heController ??= TextEditingController();
    _model.heFocusNode ??= FocusNode();

    _model.weController ??= TextEditingController();
    _model.weFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  Future<void> updateuser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;
      final name = user.displayName;
      await user.updateDisplayName(_model.fiController.text + _model.namController.text);
      setState(() {
        print(name.toString());
        print(uid.toString());
      });
    }
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
      buttonText: '선택',
      displayButtonIcon: false,
      buttonTextStyle: const TextStyle(color: Colors.white),
      buttonSingleColor: AppColors.Black,
      minDateTime: DateTime(1800, 1, 1),
      maxDateTime: DateTime(2021, 8, 2),
    ).show(context);
  }

  bool get areFieldsValid {
    return _model.fiController.text.isNotEmpty && _model.namController.text.isNotEmpty;
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
        appBar: AppBar(
          backgroundColor: Color(0x00CCFF8B),
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
                        child: SignUpCancelWidget(),
                      ),
                    ),
                  );
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
                      'mglc61fj' /* Page Title */,
                    ),
                    style: AppFont.s18.overrides(color: AppColors.Black)),
              ),
              Text(
                SetLocalizations.of(context).getText('mglttt'),
                style: AppFont.s12.overrides(color: AppColors.Gray300, fontSize: 12),
              )
            ],
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.85,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
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
                                  controller: _model.fiController,
                                  focusNode: _model.fiFocusNode,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    label: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          SetLocalizations.of(context).getText(
                                            'ty7h9c9n' /*성 */,
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
                                  controller: _model.namController,
                                  focusNode: _model.namFocusNode,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    label: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          SetLocalizations.of(context).getText(
                                            'p9l0jbdf' /* Label here... */,
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
                                      SetLocalizations.of(context).getText('cho9jtn4'),
                                      style: AppFont.s12.overrides(color: AppColors.Black),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: InkWell(
                                        onTap: _showDatePicker,
                                        child: Container(
                                            // Add horizontal padding
                                            width: double.infinity,
                                            height: 20, // Set the height of the container
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: AppColors.Gray200, // Color of the underscore (bottom border)
                                                  width: 1.0, // Thickness of the underscore (bottom border)
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                              selectedDate != null
                                                  ? "${selectedDate!.year}/${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.day.toString().padLeft(2, '0')}"
                                                  : "00/00/00",
                                              style: TextStyle(fontSize: 16), // Replace with your text style
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 32, 0, 10),
                          child: Row(
                            children: [
                              Text(
                                SetLocalizations.of(context).getText('tjdquf'),
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
                                child: FFButtonWidget(
                                  onPressed: () {
                                    setState(() {
                                      selectedGender = Gender.male;
                                    });
                                  },
                                  text: SetLocalizations.of(context).getText(
                                    'b6pt2wpc' /* 남성 */,
                                  ),
                                  options: FFButtonOptions(
                                    height: 40,
                                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                    color: selectedGender == Gender.male ? Colors.black : AppColors.primaryBackground,
                                    textStyle: AppFont.s12.overrides(color: selectedGender == Gender.male ? Colors.white : AppColors.Gray300),
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
                                child: FFButtonWidget(
                                  onPressed: () {
                                    setState(() {
                                      selectedGender = Gender.female;
                                    });
                                  },
                                  text: SetLocalizations.of(context).getText(
                                    'wyai5zsz' /* 여성 */,
                                  ),
                                  options: FFButtonOptions(
                                    height: 40,
                                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                    color: selectedGender == Gender.female ? Colors.black : AppColors.primaryBackground,
                                    textStyle: AppFont.s12.overrides(color: selectedGender == Gender.female ? Colors.white : AppColors.Gray300),
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
                                    controller: _model.heController,
                                    focusNode: _model.heFocusNode,
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                        labelText: SetLocalizations.of(context).getText(
                                          'dqi4qlg7' /* Label here... */,
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
                                    keyboardType: TextInputType.phone,
                                    style: AppFont.r16),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(8, 32, 0, 0),
                                child: TextFormField(
                                  controller: _model.weController,
                                  focusNode: _model.weFocusNode,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                      labelText: SetLocalizations.of(context).getText(
                                        'a45ghbyh' /* Label here... */,
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
                                  keyboardType: TextInputType.phone,
                                  validator: _model.weControllerValidator.asValidator(context),
                                ),
                              ),
                            ),
                          ],
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
                              if (areFieldsValid) {
                                await updateuser();
                                setState(() {});
                                print(currentUserDisplayName);
                                context.pushNamed('homePage');
                              }
                            },
                            text: SetLocalizations.of(context).getText(
                              'mht88zbc' /* 완료 */,
                            ),
                            options: FFButtonOptions(
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
