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
      }
      else {
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
                          onTap:(){ Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ActivityTosWidget()),
                          );},
                          child: Text(
                            '체험 모드',
                            style:
                            TextStyle(
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
                  height: MediaQuery.of(context).size.height * 0.5,

                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.2,

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
                  height: MediaQuery.of(context).size.height * 0.20,

                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children:[
                      ElevatedButton(
                          child: Text("시작하기"),
                          onPressed:(){ Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ActivityMonitoringWidget()),
                          );},
                          style: ElevatedButton.styleFrom(
                              minimumSize:const Size(280, 50),
                              backgroundColor: Color(0xFFcccccc),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0)) )
                      ),
                      Container(
                        width: double.infinity,
                        height: 100,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                          child: Text(
                            '디바이스에 올라선 후 시작하기를 눌러주세요\n시각화된 데이터를 통해 신체밸런스 상태를 확인해보세요.',
                            textAlign: TextAlign.center,
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
