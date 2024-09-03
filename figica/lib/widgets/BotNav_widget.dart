import 'package:fisica/components/No_device.dart';
import 'package:fisica/components/Yes_device.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../index.dart';

class BotNav extends StatefulWidget {
  const BotNav({Key? key}) : super(key: key);

  @override
  State<BotNav> createState() => _BotNavState();
}

class _BotNavState extends State<BotNav> {
  late PersistentTabController _controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  Future<void> noshow(BuildContext context) async {
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
  }

  Future<void> yesshow(BuildContext context) async {
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

  final List<Widget> _widgetOptions = <Widget>[
    HomePageWidget(),
    //GroupWidget(),
    Container(),
    //planWidget(),
    MyPageLanding(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        activeColorPrimary: AppColors.DarkenGreen,
        inactiveColorPrimary: Colors.grey,
      ),
      // PersistentBottomNavBarItem(
      //   icon: Icon(Icons.group),
      //   activeColorPrimary: AppColors.DarkenGreen,
      //   inactiveColorPrimary: Colors.grey,
      // ),
      PersistentBottomNavBarItem(
        icon: _buildSvgIcon('assets/icons/scan.svg'),
        activeColorPrimary: AppColors.DarkenGreen,
        inactiveColorPrimary: Colors.grey,
        onPressed: (context) async {
          // Here context is not used directly
          if (_scaffoldKey.currentContext == null) {
            print('Error: scaffoldKey.currentContext is null');
            return;
          }

          if (!AppStateNotifier.instance.isdevice) {
            noshow(_scaffoldKey.currentContext!); // Use scaffoldKey.currentContext
          } else {
            yesshow(_scaffoldKey.currentContext!); // Use scaffoldKey.currentContext
          }
        },
      ),
      // PersistentBottomNavBarItem(
      //   icon: Icon(Icons.calendar_today),
      //   activeColorPrimary: AppColors.DarkenGreen,
      //   inactiveColorPrimary: Colors.grey,
      // ),
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
      key: _scaffoldKey,
      body: PersistentTabView(_scaffoldKey.currentContext ?? context, // Use GlobalKey if available
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
