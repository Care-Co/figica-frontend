import 'package:flutter_svg/svg.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'newhome_model.dart';
export 'newhome_model.dart';

class NewhomeWidget extends StatefulWidget {
  final String bodydata;
  const NewhomeWidget(this.bodydata,{Key? key}) : super(key: key);

  @override
  _NewhomeWidgetState createState() => _NewhomeWidgetState();
}

class _NewhomeWidgetState extends State<NewhomeWidget> {
  late NewhomeModel _model;
  String abtsrc = "";

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewhomeModel());

  }
  String type(int typeint){
    String types = "";
    switch (typeint) {
      case 1:
        types = "정상";
        abtsrc = "assets/body3d/Avata.glb";
        break;
      case 2:
        types = "요족";
        abtsrc = "assets/body3d/Avata.glb";
        break;
      case 3:
        types = "평발";
        abtsrc = "assets/body3d/Avata.glb";
        break;
      case 4:
        types = "척추 전만";
        abtsrc = "assets/body3d/Avata_front.glb";
        break;
      case 5:
        types = "척추 후만";
        abtsrc = "assets/body3d/Avata_back.glb";
        break;
      case 6:
        types = "축추 촤측만";
        abtsrc = "assets/body3d/Avata_left.glb";
        break;
      case 7:
        types = "축추 우측만";
        abtsrc = "assets/body3d/Avata_right.glb";
        break;
      case 8:
        types = "골반 비트림";
        abtsrc = "assets/body3d/Avata_roll.glb";
        break;
    }
    return types;
  }

  String abt(int typeint){
    String types = "";
    switch (typeint) {
      case 1:
        types = "정상";
        abtsrc = "assets/body3d/Avata.glb";
        break;
      case 2:
        types = "요족";
        abtsrc = "assets/body3d/Avata.glb";
        break;
      case 3:
        types = "평발";
        abtsrc = "assets/body3d/Avata.glb";
        break;
      case 4:
        types = "척추 전만";
        abtsrc = "assets/body3d/Avata_front.glb";
        break;
      case 5:
        types = "척추 후만";
        abtsrc = "assets/body3d/Avata_back.glb";
        break;
      case 6:
        types = "축추 촤측만";
        abtsrc = "assets/body3d/Avata_left.glb";
        break;
      case 7:
        types = "축추 우측만";
        abtsrc = "assets/body3d/Avata_right.glb";
        break;
      case 8:
        types = "골반 비트림";
        abtsrc = "assets/body3d/Avata_roll.glb";
        break;
    }
    return abtsrc;
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
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(24, 28, 0, 0),
                          child: Text(
                            '안녕하세요!',
                            style: FlutterFlowTheme.of(context)
                                .subtitle1
                                .override(
                              fontFamily: 'Pretendard',
                              color: FlutterFlowTheme.of(context).white,
                              fontSize: 16,
                              useGoogleFonts: false,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                          child: Text(
                            '회원님',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .subtitle1
                                .override(
                              fontFamily: 'Pretendard',
                              color: FlutterFlowTheme.of(context).white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              useGoogleFonts: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                            child: Icon(
                              Icons.notifications_none_rounded,
                              color: FlutterFlowTheme.of(context).white,
                              size: 24,
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
                height: 600,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(1, 0.8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SvgPicture.asset(
                          'assets/svg/avatar_footer.svg',
                          width: 332,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),




                    Align(
                      alignment: AlignmentDirectional(2, -0.6),
                      child: Container(
                        child: ModelViewer(
                          disableZoom: true,
                          disablePan: true,
                          disableTap: true,
                          backgroundColor: Colors.transparent,
                          src: abt(jsonDecode(widget.bodydata)['type']), // a bundled asset file
                        ),
                        width: 300,
                        height: 526,
                      ),
                    ),



                    Align(
                      alignment: AlignmentDirectional(-0.7, -0.6),
                      child: Container(
                        width: 172,
                        height: 140,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0x14FCFCFF), Color(0x7AFCFDFF)],
                            stops: [0, 1],
                            begin: AlignmentDirectional(0.87, 1),
                            end: AlignmentDirectional(-0.87, -1),
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 14, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                      child: Text(
                                        'Footprint',
                                        textAlign: TextAlign.start,
                                        style:
                                        FlutterFlowTheme.of(context).subtitle1.override(
                                          fontFamily: 'Pretendard',
                                          color: FlutterFlowTheme.of(context).grey200,
                                          fontWeight: FontWeight.w600,
                                          useGoogleFonts: false,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      type(jsonDecode(widget.bodydata)['type']),

                                      style: FlutterFlowTheme.of(context).subtitle1.override(
                                        fontFamily: 'Pretendard',
                                        color: FlutterFlowTheme.of(context).white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: false,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                      child: Text(
                                        '${jsonDecode(widget.bodydata)['similarity']}%',
                                        style:
                                        FlutterFlowTheme.of(context).subtitle1.override(
                                          fontFamily: 'Pretendard',
                                          color: FlutterFlowTheme.of(context).grey200,
                                          fontWeight: FontWeight.normal,
                                          useGoogleFonts: false,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                      child: Text(
                                        headline(jsonDecode(widget.bodydata)['type']),
                                        style:
                                        FlutterFlowTheme.of(context).subtitle1.override(
                                          fontFamily: 'Pretendard',
                                          color: FlutterFlowTheme.of(context).white,
                                          useGoogleFonts: false,
                                        ),
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



                    Align(
                      alignment: AlignmentDirectional(-0.7, -1),
                      child: Container(
                        width: 172,
                        height: 88,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0x14FCFCFF), Color(0x7AFCFDFF)],
                            stops: [0, 1],
                            begin: AlignmentDirectional(0.87, 1),
                            end: AlignmentDirectional(-0.87, -1),
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 14, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                    child: Text(
                                      '신장',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context).subtitle1.override(
                                        fontFamily: 'Pretendard',
                                        color: FlutterFlowTheme.of(context).grey200,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: false,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '170 cm',
                                    style: FlutterFlowTheme.of(context).subtitle1.override(
                                      fontFamily: 'Pretendard',
                                      color: FlutterFlowTheme.of(context).white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(14, 0, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                    child: Text(
                                      '체중',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context).subtitle1.override(
                                        fontFamily: 'Pretendard',
                                        color: FlutterFlowTheme.of(context).grey200,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: false,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    jsonDecode(widget.bodydata)['weight'],
                                    style: FlutterFlowTheme.of(context).subtitle1.override(
                                      fontFamily: 'Pretendard',
                                      color: FlutterFlowTheme.of(context).white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
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

                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 1),
                        child: Container(
                          width: double.infinity,
                          height: 00,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).grey850,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 16, 0, 0),
                                      child: Icon(
                                        Icons.home_filled,
                                        color:
                                        FlutterFlowTheme.of(context).white,
                                        size: 24,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 4, 0, 0),
                                      child: Text(
                                        'Home',
                                        style: FlutterFlowTheme.of(context)
                                            .subtitle1
                                            .override(
                                          fontFamily: 'Pretendard',
                                          color:
                                          FlutterFlowTheme.of(context)
                                              .white,
                                          useGoogleFonts: false,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 16, 0, 0),
                                      child: Icon(
                                        Icons.perm_identity,
                                        color: FlutterFlowTheme.of(context)
                                            .grey500,
                                        size: 24,
                                      ),
                                    ),
                                    Text(
                                      'MY',
                                      style: FlutterFlowTheme.of(context)
                                          .subtitle1
                                          .override(
                                        fontFamily: 'Pretendard',
                                        color: FlutterFlowTheme.of(context)
                                            .grey500,
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
                      Align(
                        alignment: AlignmentDirectional(0, -0.8),
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).darkenGreen,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.accessibility,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
