import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'auth/firebase_auth/auth_util.dart';

import 'backend/firebase/firebase_config.dart';
import 'flutter_set/flutter_flow_theme.dart';
import 'flutter_set/flutter_flow_util.dart';
import 'flutter_set/internationalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'flutter_set/nav/nav.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await initFirebase();

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
    userStream = figicaFirebaseUserStream()..listen((user) => _appStateNotifier.update(user));
    jwtTokenStream.listen((_) {});
    Future.delayed(
      Duration(milliseconds: 1000),
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
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'homePage': HomePageWidget(),
      'scanpage': ScanpageWidget(),
      'mypage': MypageWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);

    final MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
      body: MediaQuery(
          data: queryData.removeViewInsets(removeBottom: true).removeViewPadding(removeBottom: true), child: _currentPage ?? tabs[_currentPageName]!),
      extendBody: true,
      bottomNavigationBar: FloatingNavbar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: Color(0xFF2F3135),
        selectedItemColor: FlutterFlowTheme.of(context).secondaryBackground,
        unselectedItemColor: Color(0xFF7C7F84),
        selectedBackgroundColor: Color(0x00000000),
        borderRadius: 8.0,
        itemBorderRadius: 8.0,
        margin: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        width: double.infinity,
        elevation: 0.0,
        items: [
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.home_filled,
                  color: currentIndex == 0 ? FlutterFlowTheme.of(context).secondaryBackground : Color(0xFF7C7F84),
                  size: 24.0,
                ),
                Text(
                  SetLocalizations.of(context).getText(
                    's0rjpssz' /* Home */,
                  ),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: currentIndex == 0 ? FlutterFlowTheme.of(context).secondaryBackground : Color(0xFF7C7F84),
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.document_scanner_sharp,
                  color: currentIndex == 1 ? FlutterFlowTheme.of(context).secondaryBackground : Color(0xFF7C7F84),
                  size: 24.0,
                ),
                Text(
                  SetLocalizations.of(context).getText(
                    '3x7ltwpw' /* scan */,
                  ),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: currentIndex == 1 ? FlutterFlowTheme.of(context).secondaryBackground : Color(0xFF7C7F84),
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  color: currentIndex == 2 ? FlutterFlowTheme.of(context).secondaryBackground : Color(0xFF7C7F84),
                  size: 24.0,
                ),
                Text(
                  SetLocalizations.of(context).getText(
                    '0v83hnie' /* MY */,
                  ),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: currentIndex == 2 ? FlutterFlowTheme.of(context).secondaryBackground : Color(0xFF7C7F84),
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
