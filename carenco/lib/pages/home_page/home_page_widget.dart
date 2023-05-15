import '../../activity_tos.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
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
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
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
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 10.0, 24.0, 10.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/images/[()].svg',
                        width: 85.0,
                        height: 80.0,
                        fit: BoxFit.fill,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 10.0, 10.0, 10.0),
                              child: FFButtonWidget(
                                onPressed: () {
                                  {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ActivityTosWidget()),
                                    );
                                  }
                                },
                                text: '체험 모드',
                                options: FFButtonOptions(
                                  width: 69.0,
                                  height: 28.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: Colors.transparent,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Pretendard',
                                        color: FlutterFlowTheme.of(context)
                                            .grey500,
                                        useGoogleFonts: false,
                                      ),
                                  elevation: 0,
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).grey500,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(14.0),
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
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 10.0, 24.0, 20.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                        child: Text(
                          '만나서 반가워요!',
                          style: FlutterFlowTheme.of(context).title1.override(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: false,
                              ),
                        ),
                      ),
                      Text(
                        '시작하기 위해서는 로그인이 필요해요',
                        style: FlutterFlowTheme.of(context).subtitle2.override(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.normal,
                              useGoogleFonts: false,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 24.0, 20.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    // children: [
                    //   Padding(
                    //     padding:
                    //         EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                    //     child: InkWell(
                    //       onTap: () async {
                    //         context.pushNamed('HomePage');
                    //       },
                    //       child: Container(
                    //         width: 327.0,
                    //         height: 56.0,
                    //         decoration: BoxDecoration(
                    //           color: FlutterFlowTheme.of(context)
                    //               .secondaryBackground,
                    //           borderRadius: BorderRadius.circular(0.0),
                    //         ),
                    //         child: ClipRRect(
                    //           borderRadius: BorderRadius.circular(12.0),
                    //           child: Image.network(
                    //             'https://picsum.photos/seed/406/600',
                    //             width: 100.0,
                    //             height: 100.0,
                    //             fit: BoxFit.cover,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    //   Padding(
                    //     padding:
                    //         EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                    //     child: InkWell(
                    //       onTap: () async {
                    //         context.pushNamed('HomePage');
                    //       },
                    //       child: Container(
                    //         width: 327.0,
                    //         height: 56.0,
                    //         decoration: BoxDecoration(
                    //           color: FlutterFlowTheme.of(context)
                    //               .secondaryBackground,
                    //           borderRadius: BorderRadius.circular(0.0),
                    //         ),
                    //         child: ClipRRect(
                    //           borderRadius: BorderRadius.circular(12.0),
                    //           child: Image.network(
                    //             'https://picsum.photos/seed/406/600',
                    //             width: 100.0,
                    //             height: 100.0,
                    //             fit: BoxFit.cover,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    //   InkWell(
                    //     onTap: () async {
                    //       context.pushNamed('HomePage');
                    //     },
                    //     child: Container(
                    //       width: 327.0,
                    //       height: 56.0,
                    //       decoration: BoxDecoration(
                    //         color: FlutterFlowTheme.of(context)
                    //             .secondaryBackground,
                    //         borderRadius: BorderRadius.circular(0.0),
                    //       ),
                    //       child: ClipRRect(
                    //         borderRadius: BorderRadius.circular(12.0),
                    //         child: Image.network(
                    //           'https://picsum.photos/seed/406/600',
                    //           width: 100.0,
                    //           height: 100.0,
                    //           fit: BoxFit.cover,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ],
                  ),
                ),
              ),
              Divider(
                thickness: 1.0,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 24.0, 20.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                        child: InkWell(
                          onTap: () async {
                            //context.pushNamed('Main_login');
                          },
                          child: Container(
                            width: 327.0,
                            height: 56.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).black,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '이메일로 로그인',
                                  style: FlutterFlowTheme.of(context)
                                      .subtitle1
                                      .override(
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: false,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          //context.pushNamed('TosPage');
                        },
                        child: Container(
                          width: 327.0,
                          height: 56.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).black,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '이메일로 회원가입',
                                style: FlutterFlowTheme.of(context)
                                    .subtitle1
                                    .override(
                                      fontFamily: 'Pretendard',
                                      color: FlutterFlowTheme.of(context).white,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: false,
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
              Container(
                width: double.infinity,
                height: 100.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
