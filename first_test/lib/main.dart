import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'activity_login.dart';
import 'activity_main.dart';
import 'package:provider/provider.dart';
import 'activity_MyPage.dart';
import 'provider/myProvider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor:
          SystemUiOverlayStyle.dark.systemNavigationBarColor,
    ),
  );

  Future<ConnectivityResult> checkConnectionStatus() async {
    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.none) {
      throw new SocketException("인터넷 연결 상태를 확인해 주세요.");
    }
    return result; // wifi, mobile
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<BlueState>(create: (_) => BlueState())
  ], child: const MyApp()));
}




class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        fontFamily: 'Pretendard',
        brightness: Brightness.light,
        primaryColor: Colors.black,
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500 ,color: Color(0xff141514)),
            headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500 ,color: Color(0xffffffff)),
            headline3: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700 ,color: Color(0xff1A1A1A)),
            bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400 ,color: Color(0xff141514)),
            bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400 ,color: Color(0xffffffff)),
            subtitle1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400 ,color: Color(0xff141514)),
            subtitle2: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400 ,color: Color(0xffffffff)),
          )

      ),


      home: const ActivityMainWidget(),
      //home: const ActivitMyPageWidget(),
      //home: const LoginScreen(),
      // routes: {
      //   LoginScreen.routeName: (context) => const LoginScreen(),
      // },
    );
  }
}
