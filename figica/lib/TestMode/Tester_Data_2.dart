import 'package:bottom_picker/bottom_picker.dart';
import 'package:fisica/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_button2/dropdown_button2.dart'; // 패키지가 필요할 경우 추가하세요

class TesterData2 extends StatefulWidget {
  const TesterData2({Key? key}) : super(key: key);

  @override
  _TesterData2State createState() => _TesterData2State();
}

class _TesterData2State extends State<TesterData2> {
  DateTime? selectedDate;
  String selectedGender = 'none';
  String selectedJob = '선택';
  final TextEditingController fiController = TextEditingController();
  final fiFocusNode = FocusNode();

  final TextEditingController namController = TextEditingController();
  final namFocusNode = FocusNode();

  final TextEditingController phoneController = TextEditingController();
  final phoneFocusNode = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final emailFocusNode = FocusNode();

  final TextEditingController addressController = TextEditingController();
  final addressFocusNode = FocusNode();

  final TextEditingController detailAddressController = TextEditingController();
  final detailAddressFocusNode = FocusNode();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
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
      buttonText: '선택',
      displayButtonIcon: false,
      buttonTextStyle: const TextStyle(color: Colors.white),
      buttonSingleColor: Colors.black,
      minDateTime: DateTime(1800, 1, 1),
      maxDateTime: DateTime(2021, 8, 2),
    ).show(context);
  }

  bool get areFieldsValid {
    return fiController.text.isNotEmpty &&
        namController.text.isNotEmpty &&
        selectedDate != null &&
        selectedGender != 'none' &&
        selectedJob != '선택' &&
        phoneController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        addressController.text.isNotEmpty;
  }

  @override
  void dispose() {
    fiFocusNode.dispose();
    fiController.dispose();

    namFocusNode.dispose();
    namController.dispose();

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
      '선택',
      '경영/관리직',
      '전문직(의사, 변호사, 약사 등)',
      '프리랜서',
      '사무/기술직',
      '판매/서비스직',
      '기능/작업/단순노무직',
      '농/림/어/축산업',
      '자영업',
      '주부',
      '학생',
      '무직',
      '기타'
    ];

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
                  '체험자 정보 입력',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Text(
                '항목의 우측 상단 빨간 점 표시는 필수 입력 요소입니다',
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
                          children: [
                            Text('직업', style: TextStyle(fontSize: 12, color: Colors.black)),
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
                        DropdownButtonFormField2<String>(
                          value: selectedJob,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            border: OutlineInputBorder(),
                          ),
                          isExpanded: true,
                          //icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
                          items: jobOptions
                              .map((job) => DropdownMenuItem<String>(
                                    value: job,
                                    child: Text(job, style: TextStyle(fontSize: 14)),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedJob = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // 전화번호
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('국가번호', style: TextStyle(fontSize: 12, color: Colors.black)),
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
                          controller: phoneController,
                          focusNode: phoneFocusNode,
                          autofocus: false,
                          decoration: InputDecoration(
                            prefixText: '+82 ',
                            contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.phone,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  // 이메일
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('E-mail', style: TextStyle(fontSize: 12, color: Colors.black)),
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
                          controller: emailController,
                          focusNode: emailFocusNode,
                          autofocus: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 14),
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
                          children: [
                            Text('거주지', style: TextStyle(fontSize: 12, color: Colors.black)),
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
                            contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: detailAddressController,
                          focusNode: detailAddressFocusNode,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: '상세 주소 작성(선택)',
                            contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            border: OutlineInputBorder(),
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
                      child: ElevatedButton(
                        onPressed: areFieldsValid
                            ? () async {
// Add your form submission logic here
                              }
                            : null,
                        child: Text('입력 완료', style: TextStyle(fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
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
