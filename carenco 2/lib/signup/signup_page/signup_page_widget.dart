import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'signup_page_model.dart';
export 'signup_page_model.dart';

class SignupPageWidget extends StatefulWidget {
  const SignupPageWidget({
    Key? key,
    this.authentication,
  }) : super(key: key);

  final bool? authentication;


  @override
  _SignupPageWidgetState createState() => _SignupPageWidgetState();
}

class _SignupPageWidgetState extends State<SignupPageWidget> {
  late SignupPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  final firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignupPageModel());

    _model.emailController ??= TextEditingController();




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
              '이메일로 회원가입',
              style: FlutterFlowTheme.of(context).title3.override(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                useGoogleFonts: false,
              ),
            ),
            Text(
              '해당 이메일 주소를 아이디로 사용합니다',
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
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color:
                          FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'E-mail',
                                        style: FlutterFlowTheme.of(context).bodyText1,
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          controller: _model.emailController,
                                          onFieldSubmitted: (_) async {
                                            if (_model.formKey.currentState == null ||
                                                !_model.formKey.currentState!.validate()) {
                                              return;
                                            }
                                          },
                                          autofocus: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: '@ 까지 정확하게 입력해주세요',
                                            hintStyle:
                                            FlutterFlowTheme.of(context).bodyText2.override(
                                              fontFamily: 'Pretendard',
                                              color: FlutterFlowTheme.of(context).grey500,
                                              useGoogleFonts: false,
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(context).grey500,
                                                width: 1,
                                              ),
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(context).figicoGreen,
                                                width: 1,
                                              ),
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            errorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(context).figicoRed,
                                                width: 1,
                                              ),
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedErrorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(context).figicoRed,
                                                width: 1,
                                              ),
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context).bodyText1,
                                          keyboardType: TextInputType.emailAddress,
                                          validator:
                                          _model.emailControllerValidator.asValidator(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (_model.emailVerification ?? true)
                              Icon(
                                Icons.check_circle_outline_rounded,
                                color: FlutterFlowTheme.of(context).alertGreen,
                                size: 16,
                              ),
                            if (!_model.emailVerification!)

                              Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 30, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  GoRouter.of(context).prepareAuthEvent();

                                  final user = await createAccountWithEmail(
                                    context,
                                    _model.emailController.text,
                                    'qwer1234',
                                  );
                                  if (user == null) {
                                    return;
                                  }

                                  final usersCreateData = {
                                    ...createUsersRecordData(
                                      displayName: '1',
                                      phoneNumber: '1',
                                      height: 1.0,
                                      weight: 1.0,
                                      sex: 'a',
                                    ),
                                    'birthday': FieldValue.serverTimestamp(),
                                    'Interest': [],
                                  };
                                  await UsersRecord.collection
                                      .doc(user.uid)
                                      .update(usersCreateData);

                                  await sendEmailVerification();

                                },
                                text: '인증번호 전송',
                                options: FFButtonOptions(
                                  width: 100,
                                  height: 30,
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                  color: FlutterFlowTheme.of(context).primaryColor,
                                  textStyle: FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Pretendard',
                                    color: FlutterFlowTheme.of(context).white,
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
                        )

                      ),
                    ],
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
                                await FirebaseAuth.instance.currentUser!.reload();
                                setState(() {
                                  _model.emailVerification = FirebaseAuth.instance.currentUser?.emailVerified;

                                });


                                if (!_model.emailVerification!) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '이메일에서 인증을 해주세요',
                                      ),
                                    ),
                                  );
                                  return;
                                }


                                context.pushNamedAuth(
                                  'SignupPage2',
                                  mounted,
                                  queryParams: {
                                    'emailstring': serializeParam(
                                      _model.emailController.text,
                                      ParamType.String,
                                    ),
                                  }.withoutNulls,
                                );
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
