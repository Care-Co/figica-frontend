import 'package:flutter/material.dart';
import 'activity_monitoring.dart';
import 'activity_tos.dart';

class ActivityMainWidget extends StatefulWidget {
  const ActivityMainWidget({Key? key}) : super(key: key);

  @override
  _ActivityMainWidgetState createState() => _ActivityMainWidgetState();
}

class _ActivityMainWidgetState extends State<ActivityMainWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _buttonState = "OFF";

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
      } else {
        _buttonState = 'OFF';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  height: MediaQuery.of(context).size.height * 0.10,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ActivityTosWidget()),
                            );
                          },
                          child: Text(
                            '체험 모드',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Image.network(
                        'https://picsum.photos/seed/858/600',
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 10),
                        child: ElevatedButton(
                            child: Text(
                              "이메일로 가입",
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ActivityMonitoringWidget()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(400, 50),
                                backgroundColor: Color(0xFF000000),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)))),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 20),
                        child: ElevatedButton(
                            child: Text(
                              "이메일로 로그인",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ActivityMonitoringWidget()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(400, 50),
                                backgroundColor: Color(0xFfffffff),
                                side: const BorderSide(
                                  color: Colors.black,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)))),
                      ),
                      Container(
                        width: double.infinity,
                        height: 100,
                        child: Row(children: <Widget>[
                          Expanded(
                              child: Divider(
                            thickness: 1,
                            color: Color(0xFFADADAD),
                            indent: 20,
                            endIndent: 20,
                          )),
                          Text(
                            "SNS 회원가입/로그인",
                            style: TextStyle(
                              color: Color(0xFFADADAD),
                            ),
                          ),
                          Expanded(
                              child: Divider(
                            thickness: 1,
                            color: Color(0xFFADADAD),
                            indent: 20,
                            endIndent: 20,
                          )),
                        ]),
                      ),
                      Container(
                          width: double.infinity,
                          height: 100,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 10, 10),
                                child: ElevatedButton(
                                    onPressed: () {
                                      print('IconButton pressed ...');
                                    },
                                    child: Image.network(
                                      'https://picsum.photos/seed/858/600',
                                      height: 30,
                                      width: 30,
                                      fit: BoxFit.cover,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(0),
                                        minimumSize: const Size(40, 40),
                                        backgroundColor: Color(0xFfffffff),
                                        side: const BorderSide(
                                          color: Colors.black,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    30.0)))),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 10, 10),
                                child: IconButton(
                                  icon: Image.network(
                                    'https://picsum.photos/seed/858/600',
                                  ),
                                  onPressed: () {
                                    print('IconButton pressed ...');
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 10, 10),
                                child: IconButton(
                                  icon: Image.network(
                                    'https://picsum.photos/seed/858/600',
                                  ),
                                  onPressed: () {
                                    print('IconButton pressed ...');
                                  },
                                ),
                              ),
                            ],
                          ))
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
