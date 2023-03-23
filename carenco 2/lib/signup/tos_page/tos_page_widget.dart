import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'tos_page_model.dart';
export 'tos_page_model.dart';

class TosPageWidget extends StatefulWidget {
  const TosPageWidget({Key? key}) : super(key: key);

  @override
  _TosPageWidgetState createState() => _TosPageWidgetState();
}

class _TosPageWidgetState extends State<TosPageWidget> {
  late TosPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TosPageModel());
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
        title: Text(
          '약관 동의',
          style: FlutterFlowTheme.of(context).title3.override(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                useGoogleFonts: false,
              ),
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 50.0, 24.0, 24.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 6.0),
                        child: Text(
                          '환영합니다!',
                          style: FlutterFlowTheme.of(context).title1.override(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: false,
                              ),
                        ),
                      ),
                      Text(
                        '간단한 동의 후\n케어엔코 서비스를 시작해 보세요',
                        style: FlutterFlowTheme.of(context).subtitle2.override(
                              fontFamily: 'Pretendard',
                              color: FlutterFlowTheme.of(context).grey700,
                              fontWeight: FontWeight.normal,
                              useGoogleFonts: false,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 10.0),
                      child: Container(
                        width: double.infinity,
                        height: 53.0,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).grey200,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  2.0, 0.0, 0.0, 0.0),
                              child: Theme(
                                data: ThemeData(
                                  checkboxTheme: CheckboxThemeData(
                                    shape: CircleBorder(),
                                  ),
                                  unselectedWidgetColor:
                                      FlutterFlowTheme.of(context).grey200,
                                ),
                                child: Checkbox(
                                  value: _model.checkboxValue1 ??= false,
                                  onChanged: (newValue) async {
                                    setState(() =>
                                        _model.checkboxValue1 = newValue!);
                                    if (newValue!) {
                                      setState(() {
                                        _model.checkboxValue2 = true;
                                        _model.checkboxValue3 = true;
                                        _model.allagree = true;
                                      });
                                    } else {
                                      setState(() {
                                        _model.checkboxValue2 = false;
                                        _model.checkboxValue3 = false;
                                        _model.allagree = false;
                                      });
                                    }
                                  },
                                  activeColor:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  checkColor:
                                      FlutterFlowTheme.of(context).white,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 20.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '약관 전체 동의',
                                      style: FlutterFlowTheme.of(context)
                                          .subtitle1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                2.0, 0.0, 0.0, 0.0),
                            child: Theme(
                              data: ThemeData(
                                checkboxTheme: CheckboxThemeData(
                                  shape: CircleBorder(),
                                ),
                                unselectedWidgetColor:
                                    FlutterFlowTheme.of(context).grey200,
                              ),
                              child: Checkbox(
                                value: _model.checkboxValue2 ??= false,
                                onChanged: (newValue) async {
                                  setState(
                                      () => _model.checkboxValue2 = newValue!);
                                  if (newValue! && _model.checkboxValue3!) {
                                    setState(() {
                                      _model.allagree = true;
                                      _model.checkboxValue1 = true;
                                    });
                                  } else {
                                    setState(() {
                                      _model.allagree = false;
                                      _model.checkboxValue1 = false;
                                    });
                                  }
                                },
                                activeColor:
                                    FlutterFlowTheme.of(context).primaryColor,
                                checkColor: FlutterFlowTheme.of(context).white,
                              ),
                            ),
                          ),
                          Text(
                            '이용 약관 동의 (필수)',
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Pretendard',
                                  color: FlutterFlowTheme.of(context).grey700,
                                  useGoogleFonts: false,
                                ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30.0,
                                  borderWidth: 1.0,
                                  buttonSize: 40.0,
                                  icon: Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 20.0,
                                  ),
                                  onPressed: () async {
                                    var confirmDialogResponse =
                                        await showDialog<bool>(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  contentPadding: EdgeInsets.all(0),
                                                  insetPadding: EdgeInsets.all(10),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  title: Text('이용약관'),
                                                  content: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        height: 500,
                                                        width: 400,
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.max,
                                                          children: [
                                                            Expanded(
                                                                child: Padding(
                                                                    padding:
                                                                    EdgeInsetsDirectional.fromSTEB(50, 10, 50, 30),
                                                                    child: SingleChildScrollView(
                                                                      scrollDirection: Axis.vertical,
                                                                      child: Text(
                                                                        "외부 측정기기를 통해 측정되고 분석된 정보(체중, 체지방률, 체지방량, 제지방량, 근육량, 체수분량, 체수분율, 기초대사량, 추정골량, BMI, 내장지방레벨, 복부비만정보, 심박, 수면, 혈압, 혈당, 측정일자, 수축기 혈압, 이완기 혈압, 공복혈당, 식후혈당, 걸음수, 칼로리 소모량, 보행 거리, 보행 시간, 보행수 랭킹 등), 건강질환정보, 고혈압 유무, 당뇨유무, 투약여부 및 복약정보 등",
                                                                        style: TextStyle(
                                                                          fontFamily: 'Pretendard',
                                                                          color: Color(0xff000000),
                                                                          fontSize: 16,
                                                                        ),
                                                                      ),
                                                                    )))
                                                          ],

                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext,
                                                              false),
                                                      child: Text('취소'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () => {
                                                        setState(() {
                                                          _model.checkboxValue2 = true;
                                                          if (_model.checkboxValue2! && _model.checkboxValue3!) {
                                                            setState(() {
                                                              _model.allagree = true;
                                                              _model.checkboxValue1 = true;
                                                            });
                                                          } else {
                                                            setState(() {
                                                              _model.allagree = false;
                                                              _model.checkboxValue1 = false;
                                                            });
                                                          }
                                                        }),
                                                        Navigator.pop(
                                                            alertDialogContext,
                                                            true),
                                                      },
                                                      child: Text('동의'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ) ??
                                            false;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 5.0, 20.0, 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                2.0, 0.0, 0.0, 0.0),
                            child: Theme(
                              data: ThemeData(
                                checkboxTheme: CheckboxThemeData(
                                  shape: CircleBorder(),
                                ),
                                unselectedWidgetColor:
                                    FlutterFlowTheme.of(context).grey200,
                              ),
                              child: Checkbox(
                                value: _model.checkboxValue3 ??= false,
                                onChanged: (newValue) async {
                                  setState(
                                          () => _model.checkboxValue3 = newValue!);
                                  if (newValue! && _model.checkboxValue2!) {
                                    setState(() {
                                      _model.allagree = true;
                                      _model.checkboxValue1 = true;
                                    });
                                  } else {
                                    setState(() {
                                      _model.allagree = false;
                                      _model.checkboxValue1 = false;
                                    });
                                  }
                                },
                                activeColor:
                                    FlutterFlowTheme.of(context).primaryColor,
                                checkColor: FlutterFlowTheme.of(context).white,
                              ),
                            ),
                          ),
                          Text(
                            '개인정보 수집 및 이용동의(필수)',
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Pretendard',
                                  color: FlutterFlowTheme.of(context).grey700,
                                  useGoogleFonts: false,
                                ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30.0,
                                  borderWidth: 1.0,
                                  buttonSize: 40.0,
                                  icon: Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 20.0,
                                  ),
                                  onPressed: () async {
                                    var confirmDialogResponse =
                                        await showDialog<bool>(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(10),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              title: Text('이용약관'),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    height: 500,
                                                    width: 400,
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                            child: Padding(
                                                                padding:
                                                                EdgeInsetsDirectional.fromSTEB(50, 10, 50, 30),
                                                                child: SingleChildScrollView(
                                                                  scrollDirection: Axis.vertical,
                                                                  child: Text(
                                                                    "성명, 생년월일, 족저압 측정정보, 체중, 비전 모드 사용 시 촬영 되는 이미지, 휴대폰번호, 이메일 주소, ID(간편가입 시 연동계정 ID 및 연동 정보), 국가코드, 언어코드, 기기정보: 스마트폰 기기의 OS버전, 모델명, 기기고유식별정보(IMEI, 시리얼넘버, Mac address), 위치정보, USIM 번호, 사업자코드, 국가코드, 앱 및 앱내 서비스 이용시 자동적으로 생성되는 정보 (서비스 이용기록), 소프트웨어 플랫폼 버전, 서비스를 위한 registration ID, 접속 로그, 외부기기의 device id 등",
                                                                    style: TextStyle(
                                                                      fontFamily: 'Pretendard',
                                                                      color: Color(0xff000000),
                                                                      fontSize: 16,
                                                                    ),
                                                                  ),
                                                                )))
                                                      ],

                                                    ),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext,
                                                          false),
                                                  child: Text('취소'),
                                                ),
                                                TextButton(
                                                  onPressed: () => {
                                                    setState(() {
                                                      _model.checkboxValue3 = true;
                                                      if (_model.checkboxValue2! && _model.checkboxValue3!) {
                                                        setState(() {
                                                          _model.allagree = true;
                                                          _model.checkboxValue1 = true;
                                                        });
                                                      } else {
                                                        setState(() {
                                                          _model.allagree = false;
                                                          _model.checkboxValue1 = false;
                                                        });
                                                      }
                                                    }),
                                                    Navigator.pop(
                                                        alertDialogContext,
                                                        true),
                                                  },
                                                  child: Text('동의'),
                                                ),
                                              ],
                                            );
                                          },
                                        ) ??
                                            false;
                                  },
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
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 20.0, 20.0, 20.0),
                            child: FFButtonWidget(
                              onPressed: (_model.allagree!)? () async{

                                context.pushNamed('SignupPage');
                              }:null,
                              text: '다음',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 56.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: _model.allagree!
                                    ? FlutterFlowTheme.of(context).black
                                    : FlutterFlowTheme.of(context).grey200,
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Pretendard',
                                      color: Colors.white,
                                      useGoogleFonts: false,
                                    ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
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
