import 'package:flutter/material.dart';
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
    }
    else if(checkboxValue1 == false) {
      checkboxValue2 = false;
      checkboxValue3 = false;
    }
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
              '서비스 이용 약관',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Poppins',
              ),
            ),
            actions: <Widget>[
              Container(
                width: 500,
                height: 400,
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
                                "서비스 이용 약관 서비스 이용 약관서비스 이용 약관서비스 이용 약관서비스 이용 약관서비스 이용 약관"
                                "서비스 이용 약관서비스 이용 약관서비스 이용 약관서비스 이용 약관서비스 이용 약관서비스 이용 약관"
                                "서비스 이용 약관서비스 이용 약관서비스 이용 약관서비스 이용 약관서비스 이용 약관"
                                "서비스 이용 약관 서비스 이용 약관서비스 이용 약관서비스 이용 약관서비스 이용 약관서비스 이용 약관"
                                "서비스 이용 약관서비스 이용 약관서비스 이용 약관서비스 이용 약관서비스 이용 약관서비스 이용 약관"
                                "서비스 이용 약관서비스 이용 약관서비스 이용 약관서비스 이용 약관서비스 이용 약관"
                                "서비스 이용 약관 서비스 이용 약관서비스 이용 약관서비스 이용 약관서비스 이용 약관서비스 이용 약관"
                                "서비스 이용 약관서비스 이용 약관서비스 이용 약관서비스 이용 약관서비스 이용 약관서비스 이용 약관"
                                "서비스 이용 약관서비스 이용 약관서비스 이용 약관서비스 이용 약관서비스 이용 약관",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            )))
                  ],
                ),
              ),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Ink(
                    width: double.infinity,
                    height: 50,
                    color: Color(0xFFB0FFA3),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '확인',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF000000),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          );
        });
  }

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
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          title: Text(
            '약관 동의',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 18,
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
                        Image.network(
                          'https://picsum.photos/seed/251/600',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                          child: Text(
                            '환영합니다!',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        Text(
                          '간단한 동의후 케어엔코 서비스를 시작해보세요.',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
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
                                style: TextStyle(
                                    fontFamily: 'Poppins', color: Colors.white),
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
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.white),
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
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.white),
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
                  child:Container(
                      width: double.infinity,
                      child:Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ElevatedButton(onPressed:(checkboxValue1==true)?(){ Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ActivitySelectWidget()),
                          );}:null,
                              child: Text(
                                '시작하기',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: (checkboxValue1 == true)
                                      ? Color(0xFF000000)
                                      : Color(0xFFA4A4A4),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  minimumSize:const Size(double.infinity, 50),
                                  backgroundColor: (checkboxValue1==true)? Color(0xFFB0FFA3):Color(0xFFEBEBEB),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(10.0)) )
                          )
                        ],
                      )

                  )

                )

              ],

            ),
          ),
        ),
      ),
    );
  }
}
