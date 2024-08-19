import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:fisica/index.dart';

class TesterErrorData extends StatefulWidget {
  const TesterErrorData({Key? key}) : super(key: key);

  @override
  State<TesterErrorData> createState() => _TesterErrorDataState();
}

class _TesterErrorDataState extends State<TesterErrorData> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  DateTime? selectedDate;

  final TextEditingController fiController = TextEditingController();
  final fiFocusNode = FocusNode();

  final TextEditingController namController = TextEditingController();
  final namFocusNode = FocusNode();

  void _showDatePicker() {
    BottomPicker.date(
      title: "",
      titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
      onSubmit: (date) {
        setState(() {
          selectedDate = date;
          print(date);
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

  @override
  void dispose() {
    fiFocusNode.dispose();
    fiController.dispose();

    namFocusNode.dispose();
    namController.dispose();
  }

  bool get areFieldsValid {
    return fiController.text.isNotEmpty && namController.text.isNotEmpty && selectedDate != null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      onVerticalDragStart: (details) => FocusScope.of(context).unfocus(), // 수직 드래그 종료 시 키보드 숨김
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
              context.safePop();
            },
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                child: Text(SetLocalizations.of(context).getText('start_button'), style: AppFont.s18.overrides(color: AppColors.Black)),
              ),
              Text(
                SetLocalizations.of(context).getText('data_recovery'),
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
              height: MediaQuery.of(context).size.height * 0.8,
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
                                  controller: fiController,
                                  focusNode: fiFocusNode,
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
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    label: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          SetLocalizations.of(context).getText(
                                            'signupUserInfoInputFirstNameLabel' /* Label here... */,
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          SetLocalizations.of(context).getText('signupUserInfoInputBirthLabel'),
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
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: InkWell(
                                        onTap: _showDatePicker,
                                        child: Container(
                                            width: double.infinity,
                                            height: 20,
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
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Container(
                              width: double.infinity,
                              height: 56.0,
                              child: LodingButtonWidget(
                                onPressed: () async {
                                  if (areFieldsValid) {
                                    String data = selectedDate != null
                                        ? "${selectedDate!.year}/${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.day.toString().padLeft(2, '0')}"
                                        : "0000/00/00";
                                    String finame = fiController.text;
                                    String name = namController.text;

                                    await UserController.recoverGetAuth(data, finame, name).then((userData) {
                                      if (userData) {
                                        context.goNamed('Tester_menu');
                                      }
                                    }).catchError((error) {
                                      print('Error fetching user data: $error');
                                    });
                                  }
                                },
                                text: SetLocalizations.of(context).getText(
                                  'next' /* 완료 */,
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
