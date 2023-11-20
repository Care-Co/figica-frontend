import 'package:figica/auth/firebase_auth/auth_util.dart';
import 'package:figica/flutter_set/figica_theme.dart';
import 'package:figica/flutter_set/internationalization.dart';

import '../flutter_set/flutter_flow_theme.dart';
import '../flutter_set/flutter_flow_util.dart';
import '../flutter_set/flutter_flow_widgets.dart';
import '/plan/updateplan/updateplan_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
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
        backgroundColor: FlutterFlowTheme.of(context).primaryText,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(1.00, 0.00),
                        child: Container(
                          width: 300.0,
                          height: double.infinity,
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: SvgPicture.asset(
                                  'assets/images/avatar_footer.svg',
                                  width: 700.0,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1.00, 0.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                SetLocalizations.of(context).getText(
                                  'o84ubxz5' /* 안녕하세요 */,
                                ),
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Pretendard',
                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                      useGoogleFonts: false,
                                    ),
                              ),
                              Text(
                                SetLocalizations.of(context).getText(
                                  '0kseg516' /* Hello World */,
                                ),
                                style: FlutterFlowTheme.of(context).titleMedium,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                                child: Container(
                                  width: 192.0,
                                  height: 88.0,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Color(0xADFCFDFF), Color(0x2FFCFDFF)],
                                      stops: [0.0, 1.0],
                                      begin: AlignmentDirectional(0.07, -1.0),
                                      end: AlignmentDirectional(-0.07, 1.0),
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              SetLocalizations.of(context).getText(
                                                'goa2jpgy' /* 신장 */,
                                              ),
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Pretendard',
                                                    color: Color(0xFFAEB2B8),
                                                    fontSize: 12.0,
                                                    useGoogleFonts: false,
                                                  ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                              child: Text(
                                                SetLocalizations.of(context).getText(
                                                  'jresko8m' /* 172cm */,
                                                ),
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Pretendard',
                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                      useGoogleFonts: false,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40.0,
                                        child: VerticalDivider(
                                          thickness: 1.0,
                                          color: FlutterFlowTheme.of(context).accent4,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 20.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              SetLocalizations.of(context).getText(
                                                '5gfls12l' /* 체중 */,
                                              ),
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Pretendard',
                                                    color: Color(0xFFAEB2B8),
                                                    fontSize: 12.0,
                                                    useGoogleFonts: false,
                                                  ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                              child: Text(
                                                SetLocalizations.of(context).getText(
                                                  'co3mfz1a' /* 54.6kg */,
                                                ),
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Pretendard',
                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
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
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                                child: Container(
                                  width: 192.0,
                                  height: 88.0,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Color(0xADFCFDFF), Color(0x2FFCFDFF)],
                                      stops: [0.0, 1.0],
                                      begin: AlignmentDirectional(0.07, -1.0),
                                      end: AlignmentDirectional(-0.07, 1.0),
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              SetLocalizations.of(context).getText(
                                                'zc3l3zq2' /* 신장 */,
                                              ),
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Pretendard',
                                                    color: Color(0xFFAEB2B8),
                                                    fontSize: 12.0,
                                                    useGoogleFonts: false,
                                                  ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                              child: Text(
                                                SetLocalizations.of(context).getText(
                                                  'w8hivjce' /* 172cm */,
                                                ),
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Pretendard',
                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                      useGoogleFonts: false,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40.0,
                                        child: VerticalDivider(
                                          thickness: 1.0,
                                          color: FlutterFlowTheme.of(context).accent4,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              SetLocalizations.of(context).getText(
                                                'umph7qhx' /* 체중 */,
                                              ),
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Pretendard',
                                                    color: Color(0xFFAEB2B8),
                                                    fontSize: 12.0,
                                                    useGoogleFonts: false,
                                                  ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                              child: Text(
                                                SetLocalizations.of(context).getText(
                                                  'rnl8flst' /* 54.6kg */,
                                                ),
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Pretendard',
                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
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
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                                child: Container(
                                  width: 192.0,
                                  height: 88.0,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Color(0x77FCFDFF), Color(0x2FFCFDFF)],
                                      stops: [0.0, 1.0],
                                      begin: AlignmentDirectional(0.07, -1.0),
                                      end: AlignmentDirectional(-0.07, 1.0),
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              SetLocalizations.of(context).getText(
                                                '4a0fxxdm' /* 일정 */,
                                              ),
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Pretendard',
                                                    color: Color(0xFFAEB2B8),
                                                    useGoogleFonts: false,
                                                  ),
                                            ),
                                            Icon(
                                              Icons.edit_outlined,
                                              color: Color(0xFFAEB2B8),
                                              size: 20.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                                child: Container(
                                  width: 192.0,
                                  height: 36.0,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Color(0x40FCFDFF), Color(0x2FFCFDFF)],
                                      stops: [0.0, 1.0],
                                      begin: AlignmentDirectional(0.07, -1.0),
                                      end: AlignmentDirectional(-0.07, 1.0),
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              SetLocalizations.of(context).getText(
                                                'dmhmhz0q' /* 새로운 일정 추가하기 */,
                                              ),
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Pretendard',
                                                    color: Color(0xFFAEB2B8),
                                                    useGoogleFonts: false,
                                                  ),
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor: Colors.transparent,
                                              onTap: () async {
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor: Colors.transparent,
                                                  enableDrag: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return GestureDetector(
                                                      onTap: () => _model.unfocusNode.canRequestFocus
                                                          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                          : FocusScope.of(context).unfocus(),
                                                      child: Padding(
                                                        padding: MediaQuery.viewInsetsOf(context),
                                                        child: Container(
                                                          height: MediaQuery.sizeOf(context).height * 0.8,
                                                          child: UpdateplanWidget(),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) => safeSetState(() {}));
                                              },
                                              child: Icon(
                                                Icons.add_circle_outline_rounded,
                                                color: Color(0xFFAEB2B8),
                                                size: 20.0,
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
