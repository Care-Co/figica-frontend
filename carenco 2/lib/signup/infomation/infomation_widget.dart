import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../backend/schema/users_record.dart';
import '/auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'infomation_model.dart';
export 'infomation_model.dart';

class InfomationWidget extends StatefulWidget {
  const InfomationWidget({Key? key}) : super(key: key);


  @override
  _InfomationWidgetState createState() => _InfomationWidgetState();
}

class _InfomationWidgetState extends State<InfomationWidget> {
  late InfomationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  bool _height = true;
  bool _weight = true;
  bool _birthdaybool = true;
  DateTime _birthday = DateTime.now();




  final firestore = FirebaseFirestore.instance;
  updateUserData() {
    setState(() {

      _model.heightController.text.trim().length > 5
          || _model.heightController.text.isEmpty
          ? _height = false
          : _height = true;
      _model.heightController.text.trim().length > 5
          || _model.heightController.text.isEmpty
          ? _weight = false
          : _weight = true;
    });
    if(_height && _weight ) {


      firestore.collection("users").doc(FirebaseAuth.instance.currentUser?.uid).update({
        'birthday': _birthday,
        'height': double.parse(_model.heightController.text),
        'weight': double.parse(_model.weightController.text),
        'sex': _model.isman! ? 'male' : 'female',
      });
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '입력하지 않은 항목이 있습니다.',
          ),
        ),
      );
      return;
    }
    context.pushNamed('Interest');
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InfomationModel());

    _model.birthdayController ??= TextEditingController();
    _model.heightController ??= TextEditingController();
    _model.weightController ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: FlutterFlowTheme.of(context).black),
        automaticallyImplyLeading: true,
        title: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '회원 정보 입력',
              style: FlutterFlowTheme.of(context).title3.override(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                useGoogleFonts: false,
              ),
            ),
            Text(
              '원활한 서비스 이용을 위해 회원 정보를 입력해 주세요',
              style: FlutterFlowTheme.of(context).bodyText2.override(
                fontFamily: 'Pretendard',
                color: FlutterFlowTheme.of(context).grey500,
                useGoogleFonts: false,
              ),
            ),
          ],
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Form(
                  key: _model.formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Generated code for this Container Widget...
                        Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          '생년월일',
                                          style: FlutterFlowTheme.of(context).bodyText1,
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                DatePicker.showDatePicker(context,
                                                    showTitleActions: true,
                                                    minTime: DateTime(1930, 1, 1),
                                                    maxTime: DateTime.now(),
                                                    onChanged: (date) {
                                                      print('change $date');
                                                    },
                                                    onConfirm: (date) {

                                                      print('confirm $date');

                                                      _birthday = date;
                                                      print(_birthday);

                                                    },

                                                    currentTime: DateTime.now(), locale: LocaleType.ko);
                                              },
                                              child: Text(
                                                DateFormat('yyyy-MM-dd').format(_birthday),
                                                style: FlutterFlowTheme.of(context).bodyText1,
                                              ),
                                            ),
                                            Divider(
                                              thickness: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 8),
                                      child: Text(
                                        '성별',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.38,
                                          height: 42,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              setState(() {
                                                _model.isman = true;
                                              });
                                            },
                                            text: '남성',
                                            options: FFButtonOptions(
                                              width: 130,
                                              height: 40,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 0),
                                              color: _model.isman!
                                                  ? FlutterFlowTheme.of(context)
                                                  .grey200
                                                  : FlutterFlowTheme.of(context)
                                                  .white,
                                              textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText1,
                                              borderSide: BorderSide(
                                                color: _model.isman!
                                                    ? FlutterFlowTheme.of(
                                                    context)
                                                    .grey200
                                                    : FlutterFlowTheme.of(
                                                    context)
                                                    .white,
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.04,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.38,
                                          height: 42,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              setState(() {
                                                _model.isman = false;
                                              });
                                            },
                                            text: '여성',
                                            options: FFButtonOptions(
                                              width: 130,
                                              height: 40,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 0),
                                              color: !_model.isman!
                                                  ? FlutterFlowTheme.of(context)
                                                  .grey200
                                                  : FlutterFlowTheme.of(context)
                                                  .white,
                                              textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText1,
                                              borderSide: BorderSide(
                                                color: !_model.isman!
                                                    ? FlutterFlowTheme.of(
                                                    context)
                                                    .grey200
                                                    : FlutterFlowTheme.of(
                                                    context)
                                                    .white,
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.38,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          '신장(키)',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1,
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _model.heightController,
                                        onFieldSubmitted: (_) async {
                                          if (_model.formKey.currentState ==
                                              null ||
                                              !_model.formKey.currentState!
                                                  .validate()) {
                                            return;
                                          }
                                        },
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          hintText: 'cm',
                                          hintStyle:
                                          FlutterFlowTheme.of(context)
                                              .bodyText2,
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .grey200,
                                              width: 1,
                                            ),
                                            borderRadius:
                                            const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .figicoGreen,
                                              width: 1,
                                            ),
                                            borderRadius:
                                            const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .figicoRed,
                                              width: 1,
                                            ),
                                            borderRadius:
                                            const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedErrorBorder:
                                          UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .figicoRed,
                                              width: 1,
                                            ),
                                            borderRadius:
                                            const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                          fontFamily: 'Pretendard',
                                          color:
                                          FlutterFlowTheme.of(context)
                                              .grey500,
                                          useGoogleFonts: false,
                                        ),
                                        textAlign: TextAlign.end,
                                        keyboardType: TextInputType.datetime,
                                        validator: _model
                                            .heightControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.04,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.38,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          '체중(몸무게)',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1,
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _model.weightController,
                                        onFieldSubmitted: (_) async {
                                          if (_model.formKey.currentState ==
                                              null ||
                                              !_model.formKey.currentState!
                                                  .validate()) {
                                            return;
                                          }
                                        },
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          hintText: 'kg',
                                          hintStyle:
                                          FlutterFlowTheme.of(context)
                                              .bodyText2,
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .grey200,
                                              width: 1,
                                            ),
                                            borderRadius:
                                            const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .figicoGreen,
                                              width: 1,
                                            ),
                                            borderRadius:
                                            const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .figicoRed,
                                              width: 1,
                                            ),
                                            borderRadius:
                                            const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedErrorBorder:
                                          UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .figicoRed,
                                              width: 1,
                                            ),
                                            borderRadius:
                                            const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                          fontFamily: 'Pretendard',
                                          color:
                                          FlutterFlowTheme.of(context)
                                              .grey500,
                                          useGoogleFonts: false,
                                        ),
                                        textAlign: TextAlign.end,
                                        keyboardType: TextInputType.datetime,
                                        validator: _model
                                            .weightControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ],
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
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                            child: FFButtonWidget(
                              onPressed: () async {

                                updateUserData();

                              },
                              text: '다음',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 42,
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                iconPadding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color:
                                FlutterFlowTheme.of(context).primaryColor,
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                  fontFamily: 'Pretendard',
                                  color: Colors.white,
                                  useGoogleFonts: false,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
