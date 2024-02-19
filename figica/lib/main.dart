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
  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;

  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

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

    //blue
    _adapterStateStateSubscription = FlutterBluePlus.adapterState.listen((state) {
      _adapterState = state;
      if (mounted) {
        setState(() {});
      }
    });
    if (_adapterState != BluetoothAdapterState.on) {
      FlutterBluePlus.turnOn();
    }

    Future.delayed(
      Duration(milliseconds: 500),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  @override
  void dispose() {
    _adapterStateStateSubscription.cancel();

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

// listen for disconnection

