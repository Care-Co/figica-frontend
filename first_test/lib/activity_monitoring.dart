
import 'package:flutter/material.dart';

class ActivityMonitoringWidget extends StatefulWidget {
  const ActivityMonitoringWidget({Key? key}) : super(key: key);

  @override
  _ActivityMonitoringWidgetState createState() =>
      _ActivityMonitoringWidgetState();
}

class _ActivityMonitoringWidgetState extends State<ActivityMonitoringWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _buttonState = "OFF";
  String valueText = "";
  final myController = TextEditingController();

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }
  void onClick() {
    print('onClick()');
    setState(() {
      if (_buttonState == 'OFF') {
        _buttonState = 'ON';
      }
      else {
        _buttonState = 'OFF';
      }
    });
  }
  void atDialog() {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.pop(context);
          });
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            backgroundColor: Color(0xffffffff),
            //Dialog Main Title
            title: Column(
              children: <Widget>[
                new Text("AT+START을 보냈습니다."),
              ],
            ),
            //
          );
        });
  }

  void emailDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('login form'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: myController,
              decoration: InputDecoration(hintText: "이메일을 입력해주세요"),
            ),
            actions: <Widget>[

              TextButton(
                child: Text('전송'),
                onPressed: () {
                  setState(() {
                    //codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
              ),

            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
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
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                    child: Text(
                      '신체 밸런스 측정하기',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 100,
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 10),
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Color(0xFF27FF42),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 10, 10),
                                child: Text(
                                  'Scale 1',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                                ),
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
                  height: MediaQuery.of(context).size.height * 0.37,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(30, 30, 30, 30),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 1,
                            decoration: BoxDecoration(
                              color: Color(0xFFCCCCCC),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.12,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(30, 10, 30, 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 1,
                            decoration: BoxDecoration(
                              color: Color(0xFFCCCCCC),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: ElevatedButton(
                            child: Text("측정하기"),
                            onPressed: () => atDialog(),
                            style: ElevatedButton.styleFrom(
                                minimumSize:const Size(150, 40),
                                backgroundColor: Color(0xFFCCCCCC),
                                shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(10.0)) )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: ElevatedButton(
                            child: Text(
                              '나에게 보내기',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFFCCCCCC),
                              ),
                            ),
                            onPressed: () => emailDialog(),
                            style: ElevatedButton.styleFrom(
                                minimumSize:const Size(150, 40),
                                backgroundColor: Color(0xFFffffff),
                                shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(10.0)) )
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.10,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          child: Text("처음으로"),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize:const Size(130, 30),
                              backgroundColor: Color(0xFFcccccc),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0)) )
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
