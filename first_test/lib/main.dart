import 'package:flutter/material.dart';
import 'activity_main.dart';
import 'package:provider/provider.dart';
import 'activite_state.dart';
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
      home: const ActivityMainWidget(),

    );
  }
}





