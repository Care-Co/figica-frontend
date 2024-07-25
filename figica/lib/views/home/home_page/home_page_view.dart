import 'package:fisica/utils/TypeManager.dart';
import 'package:fisica/views/home/home_page/avata_widget.dart';
import 'package:fisica/models/FootData.dart';
import 'package:fisica/models/UserData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fisica/index.dart';
import 'package:provider/provider.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  double rightPosition = -150;
  bool detailstate = false;
  bool detailinfo = false;
  UserData? data;
  List<FootData>? foot;

  void togglePositionAndControls() {
    print('togglePositionAndControls');
    setState(() {
      rightPosition = rightPosition == 0 ? -150 : 0;
      detailstate = !detailstate;
      detailinfo = false;
    });
  }

  void toggleddata() {
    print('toggleddata');
    setState(() {
      detailinfo = !detailinfo;
    });
  }

  @override
  void initState() {
    super.initState();
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

    return Consumer<AppStateNotifier>(builder: (context, AppStateNotifier, child) {
      double screenHeight = MediaQuery.of(context).size.height;
      double screenWidth = MediaQuery.of(context).size.width;
      double containerHeight = screenHeight * 0.65;

      data = AppStateNotifier.userdata;
      foot = AppStateNotifier.footdata ?? null;

      return GestureDetector(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: AppColors.Black,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(98.0),
            child: AppBar(
              elevation: 0,
              titleSpacing: 10,
              backgroundColor: AppColors.Black,
              automaticallyImplyLeading: false,
              flexibleSpace: Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                child: _buildappheader(context),
              ),
            ),
          ),
          body: SafeArea(
            top: true,
            child: Center(
              child: SizedBox(
                width: screenWidth,
                height: containerHeight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                  child: Stack(
                    children: [
                      Positioned(
                        right: rightPosition,
                        child: Avata(
                          height: containerHeight,
                        ),
                      ),
                      if (!detailstate) ...[
                        Positioned(
                          right: rightPosition,
                          child: InkWell(
                            splashColor: Colors.transparent, // 물결 효과 없애기
                            highlightColor: Colors.transparent, // 하이라이트 효과 없애기
                            hoverColor: Colors.transparent, // 호버 색상 없애기
                            onTap: togglePositionAndControls,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: containerHeight,
                            ),
                          ),
                        ),
                        _buildUserinfo(context, AppStateNotifier),
                        if (foot != null) Positioned(top: 100, child: _buildScaninfo(context, AppStateNotifier)),
                      ] else ...[
                        Positioned(right: 24, bottom: 90, child: _buildcontroller(context, AppStateNotifier)),
                        Positioned(top: 20, child: _buildtogle(context))
                      ],
                      if (detailinfo && detailstate)
                        Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: _buildUserinfo(context, AppStateNotifier),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildappheader(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            SetLocalizations.of(context).getText('homeGreetingLabel'),
            style: AppFont.r16.overrides(color: AppColors.Gray200),
          ),
          Text(
            SetLocalizations.of(context).getText('homeGreetingUserLabel', values: {'name': '${data?.firstName}${data?.lastName}'}),
            style: AppFont.b24.overrides(color: AppColors.primaryBackground),
          )
        ],
      ),
    );
  }

  Widget _buildUserinfo(BuildContext context, AppStateNotifier AppStateNotifier) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              width: 232,
              height: 88,
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFCFDFF).withOpacity(0.20),
                    Color(0xFFFCFDFF).withOpacity(0.04),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.50, color: Color(0x33FBFCFF)),
                  borderRadius: BorderRadius.circular(16),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0xB2121212),
                    blurRadius: 8,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                SetLocalizations.of(context).getText('homeUserHeightLabel'),
                                style: AppFont.s12.overrides(color: AppColors.Gray300),
                              ),
                              Text(
                                AppStateNotifier.userdata?.height.toString() ?? 'N/A' + 'cm',
                                style: AppFont.s18.overrides(color: AppColors.primaryBackground),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                SetLocalizations.of(context).getText('homeUserWeightLabel'),
                                style: AppFont.s12.overrides(color: AppColors.Gray300),
                              ),
                              Text(
                                AppStateNotifier.userdata?.weight.toString() ?? 'N/A' + 'kg',
                                style: AppFont.s18.overrides(color: AppColors.primaryBackground),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  Widget _buildScaninfo(BuildContext context, AppStateNotifier AppStateNotifier) {
    final TypeManager typeManager = TypeManager();
    typeManager.setType(context, AppStateNotifier.footdata?.first.classType);
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              width: 232,
              height: 152,
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFCFDFF).withOpacity(0.20),
                    Color(0xFFFCFDFF).withOpacity(0.04),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.50, color: Color(0x33FBFCFF)),
                  borderRadius: BorderRadius.circular(16),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0xB2121212),
                    blurRadius: 8,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Footprint',
                        style: AppFont.s12.overrides(color: AppColors.Gray300),
                      ),
                      Text(
                        typeManager.type,
                        style: AppFont.s18.overrides(color: AppColors.primaryBackground),
                      ),
                      Text(
                        (AppStateNotifier.footdata?.first.accuracy?.toString() ?? 'na') + '%',
                        style: AppFont.s12.overrides(color: AppColors.Gray300),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        typeManager.typeTitle,
                        style: AppFont.s12.overrides(color: AppColors.Gray300),
                      ),
                    ],
                  ),
                ),
              )),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  Widget _buildcontroller(BuildContext context, AppStateNotifier AppStateNotifier) {
    return InkWell(
      splashColor: Colors.transparent, // 물결 효과 없애기
      highlightColor: Colors.transparent, // 하이라이트 효과 없애기
      hoverColor: Colors.transparent, // 호버 색상 없애기
      onTap: togglePositionAndControls,
      child: Container(
        height: 54,
        width: 54,
        child: Icon(
          Icons.chevron_left,
          color: AppColors.primaryBackground,
        ),
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFCFDFF).withOpacity(0.20),
              Color(0xFFFCFDFF).withOpacity(0.04),
            ],
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.50, color: Color(0x33FBFCFF)),
            borderRadius: BorderRadius.circular(54),
          ),
          shadows: [
            BoxShadow(
              color: Color(0xB2121212),
              blurRadius: 8,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildtogle(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent, // 물결 효과 없애기
      highlightColor: Colors.transparent, // 하이라이트 효과 없애기
      hoverColor: Colors.transparent, // 호버 색상 없애기
      onTap: toggleddata,
      child: Container(
        height: 54,
        width: 54,
        child: Icon(
          Icons.more_vert,
          color: AppColors.primaryBackground,
        ),
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFCFDFF).withOpacity(0.20),
              Color(0xFFFCFDFF).withOpacity(0.04),
            ],
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.50, color: Color(0x33FBFCFF)),
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: [
            BoxShadow(
              color: Color(0xB2121212),
              blurRadius: 8,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
      ),
    );
  }
}
