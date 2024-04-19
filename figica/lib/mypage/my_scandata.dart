import 'package:fisica/scan/Foot_Controller.dart';
import 'package:fisica/scan/switch.dart';
import 'package:flutter/material.dart';
import 'package:fisica/index.dart';

class MyScanData extends StatefulWidget {
  @override
  _MyScanDataState createState() => _MyScanDataState();
}

// StatefulWidget의 상태를 관리하는 클래스
class _MyScanDataState extends State<MyScanData> {
  var mydata;
  var data;
  String type = '';
  int accuracy = 0;
  double height = 100; // 초기 높이
  IconData buttonIcon = Icons.keyboard_arrow_up; // 초기 아이콘
  bool togle = true;

  @override
  void initState() {
    super.initState();
    getData();
    //WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  void _toggleHeight() {
    setState(() {
      // 높이와 아이콘 상태 토글
      if (togle) {
        togle = false;
        height = 50;
        buttonIcon = Icons.keyboard_arrow_up; // 위 화살표로 변경
      } else {
        togle = true;
        height = 100;
        buttonIcon = Icons.keyboard_arrow_down; // 아래 화살표로 변경
      }
    });
  }

  Future<void> getData() async {
    // 비동기 작업의 결과를 상태 변수에 저장합니다.
    var tempData = await DataController.getuserinfo();
    var sharedPrefsData = await DataController.get_apiData();
    data = sharedPrefsData;
    mydata = tempData;
    print(data);
    print(mydata);
    settype(sharedPrefsData['classType']); // SharedPreferences에서 불러온 데이터
    accuracy = sharedPrefsData['accuracy'];
  }

  void settype(int typeint) {
    switch (typeint) {
      case 0:
        type = '정상발';

        break;
      case 1:
        type = '요족';

        break;
      case 2:
        type = '평발';

        break;
      case 3:
        type = '척추 전만증';

        break;
      case 4:
        type = '척추 후만증';

        break;
      case 5:
        type = '척추 좌 측만증';

        break;
      case 6:
        type = '척추 우 측만증';

        break;
      case 7:
        type = '골반 비틀림';

        break;
      default:
        type = '알 수 없는 상태';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(), // 비동기 데이터 로딩
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("데이터 로딩 중 에러 발생"));
          }
          return Column(
            children: [
              IconButton(
                onPressed: _toggleHeight, // 토글 함수 연결
                icon: Icon(
                  buttonIcon,
                  color: AppColors.Gray500,
                ), // 상태에 따라 달라지는 아이콘
              ),
              Container(
                height: height,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.Gray850,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0),
                  ),
                ),
                child: togle
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                        child: Container(
                          child: Row(children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  SetLocalizations.of(context).getText('goa2jpgy'),
                                  style: AppFont.s12.overrides(color: AppColors.Gray500),
                                ),
                                Text(
                                  mydata['height'].toString() + 'cm',
                                  style: AppFont.s18.overrides(color: AppColors.primaryBackground),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 32,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  SetLocalizations.of(context).getText('5gfls12l'),
                                  style: AppFont.s12.overrides(color: AppColors.Gray500),
                                ),
                                Text(
                                  mydata['weight'].toString() + 'kg',
                                  style: AppFont.s18.overrides(color: AppColors.primaryBackground),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 32,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Footprint',
                                  style: AppFont.s12.overrides(color: AppColors.Gray500),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      type,
                                      style: AppFont.b24.overrides(fontSize: 20, color: AppColors.primaryBackground),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      accuracy.toString() + '%',
                                      style: AppFont.b24.overrides(fontSize: 20, color: AppColors.Gray300),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ]),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                        child: Text(
                          SetLocalizations.of(context).getText('rjsrkdwjdqh'),
                          style: AppFont.s12.overrides(fontSize: 16, color: AppColors.Gray500),
                        ),
                      ),
              ),
            ],
          );
        });
  }
}
