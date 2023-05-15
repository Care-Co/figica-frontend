import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'activity_select.dart';

class ActivityTosWidget extends StatefulWidget {
  const ActivityTosWidget({Key? key}) : super(key: key);

  @override
  _ActivityTosWidgetState createState() => _ActivityTosWidgetState();
}

class _ActivityTosWidgetState extends State<ActivityTosWidget> {
  bool? checkboxValue1;
  bool? checkboxValue2;
  bool? checkboxValue3;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  void checktos() {
    if (checkboxValue1 == true) {
      checkboxValue2 = true;
      checkboxValue3 = true;
    } else if (checkboxValue1 == false) {
      checkboxValue2 = false;
      checkboxValue3 = false;
    }
  }

/* 이용약관동의 2*/
  void tos2Dialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            insetPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              '민감정보 수집 및 이용에 대한 동의 (필수)',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
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
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  50, 10, 50, 30),
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
            actions: <Widget>[
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ElevatedButton(
                        child: Text(
                          '확인',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(400, 40),
                            backgroundColor: Color(0xFfB0FFA3),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    new BorderRadius.circular(40.0)))),
                  ],
                ),
              ),
            ],
          );
        });
  }

  void tos1Dialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            insetPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              '일반 개인정보 수집 및 이용 동의 (필수)',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
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
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  50, 10, 50, 30),
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
            actions: <Widget>[
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ElevatedButton(
                        child: Text(
                          '확인',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(400, 40),
                            backgroundColor: Color(0xFfB0FFA3),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    new BorderRadius.circular(40.0)))),
                  ],
                ),
              ),
            ],
          );
        });
  }
/* 이용약관동의 1*/

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF141514),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: true,
          title: Text(
            '약관 동의',
            style: FlutterFlowTheme.of(context).title3.override(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              useGoogleFonts: false,
              color:Colors.white,
            ),
          ),
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
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/images/[()].svg',
                          width: 70,
                          height: 70,
                          color: Colors.white,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                          child: Text(
                            '환영합니다!',
                            style: FlutterFlowTheme.of(context).title3.override(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: false,
                              color:Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          '간단한 동의후 케어엔코 서비스를 시작해보세요.',
                          style: FlutterFlowTheme.of(context).title3.override(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            useGoogleFonts: false,
                            color:Colors.white,
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
                    decoration: BoxDecoration(),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 5),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Theme(
                                data: ThemeData(
                                    checkboxTheme: CheckboxThemeData(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    unselectedWidgetColor: Colors.white),
                                child: Checkbox(
                                    value: checkboxValue1 ??= false,
                                    onChanged: (newValue) async {
                                      setState(
                                          () => checkboxValue1 = newValue!);
                                      checktos();
                                    },
                                    activeColor: Color(0xFFB0FFA3),
                                    checkColor: Colors.black),
                              ),
                              Text(
                                '약관 전체 동의',
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
                        Divider(thickness: 1, color: Colors.white),
                        Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                          checkboxTheme: CheckboxThemeData(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          unselectedWidgetColor: Colors.white),
                                      child: Checkbox(
                                          value: checkboxValue2 ??= false,
                                          onChanged: (newValue) async {
                                            setState(() =>
                                                checkboxValue2 = newValue!);
                                          },
                                          activeColor: Color(0xFFB0FFA3),
                                          checkColor: Colors.black),
                                    ),
                                    Text(
                                      '이용 약관 동의(필수)',
                                      style: FlutterFlowTheme.of(context)
                                          .subtitle1
                                          .override(
                                        fontFamily: 'Pretendard',
                                        color: FlutterFlowTheme.of(context).white,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: false,
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.keyboard_arrow_right,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                            onPressed: () => tos1Dialog(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                          checkboxTheme: CheckboxThemeData(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          unselectedWidgetColor: Colors.white),
                                      child: Checkbox(
                                          value: checkboxValue3 ??= false,
                                          onChanged: (newValue) async {
                                            setState(() =>
                                                checkboxValue3 = newValue!);
                                          },
                                          activeColor: Color(0xFFB0FFA3),
                                          checkColor: Colors.black),
                                    ),
                                    Text(
                                      '개인정보 수집 및 이용동의(필수)',
                                      style: FlutterFlowTheme.of(context)
                                          .subtitle1
                                          .override(
                                        fontFamily: 'Pretendard',
                                        color: FlutterFlowTheme.of(context).white,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: false,
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.keyboard_arrow_right,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                            onPressed: () => tos2Dialog(),
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
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(),
                  ),
                ),
                Expanded(
                    child: Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ElevatedButton(
                                onPressed: (checkboxValue1 == true)
                                    ? () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ActivitySelectWidget()),
                                        );
                                      }
                                    : null,
                                child: Text(
                                  '시작하기',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    color: (checkboxValue1 == true)
                                        ? Color(0xFF000000)
                                        : Color(0xFFA4A4A4),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    minimumSize:
                                        const Size(double.infinity, 50),
                                    backgroundColor: (checkboxValue1 == true)
                                        ? Color(0xFFB0FFA3)
                                        : Color(0xFFEBEBEB),
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
