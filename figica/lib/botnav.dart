import 'package:fisica/components/No_device.dart';
import 'package:fisica/components/Yes_device.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'index.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  late PersistentTabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  Future<void> show(BuildContext context) async {
    await DataController.getdevice().then((value) {
      if (value == null) {
        showAlignedDialog(
          context: context,
          isGlobal: true,
          avoidOverflow: false,
          targetAnchor: AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
          followerAnchor: AlignmentDirectional(0, 0.5).resolve(Directionality.of(context)),
          builder: (dialogContext) {
            return Material(
              color: Colors.transparent,
              child: GestureDetector(
                child: Container(
                  height: 200,
                  width: 327,
                  child: NoDivice(),
                ),
              ),
            );
          },
        );
      } else {
        showAlignedDialog(
          context: context,
          isGlobal: true,
          avoidOverflow: false,
          targetAnchor: AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
          followerAnchor: AlignmentDirectional(0, 0.5).resolve(Directionality.of(context)),
          builder: (dialogContext) {
            return Material(
              color: Colors.transparent,
              child: GestureDetector(
                child: Container(
                  height: 60,
                  width: 327,
                  child: YesDivice(),
                ),
              ),
            );
          },
        );
      }
    });
  }

  List<Widget> _buildScreens() {
    return [
      HomePageWidget(),
      GroupWidget(),
      Container(),
      planWidget(),
      MypageWidget(),
    ];
  }

  final List<Widget> _widgetOptions = <Widget>[
    HomePageWidget(),
    GroupWidget(),
    Container(),
    planWidget(),
    MypageWidget(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        activeColorPrimary: AppColors.DarkenGreen,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.group),
        activeColorPrimary: AppColors.DarkenGreen,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: _buildSvgIcon('assets/icons/scan.svg'),
        activeColorPrimary: AppColors.DarkenGreen,
        inactiveColorPrimary: Colors.grey,
        onPressed: (context) {
          // 기존 화면을 유지하면서 팝업 또는 다이얼로그 띄우기
          show(context!);
        },
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.calendar_today),
        activeColorPrimary: AppColors.DarkenGreen,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        activeColorPrimary: AppColors.DarkenGreen,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(context,
          controller: _controller,
          screens: _widgetOptions,
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: AppColors.Gray850, // Tab bar's background color
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          navBarHeight: 70,
          navBarStyle: NavBarStyle.style15, // Choose the nav bar style
          floatingActionButton: Container()),
    );
  }

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SafeArea(
  //       child: _widgetOptions.elementAt(_selectedIndex),
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       shape: CircleBorder(),
  //       onPressed: () => show(context),
  //       child: _buildSvgIcon('assets/icons/scan.svg', _selectedIndex == 2),
  //       backgroundColor: AppColors.DarkenGreen,
  //     ),
  //     floatingActionButtonLocation: CustomFabLoc(),
  //     bottomNavigationBar: Container(
  //       height: 70,
  //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
  //       child: BottomAppBar(
  //         color: AppColors.Gray850,
  //         child: Row(
  //           mainAxisSize: MainAxisSize.max,
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: <Widget>[
  //             IconButton(
  //               icon: _buildSvgIcon('assets/icons/home.svg', _selectedIndex == 0),
  //               onPressed: () => _onItemTapped(0),
  //             ),
  //             IconButton(
  //               icon: _buildSvgIcon('assets/icons/user.svg', _selectedIndex == 1),
  //               onPressed: () => _onItemTapped(1),
  //             ),
  //             SizedBox(width: 48),
  //             IconButton(
  //               icon: _buildSvgIcon('assets/icons/calendar.svg', _selectedIndex == 2),
  //               onPressed: () => _onItemTapped(2),
  //             ),
  //             IconButton(
  //               icon: _buildSvgIcon('assets/icons/my.svg', _selectedIndex == 3),
  //               onPressed: () => _onItemTapped(3),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

class CustomFabLoc extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double scaffoldWidth = scaffoldGeometry.scaffoldSize.width;
    final double scaffoldHeight = scaffoldGeometry.scaffoldSize.height;

    final double fabWidth = scaffoldGeometry.floatingActionButtonSize.width;
    final double fabHeight = scaffoldGeometry.floatingActionButtonSize.height;

    final double x = (scaffoldWidth / 2) - (fabWidth / 2);
    final double y = scaffoldHeight - fabHeight - 30;

    return Offset(x, y);
  }
}

Widget _buildSvgIcon(
  String assetName,
) {
  return SvgPicture.asset(
    assetName,
    width: 24.0, // 아이콘 크기 조정
    height: 24.0,
  );
}
