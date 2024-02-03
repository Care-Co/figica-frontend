import 'package:figica/flutter_set/nav/nav.dart';
import 'package:flutter/material.dart';

import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: '6LfvOBgpAAAAAO6Sk8m65hEr8CKAelzcdbx9MxLT',
  );
  await SetLocalizations.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale = SetLocalizations.getStoredLocale();
  ThemeMode _themeMode = ThemeMode.system;

  late Stream<BaseAuthUser> userStream;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  final authUserSub = authenticatedUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();
    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    UserController.getsavedToken().then((userData) {
      _appStateNotifier.update(userData);
    }).catchError((error) {
      print('Error fetching user data: $error');
    });

    Future.delayed(
      Duration(milliseconds: 500),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  @override
  void dispose() {
    authUserSub.cancel();
    super.dispose();
  }

  void setLocale(String language) {
    setState(() => _locale = createLocale(language));
    SetLocalizations.storeLocale(language);
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'figica',
      localizationsDelegates: [
        SetLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('ko'),
        Locale('en'),
        Locale('ja'),
      ],
      theme: ThemeData(
        fontFamily: "Pretendard",
        brightness: Brightness.light,
        scrollbarTheme: ScrollbarThemeData(),
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage, this.page}) : super(key: key);

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'homePage';
  late PersistentTabController _controller;

  List<Widget> _buildScreens() {
    return [
      HomePageWidget(),
      GroupWidget(),
      ScanpageWidget(),
      planWidget(),
      MypageWidget(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/icons/home.svg', colorFilter: ColorFilter.mode(AppColors.primaryBackground, BlendMode.srcIn)),
        activeColorPrimary: AppColors.primaryBackground,
        inactiveColorPrimary: AppColors.Gray500,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/icons/user.svg', colorFilter: ColorFilter.mode(AppColors.primaryBackground, BlendMode.srcIn)),
        activeColorPrimary: AppColors.primaryBackground,
        inactiveColorPrimary: AppColors.Gray500,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/icons/scan.svg'),
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.Gray500,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/icons/calendar.svg', colorFilter: ColorFilter.mode(AppColors.primaryBackground, BlendMode.srcIn)),
        activeColorPrimary: AppColors.primaryBackground,
        inactiveColorPrimary: AppColors.Gray500,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/icons/my.svg', colorFilter: ColorFilter.mode(AppColors.primaryBackground, BlendMode.srcIn)),
        activeColorPrimary: AppColors.primaryBackground,
        inactiveColorPrimary: AppColors.Gray500,
      ),
      // Add more nav items here
    ];
  }

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _controller = PersistentTabController();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: AppColors.Gray850,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }
}
