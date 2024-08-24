import 'package:bottom_picker/bottom_picker.dart';
import 'package:fisica/index.dart';
import 'package:fisica/utils/form_field_controller.dart';
import 'package:fisica/widgets/flutter_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:latlong2/latlong.dart';

class TesterData2 extends StatefulWidget {
  const TesterData2({Key? key}) : super(key: key);

  @override
  _TesterData2State createState() => _TesterData2State();
}

class _TesterData2State extends State<TesterData2> {
  DateTime? selectedDate;
  String selectedJob = '';
  String? selectedDropdownValue = '+39';

  Future<void> _showLocationPicker() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FlutterLocationPicker(
          key: Key('locationPicker'),
          onPicked: (PickedData pickedData) {
            print(pickedData.latLong.latitude);
            print(pickedData.latLong.longitude);
            print(pickedData.address);
            print(pickedData.addressData['country']);
            //Navigator.of(context).pop(pickedData);
          },
          showSearchBar: false,
          initPosition: LatLong(37.5665, 126.9780), // 초기 위치 (서울 좌표)
          searchBarBackgroundColor: Colors.white,
          searchBarHintText: '검색',
          searchBarTextColor: Colors.black,
          selectLocationButtonText: '위치 선택',
          selectLocationButtonStyle: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
          ),
          showZoomController: false,
          showLocationController: false,
          showSelectLocationButton: true,
          showCurrentLocationPointer: false,
          mapAnimationDuration: Duration(milliseconds: 2000),
        ),
      ),
    );

    if (result != null && result is PickedData) {
      setState(() {
        addressController.text = result.address;
      });
    }
  }

  final TextEditingController fiController = TextEditingController();
  final fiFocusNode = FocusNode();

  final TextEditingController conController = TextEditingController();
  final conFocusNode = FocusNode();

  final TextEditingController phoneController = TextEditingController();
  final phoneFocusNode = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final emailFocusNode = FocusNode();

  final TextEditingController addressController = TextEditingController();
  final addressFocusNode = FocusNode();

  final TextEditingController detailAddressController = TextEditingController();
  final detailAddressFocusNode = FocusNode();

  FormFieldController<String>? dropDownValueControllerT;
  FormFieldController<String>? dropDownValueControllerJ;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    Locale? locale = SetLocalizations.getStoredLocale();
    if (locale != null) {
      selectedJob = '${locale.languageCode}' == 'ko' ? '선택' : 'Select';
      print('Stored locale: ${locale.languageCode}_${locale.countryCode}');
    } else {
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
      buttonSingleColor: Colors.black,
      minDateTime: DateTime(1800, 1, 1),
      maxDateTime: DateTime.now(),
    ).show(context);
  }

  @override
  void dispose() {
    fiFocusNode.dispose();
    fiController.dispose();

    conFocusNode.dispose();
    conController.dispose();

    phoneFocusNode.dispose();
    phoneController.dispose();

    emailFocusNode.dispose();
    emailController.dispose();

    addressFocusNode.dispose();
    addressController.dispose();

    detailAddressFocusNode.dispose();
    detailAddressController.dispose();
    super.dispose();
  }

  bool get areFieldsValid {
    bool test = selectedJob != '' && phoneController.text.isNotEmpty && addressController.text.isNotEmpty;
    return test;
  }

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    final List<String> jobOptions = [
      SetLocalizations.of(context).getText('management'),
      SetLocalizations.of(context).getText('professional'),
      SetLocalizations.of(context).getText('freelancer'),
      SetLocalizations.of(context).getText('office_technical'),
      SetLocalizations.of(context).getText('sales_service'),
      SetLocalizations.of(context).getText('manual_labor'),
      SetLocalizations.of(context).getText('agriculture_fishing'),
      SetLocalizations.of(context).getText('self_employed'),
      SetLocalizations.of(context).getText('housewife'),
      SetLocalizations.of(context).getText('student'),
      SetLocalizations.of(context).getText('unemployed'),
      SetLocalizations.of(context).getText('other'),
    ];
    String? phoneValidator(String? value) {
      if (value == null || value.isEmpty) {
        return SetLocalizations.of(context).getText(
          'loginHomeInputPhoneError', // 전화번호 또는 E-mail을 입력해 주세요
        );
      } else if (!value.startsWith('02')) {
        return SetLocalizations.of(context).getText(
          'loginHomeInputPhoneError', // '010을 포함하여 숫자만 입력해 주세요
        );
      }
      return null;
    }

    String? emailValidator(String? value) {
      if (value == null || value.isEmpty) {
        return SetLocalizations.of(context).getText(
          'loginHomeInputEmailError', // 전화번호 또는 E-mail을 입력해 주세요
        );
      } else if (!value.contains('@')) {
        return SetLocalizations.of(context).getText(
          'loginHomeInputEmailError', // @를 포함한 정확한 이메일을 입력해 주세요
        );
      }
      return null;
    }

    return GestureDetector(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0x00CCFF8B),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.chevron_left, color: Colors.black, size: 30),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                child: Text(
                  SetLocalizations.of(context).getText(
                    'enter_name_dob' /* Page Title */,
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Text(
                SetLocalizations.of(context).getText('participant_info_entry'),
                style: TextStyle(color: Colors.grey[700], fontSize: 12),
              ),
            ],
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // 직업 Dropdown
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(SetLocalizations.of(context).getText('occupation'), style: TextStyle(fontSize: 12, color: Colors.black)),
                            SizedBox(width: 4),
                            Container(
                              height: 6,
                              width: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        FlutterDropDown<String>(
                          controller: dropDownValueControllerJ ??= FormFieldController<String>(""),
                          hintText: SetLocalizations.of(context).getText('select'),
                          options: jobOptions,
                          onChanged: (value) {
                            setState(() {
                              selectedJob = value!;
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
                        // DropdownButtonFormField2<String>(
                        //   value: selectedJob,
                        //   decoration: InputDecoration(
                        //     contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        //     border: OutlineInputBorder(),
                        //   ),
                        //   isExpanded: true,
                        //   //icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
                        //   items: jobOptions
                        //       .map((job) => DropdownMenuItem<String>(
                        //             value: job,
                        //             child: Text(job, style: TextStyle(fontSize: 14)),
                        //           ))
                        //       .toList(),
                        //   onChanged: (value) {
                        //     setState(() {
                        //       selectedJob = value!;
                        //     });
                        //   },
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // 전화번호
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              SetLocalizations.of(context).getText('loginHomeSelectPhoneLabel'),
                              style: AppFont.s12,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            FlutterDropDown<String>(
                              controller: dropDownValueControllerT ??= FormFieldController<String>("+39"),
                              hintText: '+39',
                              options: ['+1', '+91', '+82', '+81', '+39'],
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedDropdownValue = newValue ?? '+39';
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
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  SetLocalizations.of(context).getText('loginHomeInputPhoneLabel'),
                                  style: AppFont.s12,
                                ),
                                Container(
                                  height: 6,
                                  width: 6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                                controller: phoneController,
                                focusNode: phoneFocusNode,
                                onFieldSubmitted: (value) {},
                                onChanged: (text) {
                                  setState(() {});
                                },
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
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.Gray200,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.Gray200,
                                      width: 1.0,
                                    ),
                                  ),
                                  suffixIcon: phoneController.text.isNotEmpty
                                      ? InkWell(
                                          child: Container(
                                            height: 10,
                                            width: 10,
                                            decoration: BoxDecoration(
                                              color: AppColors.Gray100,
                                              shape: BoxShape.circle,
                                            ),
                                            margin: EdgeInsets.all(14),
                                            child: Icon(
                                              Icons.clear,
                                              color: AppColors.Gray500,
                                              size: 10,
                                            ),
                                          ),
                                          onTap: () {
                                            phoneController.clear();
                                          },
                                        )
                                      : null,
                                  errorText: phoneValidator(phoneController.text),
                                ),
                                style: AppFont.r16.overrides(color: AppColors.Gray700),
                                validator: phoneValidator),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // 이메일
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          SetLocalizations.of(context).getText('settingEmailInputEmailLabel'),
                          style: AppFont.s12,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: emailController,
                          onChanged: (text) {
                            setState(() {});
                          },
                          focusNode: emailFocusNode,
                          autofocus: false,
                          onFieldSubmitted: (value) {},
                          decoration: InputDecoration(
                            labelStyle: AppFont.r16.overrides(color: AppColors.Gray500),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.Gray200,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.Gray200,
                                width: 2.0,
                              ),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.Gray200,
                                width: 2.0,
                              ),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.Gray200,
                                width: 2.0,
                              ),
                            ),
                            suffixIcon: emailController.text.isNotEmpty
                                ? InkWell(
                                    child: Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        color: AppColors.Gray100,
                                        shape: BoxShape.circle,
                                      ),
                                      margin: EdgeInsets.all(14),
                                      child: Icon(
                                        Icons.clear,
                                        color: AppColors.Gray500,
                                        size: 10,
                                      ),
                                    ),
                                    onTap: () {
                                      emailController.clear();
                                    },
                                  )
                                : null,
                            errorText: emailValidator(emailController.text),
                          ),
                          style: AppFont.r16.overrides(color: AppColors.Gray700),
                          validator: emailValidator,
                        ),
                      ],
                    ),
                  ),
                  // 주소
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(SetLocalizations.of(context).getText('residence'), style: TextStyle(fontSize: 12, color: Colors.black)),
                            SizedBox(width: 4),
                            Container(
                              height: 6,
                              width: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: addressController,
                          focusNode: addressFocusNode,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: SetLocalizations.of(context).getText('address_search'),
                            hintStyle: AppFont.r16.overrides(color: AppColors.Gray300),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.Gray200,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.Gray200,
                                width: 2.0,
                              ),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.Gray200,
                                width: 2.0,
                              ),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.Gray200,
                                width: 2.0,
                              ),
                            ),
                          ),
                          style: TextStyle(fontSize: 14),
                          onChanged: (text) {
                            setState(() {});
                          },
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: detailAddressController,
                          focusNode: detailAddressFocusNode,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: SetLocalizations.of(context).getText('detailed_address'),
                            hintStyle: AppFont.r16.overrides(color: AppColors.Gray300),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.Gray200,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.Gray200,
                                width: 2.0,
                              ),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.Gray200,
                                width: 2.0,
                              ),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.Gray200,
                                width: 2.0,
                              ),
                            ),
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
// 입력 완료 버튼
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Container(
                        width: double.infinity,
                        height: 56.0,
                        child: LodingButtonWidget(
                          onPressed: () async {
                            if (areFieldsValid) {
                              String phone = '${selectedDropdownValue}${phoneController.text.substring(1)}';
                              bool userData = await UserController.testGetAuth(
                                selectedJob,
                                phone,
                                emailController.text,
                                addressController.text,
                                detailAddressController.text,
                                selectedDropdownValue.toString(),
                              );
                              print(userData);

                              if (userData) {
                                context.goNamed('Tester_menu');
                              } else if (!userData) {
                                context.pushNamed('LandingScreen');
                              }
                              ;
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
            ),
          ),
        ),
      ),
    );
  }
}
