import 'package:firebase_auth/firebase_auth.dart';

import '../../flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'interest_model.dart';
export 'interest_model.dart';

class InterestWidget extends StatefulWidget {
  const InterestWidget({Key? key}) : super(key: key);

  @override
  _InterestWidgetState createState() => _InterestWidgetState();
}

class _InterestWidgetState extends State<InterestWidget> {
  late InterestModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  List<String> interestList = [
    '다이어트',
    '건강기록',
    '복싱',
    '자세교정',
    '댄스',
    '헬스',
    '당뇨',
    '필라테스',
  ];
  List<bool> color = [
    false,false,false,false,false,false,false,false,

  ];
  List<String> inter = [];
  List<bool> click = [];

  Color clickcolor(bool click){
    if (!click){
      return Colors.transparent;
    }
    else{
      return FlutterFlowTheme.of(context).figicoGreen;
    }
  }
  final firestore = FirebaseFirestore.instance;
  updateUserData() {

      firestore.collection("users").doc(FirebaseAuth.instance.currentUser?.uid).update({
        'interest' : inter,
      });

    context.pushNamed('MainPage');
  }
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InterestModel());

    _model.addController ??= TextEditingController();
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
              '관심사 선택',
              style: FlutterFlowTheme.of(context).title3.override(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    useGoogleFonts: false,
                  ),
            ),
            Text(
              '맞춤형 정보 제공을 위해 관심사를 선택해 주세요',
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
        elevation: 0.0,
      ),
      body: SafeArea(
        child: GestureDetector(

          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Container(

                width: 400,
                height: 300,
                child: GridView.builder(
                    itemCount: interestList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                      childAspectRatio: 2 / 1, //item 의 가로 1, 세로 2 의 비율
                      mainAxisSpacing: 3, //수평 Padding
                      crossAxisSpacing: 3, //수직 Padding
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              bool remove = false;
                              inter.forEach((element) {
                                if (element == interestList[index]) {
                                  remove = true;
                                }
                              });
                              if (!remove){
                                inter.add(interestList[index]);
                                setState(() {
                                  color[index] = true;
                                });
                              }
                              else{
                                inter.remove(interestList[index]);
                                setState(() {
                                  color[index] = false;

                                });
                              }
                              print(inter);
                            },
                            child: Container(
                              margin:EdgeInsets.all(6),
                              height: 40,
                              decoration: BoxDecoration(
                                color: clickcolor(color[index]),
                                borderRadius: BorderRadius.circular(41),
                                border: Border.all(
                                  color: color[index]? Colors.transparent:FlutterFlowTheme.of(context).black,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 5, 16, 5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 5, 0),
                                      child:
                                      Icon(color[index]? Icons.check_circle:Icons.check_circle_outline_rounded,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                    ),
                                    Text(
                                      (interestList[index]),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    }),
              ),
              Container(
                child: Container(
                  margin:EdgeInsets.all(6),
                  height: 70,
                  width: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(41),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).black,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        16, 5, 16, 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Form(
                          key: _model.formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Container(
                            width: MediaQuery.of(context).size.height * 0.3,
                            decoration: BoxDecoration(),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 5, 0),
                                    child:
                                    FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 30,
                                      borderWidth: 1,
                                      buttonSize: 60,
                                      icon: Icon(
                                        Icons.add_circle_outline_rounded,
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        print(_model.addController.text);
                                        setState(() {
                                          interestList.add(_model.addController.text);
                                          inter.add(_model.addController.text);
                                          color.add(true);
                                        });

                                      },
                                    )
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: _model.addController,
                                    autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: '추가',
                                      hintStyle: FlutterFlowTheme.of(context).bodyText2,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    style: FlutterFlowTheme.of(context).bodyText1,
                                    textAlign: TextAlign.center,
                                    validator: _model.addControllerValidator.asValidator(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )

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
                            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                            child: FFButtonWidget(
                              onPressed: () async {
                                updateUserData();
                              },
                              text: '다음',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 42,
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: FlutterFlowTheme.of(context).primaryColor,
                                textStyle: FlutterFlowTheme.of(context).subtitle2.override(
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
              )


            ],

          ),
        ),
      ),
    );
  }
}
