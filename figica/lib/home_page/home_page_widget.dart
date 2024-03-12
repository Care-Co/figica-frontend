import 'package:figica/home_page/home_info.dart';
import 'package:figica/home_page/avata_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:figica/index.dart';

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
  var data;

  Future<void> getData() async {
    print('homepage ---- getData');
    data = await UserController.getuserinfo();
    print(data);
  }

  void togglePositionAndControls() {
    print('togglePositionAndControls');
    setState(() {
      rightPosition = rightPosition == 0 ? -150 : 0;
      detailstate = !detailstate;
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

    WidgetsBinding.instance.addPostFrameCallback((_) {});
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
            flexibleSpace: FutureBuilder(
                future: getData(), // 비동기 함수를 FutureBuilder의 future로 지정합니다.
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("데이터 로딩 중 에러 발생"));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              SetLocalizations.of(context).getText('o84ubxz5'),
                              style: AppFont.r16.overrides(color: AppColors.Gray200),
                            ),
                            Text(
                              data['firstName'] + data['lastName'] + ' 회원님',
                              style: AppFont.b24.overrides(color: AppColors.primaryBackground),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                }),
          ),
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 0, 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 1200,
                  height: 460,
                  child: Stack(
                    children: [
                      Positioned(
                        right: rightPosition,
                        child: Avata(),
                      ),
                      if (!detailstate)
                        Positioned(
                          right: rightPosition,
                          child: InkWell(
                            onTap: togglePositionAndControls,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 480,
                            ),
                          ),
                        ),
                      if (!detailstate) Homeinfo(),
                      if (detailstate)
                        Positioned(
                          right: 24,
                          bottom: 90,
                          child: InkWell(
                            onTap: togglePositionAndControls,
                            child: Container(
                              height: 54,
                              width: 54,
                              child: Icon(
                                Icons.arrow_back_ios_new,
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
                          ),
                        ),
                      if (detailstate)
                        Positioned(
                          top: 20,
                          child: InkWell(
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
                          ),
                        ),
                      if (detailinfo)
                        Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Homeinfo(),
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
