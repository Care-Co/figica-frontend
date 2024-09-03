import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'index.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

var logger = Logger();

var loggerNoStack = Logger(
  printer: PrettyPrinter(
      methodCount: 0, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      colors: true, // Colorful log messages
      printEmojis: false, // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
      ),
);
void main() async {
  var logger = Logger();

  logger.d("Logger is working!");
  WidgetsFlutterBinding.ensureInitialized();

  usePathUrlStrategy();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAppCheck.instance.activate(
      //androidProvider: AndroidProvider.playIntegrity,
      appleProvider: AppleProvider.deviceCheck,
      androidProvider: AndroidProvider.playIntegrity,
    );
    print('Firebase 초기화 성공');
  } catch (e) {
    print('Firebase 초기화 실패: $e');
  }

  await SetLocalizations.initialize();

  runApp(
    ChangeNotifierProvider<AppStateNotifier>(
      create: (context) {
        AppStateNotifier appStateNotifier = AppStateNotifier.instance;
        return appStateNotifier;
      },
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale = SetLocalizations.getStoredLocale();
  ThemeMode _themeMode = ThemeMode.system;
  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
  late StreamSubscription<BluetoothAdapterState> _adapterStateSubscription;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));
    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);

    _appStateNotifier.loadSaveUserData().then((isSuccess) async {
      if (isSuccess) {
        _appStateNotifier.apicall();
      } else {
        print('Omit data call');
      }
    });

    _adapterStateSubscription = FlutterBluePlus.adapterState.listen((state) {
      setState(() => _adapterState = state);
      if (_adapterState != BluetoothAdapterState.on) {
        FlutterBluePlus.turnOn();
      }
    });
    Future.delayed(Duration(milliseconds: 500), () {
      _appStateNotifier.stopShowingSplashImage();
    });
  }

  @override
  void dispose() {
    _adapterStateSubscription.cancel();
    super.dispose();
  }

  void setLocale(String language) {
    setState(() {
      _locale = createLocale(language);
    });
    SetLocalizations.storeLocale(language);
  }

  void setThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fisica',
      localizationsDelegates: [
        SetLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [Locale('ko'), Locale('en'), Locale('ja')],
      theme: ThemeData(
        fontFamily: "Pretendard",
        brightness: Brightness.light,
        scrollbarTheme: ScrollbarThemeData(),
      ),
      themeMode: _themeMode,
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}
