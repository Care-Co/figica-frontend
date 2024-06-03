import 'package:bottom_picker/bottom_picker.dart';
import 'package:fisica/models/UserData.dart';

import 'package:fisica/utils/form_field_controller.dart';
import 'package:fisica/views/home/mypage/mypage_components/Cancle_modi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fisica/index.dart';

class ModiUserInfoWidget extends StatefulWidget {
  const ModiUserInfoWidget({Key? key}) : super(key: key);

  @override
  _ModiUserInfoWidgetState createState() => _ModiUserInfoWidgetState();
}

class _ModiUserInfoWidgetState extends State<ModiUserInfoWidget> {
  UserData? data;
  late Future<void> _userInfoFuture; // Variable to store the future
  var fiController = TextEditingController();
  var fiFocusNode = FocusNode();

  var namController = TextEditingController();
  var namFocusNode = FocusNode();

  var heController = TextEditingController();
  var heFocusNode = FocusNode();

  var weController = TextEditingController();
  var weFocusNode = FocusNode();

  Future<void> getData() async {
    data = AppStateNotifier.instance.userdata;
    print(data);
    setState(() {
      print('set');
      fiController = TextEditingController(text: data!.firstName);
      fiFocusNode = FocusNode();

      namController = TextEditingController(text: data!.lastName);
      namFocusNode = FocusNode();

      heController = TextEditingController(text: data!.height.toString());
      heFocusNode = FocusNode();

      weController = TextEditingController(text: data!.weight.toString());
      weFocusNode = FocusNode();

      selectedDate = DateTime.parse(data!.birthday ?? '2024-01-01 00:00:00.000');
      print(selectedDate);
      selectedGender = data!.gender ?? 'NONE';
      print(selectedGender);
      dropDownValue = data?.region ?? 'KR';
      print(dropDownValue);
    });
  }

  DateTime? selectedDate;
  String selectedGender = 'none';
  String dropDownValue = 'KR';
  FormFieldController<String>? dropDownValueController;
  late AppStateNotifier _appStateNotifier;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _userInfoFuture = getData();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  Future<void> finalbutton() async {
    if (areFieldsValid) {
      String data = selectedDate != null
          ? "${selectedDate!.year}/${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.day.toString().padLeft(2, '0')}"
          : "0000/00/00";
      String finame = fiController.text;
      String name = namController.text;
      double height = heController.text.isEmpty ? 0.0 : double.parse(heController.text);
      double weight = weController.text.isEmpty ? 0.0 : double.parse(weController.text);

      await UserController.modiProfile(data, finame, name, selectedGender, height, weight, dropDownValue).then((userData) {
        _appStateNotifier = AppStateNotifier.instance;

        context.goNamed('home');
      }).catchError((error) {
        print('Error fetching user data: $error');
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
    return fiController.text.isNotEmpty && namController.text.isNotEmpty;
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
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.primaryBackground,
        appBar: AppBar(
          backgroundColor: Color(0x00CCFF8B),
          automaticallyImplyLeading: false,
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
            ],
          ),
          actions: [
            AppIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 60,
              icon: Icon(
                Icons.cancel,
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
                        // onTap: () => unfocusNode.canRequestFocus
                        //     ? FocusScope.of(context).requestFocus(unfocusNode)
                        //     : FocusScope.of(context).unfocus(),
                        child: Container(
                          height: 432,
                          width: 327,
                          child: CancleModi(finalbutton: finalbutton),
                        ),
                      ),
                    );
                  },
                ).then((value) => setState(() {}));
              },
            ),
          ],
          centerTitle: false,
          elevation: 0,
        ),
        body: FutureBuilder(
            future: _userInfoFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Center(child: Text("데이터 로딩 중 에러 발생"));
              } else {
                return SafeArea(
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
                                        child: LodingButtonWidget(
                                          onPressed: () {
                                            setState(() {
                                              selectedGender = 'MALE';
                                            });
                                          },
                                          text: SetLocalizations.of(context).getText(
                                            'b6pt2wpc' /* 남성 */,
                                          ),
                                          options: LodingButtonOptions(
                                            height: 40,
                                            padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                            iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                            color: selectedGender == 'MALE' ? Colors.black : AppColors.primaryBackground,
                                            textStyle: AppFont.s12.overrides(color: selectedGender == 'MALE' ? Colors.white : AppColors.Gray300),
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
                                              selectedGender = 'FEMALE';
                                            });
                                          },
                                          text: SetLocalizations.of(context).getText(
                                            'wyai5zsz' /* 여성 */,
                                          ),
                                          options: LodingButtonOptions(
                                            height: 40,
                                            padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                            iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                            color: selectedGender == 'FEMALE' ? Colors.black : AppColors.primaryBackground,
                                            textStyle: AppFont.s12.overrides(color: selectedGender == 'FEMALE' ? Colors.white : AppColors.Gray300),
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
                                            keyboardType: TextInputType.number,
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
                                          keyboardType: TextInputType.number,
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
                                  child: LodingButtonWidget(
                                    onPressed: () async {
                                      finalbutton();
                                    },
                                    text: SetLocalizations.of(context).getText(
                                      'tnwjd' /* 완료 */,
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
                );
              }
            }),
      ),
    );
  }
}
