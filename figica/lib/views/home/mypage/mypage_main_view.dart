import 'package:fisica/models/UserData.dart';
import 'package:fisica/models/WeightData.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fisica/index.dart';
import 'package:provider/provider.dart';

class MypageWidget extends StatefulWidget {
  const MypageWidget({Key? key}) : super(key: key);

  @override
  _MypageWidgetState createState() => _MypageWidgetState();
}

class _MypageWidgetState extends State<MypageWidget> {
  late AppStateNotifier _appStateNotifier;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  UserData? data;
  var weightData;
  var footData;
  List<dynamic> historyData = [];
  Future? _loadDataFuture;

  late int agedata = 0;

  DateTime currentDate = DateTime.now(); // 현재 날짜 및 시간

  int calculateAge(dynamic birthDateString) {
    if (birthDateString == null) {
      return 0;
    } else {
      DateTime birthDate = DateTime.parse(birthDateString);
      DateTime currentDate = DateTime.now();
      int age = currentDate.year - birthDate.year;
      if (currentDate.month < birthDate.month || (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
        age--;
      }
      return age;
    }
  }

  Future<void> getData() async {
    data = _appStateNotifier.userdata;

    try {
      footData = _appStateNotifier.footdata!;
      weightData = _appStateNotifier.weightData!;
      historyData = [...weightData, ...footData];
      agedata = calculateAge(data?.birthday);
    } catch (e) {
      print(e);
    }
  }

  String timeElapsedSince(DateTime logTime) {
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

  @override
  void initState() {
    super.initState();
    _appStateNotifier = AppStateNotifier.instance;
    _loadDataFuture = getData();
  }

  @override
  void dispose() {
    super.dispose();
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
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.Gray850,
        appBar: AppBar(
          backgroundColor: Color(0x00CCFF8B),
          automaticallyImplyLeading: false,
          title: Text(
            SetLocalizations.of(context).getText(
              'qqpwooly' /* Page Title */,
            ),
            style: AppFont.s18.overrides(color: AppColors.primaryBackground),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: Icon(
                  Icons.settings,
                  color: AppColors.primaryBackground,
                ),
                onPressed: () {
                  context.pushNamed(
                    'MySetting',
                  );
                },
              ),
            )
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: FutureBuilder(
              future: _loadDataFuture,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Consumer<AppStateNotifier>(builder: (context, appStateNotifier, child) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildUserInfo(context),
                                    _buildButtons(context),
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                _buildBodyData(context)
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.Black,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                                child: Column(
                                  children: [
                                    _buildHistroytitle(context),
                                    _buildHistroy(context),
                                    _buildPlantitle(context),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  });
                }
              }),
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: ClipOval(
            child: data?.photoUrl != null
                ? Image.network(
                    data?.photoUrl ?? '',
                    width: 60.0,
                    height: 60.0,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 60.0,
                    height: 60.0,
                    color: Colors.black,
                  ),
          ),
        ),
        Column(
          children: [
            Text(
              '${data?.firstName}  ${data?.lastName}',
              style: AppFont.b24.overrides(color: AppColors.primaryBackground),
            ),
            Row(
              children: [
                Text(
                  agedata.toString() + '세 | ',
                  style: AppFont.s12.overrides(color: AppColors.Gray300),
                ),
                Text(
                  data?.gender ?? '',
                  style: AppFont.s12.overrides(color: AppColors.Gray300),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Container(
            width: 90,
            height: 26.0,
            child: LodingButtonWidget(
              onPressed: () async {
                context.pushNamed('Modiinfo');
              },
              text: SetLocalizations.of(context).getText(
                'vmfhvlfv' /* 프로필 편집 */,
              ),
              options: LodingButtonOptions(
                height: 40.0,
                padding: EdgeInsetsDirectional.fromSTEB(17.0, 0.0, 17.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: Colors.transparent,
                textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.Gray300),
                elevation: 0,
                borderSide: BorderSide(
                  color: AppColors.Gray300,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
          child: Container(
            width: 90,
            height: 26.0,
            child: LodingButtonWidget(
              onPressed: () async {
                context.pushNamed('Myavata');
              },
              text: SetLocalizations.of(context).getText(
                'dkqkxk' /* 아바타 보기 */,
              ),
              options: LodingButtonOptions(
                height: 40.0,
                padding: EdgeInsetsDirectional.fromSTEB(17.0, 0.0, 17.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: AppColors.primary,
                textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.Black),
                elevation: 0,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBodyData(BuildContext context) {
    return Container(
      height: 76,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.Black,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                SetLocalizations.of(context).getText(
                  'goa2jpgy',
                ),
                style: AppFont.s12.overrides(fontSize: 10, color: AppColors.Gray500),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                '${data?.height.toString()}cm',
                style: AppFont.s12.overrides(fontSize: 16, color: AppColors.primaryBackground),
              )
            ],
          ),
        ),
        Container(
          height: 44, // 높이 설정
          child: VerticalDivider(
            color: AppColors.Gray700, // 선의 색상을 설정합니다.
            thickness: 1, // 실제 선의 두께를 설정합니다.
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                SetLocalizations.of(context).getText(
                  '5gfls12l',
                ),
                style: AppFont.s12.overrides(fontSize: 10, color: AppColors.Gray500),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                '${data?.weight.toString()}kg',
                style: AppFont.s12.overrides(fontSize: 16, color: AppColors.primaryBackground),
              )
            ],
          ),
        )
      ]),
    );
  }

  Widget _buildHistroytitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          SetLocalizations.of(context).getText('gmrwjdg'),
          style: AppFont.b24.overrides(fontSize: 20, color: AppColors.primaryBackground),
        ),
        AppIconButton(
          borderColor: Colors.transparent,
          borderRadius: 20.0,
          borderWidth: 1.0,
          buttonSize: 40.0,
          icon: Icon(
            Icons.chevron_right_rounded,
            color: AppColors.primaryBackground,
            size: 20.0,
          ),
          onPressed: () async {
            context.pushNamed('history');
          },
        ),
      ],
    );
  }

  Widget _buildHistroy(BuildContext context) {
    return Container(
        height: 144,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: historyData.length,
          itemBuilder: (context, index) {
            final item = historyData[index];
            return Row(
              children: [
                Container(
                  decoration: BoxDecoration(color: AppColors.Gray850, borderRadius: BorderRadius.all(Radius.circular(16))),
                  width: 144,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: item is WeightData
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '체중 측정',
                                    style: AppFont.s12.overrides(color: AppColors.primary),
                                  ),
                                  Text(
                                    '${item.weight} kg',
                                    style: AppFont.s18.overrides(color: AppColors.Gray100),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    timeElapsedSince(item.measuredTime),
                                    style: AppFont.r16.overrides(color: AppColors.Gray200, fontSize: 10),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Footprint',
                                    style: AppFont.s12.overrides(color: AppColors.primary),
                                  ),
                                  // Text(
                                  //   footDataClass.settype(item.classType),
                                  //   style: AppFont.s18.overrides(color: AppColors.Gray100),
                                  // ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    timeElapsedSince(item.measuredTime),
                                    style: AppFont.r16.overrides(color: AppColors.Gray200, fontSize: 10),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ),
                ),
                SizedBox(
                  width: 16,
                )
              ],
            );
          },
        ));
  }

  Widget _buildPlantitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          SetLocalizations.of(context).getText('dmmldlfwjd'),
          style: AppFont.b24.overrides(fontSize: 20, color: AppColors.primaryBackground),
        ),
        AppIconButton(
          borderColor: Colors.transparent,
          borderRadius: 20.0,
          borderWidth: 1.0,
          buttonSize: 40.0,
          icon: Icon(
            Icons.chevron_right_rounded,
            color: AppColors.primaryBackground,
            size: 20.0,
          ),
          onPressed: () async {},
        ),
      ],
    );
  }
}
