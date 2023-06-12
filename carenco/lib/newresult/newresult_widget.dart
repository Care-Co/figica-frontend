import 'dart:convert';

import 'package:carenco/newhome/newhome_widget.dart';

import '../flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'newresult_model.dart';
export 'newresult_model.dart';

class NewresultWidget extends StatefulWidget {

  final String bodydata;
  const NewresultWidget(this.bodydata, {Key? key}) : super(key: key);
  @override
  _NewresultWidgetState createState() => _NewresultWidgetState();
}

class _NewresultWidgetState extends State<NewresultWidget> {
  late NewresultModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();


  String type(int typeint){
    String types = "";
    switch (typeint) {
      case 1:
        types = "정상";
        break;
      case 2:
        types = "요족";
        break;
      case 3:
        types = "평발";
        break;
      case 4:
        types = "척추 전만";
        break;
      case 5:
        types = "척추 후만";
        break;
      case 6:
        types = "축추 촤측만";
        break;
      case 7:
        types = "축추 우측만";
        break;
      case 8:
        types = "골반 비트림";
        break;
    }
    return types;
  }
  String headline(int typeint){
    String types = "";
    switch (typeint) {
      case 1:
        types = "좋은 자세를 유지하고 있어요!";
        break;
      case 2&3:
        types = "발바닥 아치의 변형을 체크해 주세요!";
        break;
      default:
        types =  "잘못된 자세 습관을 확인해 보세요!";

    }
    return types;
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewresultModel());
  }


  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).black,

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: FlutterFlowTheme.of(context).white),
          automaticallyImplyLeading: true,
          centerTitle: true,
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          elevation: 0,
          title: Container(
            child: Text("Footprint 측정결과",
              style:
              FlutterFlowTheme.of(context).subtitle1.override(
                fontFamily: 'Pretendard',
                color: FlutterFlowTheme.of(context).white,
                fontWeight: FontWeight.w600,
                useGoogleFonts: false,
              ),),

          ),



        ),
        body: SlidingUpPanel(
          maxHeight: 700,

          panel: Center(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                    child: Text(
                      headline(jsonDecode(widget.bodydata)['type']),
                      style: FlutterFlowTheme.of(context).subtitle1.override(
                        fontFamily: 'Pretendard',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        useGoogleFonts: false,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).grey200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Type',
                                  style: FlutterFlowTheme.of(context).subtitle1.override(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    useGoogleFonts: false,
                                  ),
                                ),
                                Text(
                                  type(jsonDecode(widget.bodydata)['type']),
                                  style: FlutterFlowTheme.of(context).subtitle1.override(
                                    fontFamily: 'Pretendard',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            child: VerticalDivider(
                              thickness: 1,
                              indent: 20,
                              endIndent: 20,
                              color: FlutterFlowTheme.of(context).grey700,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '유사도',
                                  style: FlutterFlowTheme.of(context).subtitle1.override(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    useGoogleFonts: false,
                                  ),
                                ),
                                Text(
                                  '${jsonDecode(widget.bodydata)['similarity']}%',
                                  style: FlutterFlowTheme.of(context).subtitle1.override(
                                    fontFamily: 'Pretendard',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts: false,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                    child: Text(
                      '증상 분석',
                      style: FlutterFlowTheme.of(context).subtitle1.override(
                        fontFamily: 'Pretendard',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        useGoogleFonts: false,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    child: Text(
                      "${jsonDecode(widget.bodydata)['description']}",
                      style: FlutterFlowTheme.of(context).subtitle1,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                            child: FFButtonWidget(
                              onPressed: () async {
                                context.pushNamed('newscan');
                              },
                              text: '다시 측정하기',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 50,
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: FlutterFlowTheme.of(context).white,
                                textStyle: FlutterFlowTheme.of(context).subtitle1.override(
                                  fontFamily: 'Pretendard',
                                  color: FlutterFlowTheme.of(context).black,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: false,
                                ),
                                elevation: 3,
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).black,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                            child: FFButtonWidget(
                              onPressed: () async {
                                Navigator.push(

                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewhomeWidget(widget.bodydata)
                                    )
                                );
                              },
                              text: '확인',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 50,
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: FlutterFlowTheme.of(context).black,
                                textStyle: FlutterFlowTheme.of(context).subtitle1.override(
                                  fontFamily: 'Pretendard',
                                  color: FlutterFlowTheme.of(context).white,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: false,
                                ),
                                elevation: 3,
                                borderSide: BorderSide(
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
            ,
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).black,
            ),
            alignment: AlignmentDirectional(0, -1),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                //'https://picsum.photos/seed/856/600',


                jsonDecode(widget.bodydata)['image'],
                width: 400,
                height: 400,
                fit: BoxFit.contain,
              ),

              ),
            ),
          )
      ),
    );
  }
}
