import 'package:carenco/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'activity_main.dart';
import 'activity_monitoring.dart';
import 'activity_vision.dart';

class ActivitySelectWidget extends StatefulWidget {
  const ActivitySelectWidget({Key? key}) : super(key: key);

  @override
  _ActivitySelectWidgetState createState() => _ActivitySelectWidgetState();
}

class _ActivitySelectWidgetState extends State<ActivitySelectWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Color(0xFF141515)),
          automaticallyImplyLeading: true,
          title: Text(
            '측정 방법 선택',
            style: FlutterFlowTheme.of(context).title3.override(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              useGoogleFonts: false,

            ),
          ),
          actions: [],
          centerTitle: true,
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          elevation: 0,
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '신체 밸런스 측정방식을 선택해 주세요',
                          style: FlutterFlowTheme.of(context).title3.override(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            useGoogleFonts: false,

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 10),
                        child: Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ActivityVisionWidget()),
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      30, 0, 0, 0),
                                  child: Text(
                                    'Vision 자세 분석 >\n'
                                    '구현중인 서비스 입니다',
                                    style: Theme.of(context).textTheme.subtitle1,
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 20, 20, 20),
                                        child: SvgPicture.asset(
                                          'assets/illust_vision_default.svg',
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Color(0xFFE2E2E2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Color(0x33C8C8C8),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 10),
                        child: Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ActivityMonitoringWidget()),
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      30, 0, 0, 0),
                                  child: Text(
                                    'Footprint 분석 >',
                                    style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      color: Color(0xFFB0FFA3),
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 20, 20, 20),
                                        child: SvgPicture.asset(
                                          'assets/illust_footprint_default_pressed.svg',
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Color(0xFF141514),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Color(0xFFB0FFA3),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(),
                  ),
                ),
                Expanded(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  context.pushNamed('HomePage');
                                },
                                child: Text(
                                  '처음으로',
                                  style: FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    useGoogleFonts: false,
                                    color:Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    minimumSize:
                                        const Size(double.infinity, 50),
                                    backgroundColor: Color(0xFF000000),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0))))
                          ],
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
