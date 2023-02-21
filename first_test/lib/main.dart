import 'package:flutter/material.dart';
import 'activity_main.dart';
import 'package:provider/provider.dart';
import 'activite_state.dart';
import 'activity_MyPage.dart';

void main() {
  runApp(
    MultiProvider(providers: [ChangeNotifierProvider
    <isconnectstate>
    (create: (_)=> isconnectstate())]
    ,child: const MyApp())
  );

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

    );
  }
}





