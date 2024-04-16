import 'dart:convert';

import 'package:fisica/components/Setting_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fisica/index.dart';

class ButtonPopup {
  String title;
  Widget page;

  ButtonPopup({required this.title, required this.page});
}

class GroupHistoryPage extends StatefulWidget {
  const GroupHistoryPage({Key? key}) : super(key: key);

  @override
  _GroupHistoryPageState createState() => _GroupHistoryPageState();
}

class _GroupHistoryPageState extends State<GroupHistoryPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<History> histories = [];
  @override
  void initState() {
    super.initState();
    initGroupData();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initGroupData() async {
    var groupData = await GroupApi.getGroup();
    print("test");
    setState(() {
      histories = History.parseHistories(groupData!);
    });
  }

  List<String> extractNamesFromHistories(List<History> histories) {
    return histories.map((history) => history.name).toList();
  }

  String timeElapsedSince(String logTimeStr) {
    DateTime logTime = DateTime.parse(logTimeStr);
    DateTime currentTime = DateTime.now();
    Duration timeDifference = currentTime.difference(logTime);
    int months = (currentTime.year - logTime.year) * 12 + currentTime.month - logTime.month;
    int days = timeDifference.inDays;
    int hours = timeDifference.inHours % 24;
    String timeDiffStr = "";
    if (months > 0) {
      timeDiffStr += "$months 개월, ";
    } else if (days > 0) {
      timeDiffStr += "$days 일, ";
    } else if (hours > 0) {
      timeDiffStr += "$hours 시간, ";
    }

    timeDiffStr = timeDiffStr.trimRight().replaceAll(RegExp(r',$'), '');

    return timeDiffStr.isEmpty ? "지금" : timeDiffStr + " 전";
  }

  List<String> buttonTexts = ["유형", "멤버", "기간", "최신순"];

  void _showModalBottomSheet(BuildContext context, int buttonIndex) {
    if (buttonIndex == 0) {
      Map<String, bool> checkboxes = {
        "그룹": false,
        "측정": false,
        "일정": false,
        "디지털 트윈": false,
      };
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return SettingType(
            name: '유형',
            checkboxes: checkboxes,
            onCompleted: (String value) {
              if (value.isEmpty) {
                setState(() {
                  buttonTexts[buttonIndex] = '유형';
                });
              } else {
                setState(() {
                  buttonTexts[buttonIndex] = value;
                });
              }
            },
          );
        },
      );
    } else if (buttonIndex == 1) {
      List<String> names = extractNamesFromHistories(histories);
      Map<String, bool> checkboxes = {
        for (var option in names) option: false,
      };

      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return SettingType(
            name: '멤버',
            checkboxes: checkboxes,
            onCompleted: (String value) {
              if (value.isEmpty) {
                setState(() {
                  buttonTexts[buttonIndex] = '멤버';
                });
              } else {
                setState(() {
                  buttonTexts[buttonIndex] = value;
                });
              }
            },
          );
        },
      );
    } else if (buttonIndex == 2) {
      Map<String, bool> checkboxes = {
        "Option 1": false,
        "Option 2": false,
      };
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return SettingType(
            name: '기간',
            checkboxes: checkboxes,
            onCompleted: (String value) {
              if (value.isEmpty) {
                setState(() {
                  buttonTexts[buttonIndex] = '기간';
                });
              } else {
                setState(() {
                  buttonTexts[buttonIndex] = value;
                });
              }
            },
          );
        },
      );
    } else if (buttonIndex == 3) {
      Map<String, bool> checkboxes = {
        "Option 1": false,
        "Option 2": false,
      };
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return SettingType(
            name: '최신순',
            checkboxes: checkboxes,
            onCompleted: (String value) {
              if (value.isEmpty) {
                setState(() {
                  buttonTexts[buttonIndex] = '최신순';
                });
              } else {
                setState(() {
                  buttonTexts[buttonIndex] = value;
                });
              }
            },
          );
        },
      );
    }
  }

  bool isselected() {
    return true;
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
      onTap: () => FocusScope.of(context).unfocus(),
      child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: AppColors.Black,
            appBar: AppBar(
              leading: AppIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 40.0,
                icon: Icon(
                  Icons.chevron_left,
                  color: AppColors.primaryBackground,
                  size: 24.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              backgroundColor: Color(0x00CCFF8B),
              automaticallyImplyLeading: false,
              title: Text(
                  SetLocalizations.of(context).getText(
                    'ngpljxdi' /* 그룹 히스토리   */,
                  ),
                  style: AppFont.s18.overrides(color: AppColors.primaryBackground)),
              centerTitle: false,
              elevation: 0.0,
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
                  child: Container(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: buttonTexts.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(8),
                          child: LodingButtonWidget(
                            options: LodingButtonOptions(
                              height: 30.0,
                              padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                              color: ["유형", "멤버", "기간", "최신순"].contains(buttonTexts[index]) ? Colors.transparent : AppColors.primary,
                              textStyle: AppFont.s18.overrides(
                                fontSize: 12,
                                color: ["유형", "멤버", "기간", "최신순"].contains(buttonTexts[index]) ? AppColors.Gray300 : AppColors.Black,
                              ),
                              elevation: 0,
                              borderSide: BorderSide(
                                color: ["유형", "멤버", "기간", "최신순"].contains(buttonTexts[index]) ? AppColors.Gray300 : AppColors.primary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            onPressed: () => _showModalBottomSheet(context, index),
                            text: buttonTexts[index],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        child: ListView.builder(
                          itemCount: histories.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.Gray850,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                width: 232,
                                height: 76,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 48,
                                            height: 48,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.network(
                                              'https://picsum.photos/seed/279/600',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 13),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  histories[index].name,
                                                  style: AppFont.s18.overrides(fontSize: 16, color: AppColors.primaryBackground),
                                                ),
                                                Text(GroupApi.historytext(histories[index].shortDescription),
                                                    style: AppFont.r16.overrides(fontSize: 12, color: AppColors.primaryBackground)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            timeElapsedSince(histories[index].date),
                                            //timeElapsedSince('2024-01-27 21:21:51'),

                                            style: AppFont.r16.overrides(fontSize: 10, color: AppColors.Gray200),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
