//
//
// import 'package:flutter/material.dart';
//
// class NotesThemeData {
//   static ThemeData lightThemeData = themeData();  // 실제 쓸 때는 요걸로 쓸 거임
//
//   static ThemeData themeData() {  // 실제 ThemeData 만듬
//    final base = ThemeData(
//      fontFamily: 'Pretendard',
//      brightness: Brightness.light,
//      primaryColor: Colors.black,
//    );
//    return base.copyWith(
//
//        textTheme: _buildNotesTextTheme(base.textTheme),
//    );
//
//   }
//   static TextTheme _buildNotesTextTheme(TextTheme base) {  // TextTheme 생성
//     return base.copyWith(
//       headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700,color:Colors.),
//
//     );
//   }
// }
//
//
// class CustomTextStyle {
//   static TextStyle H1(BuildContext context){
//     return Theme.of(context).textTheme.headline1!.copyWith(fontSize: 192.0);
//   }
//   static TextStyle H2(BuildContext context){
//     return Theme.of(context).textTheme.display4.copyWith(fontSize: 192.0);
//   }
//   static TextStyle H3(BuildContext context){
//     return Theme.of(context).textTheme.display4.copyWith(fontSize: 192.0);
//   }
//   static TextStyle Body1(BuildContext context){
//     return Theme.of(context).textTheme.display4.copyWith(fontSize: 192.0);
//   }
//   static TextStyle Body2(BuildContext context){
//     return Theme.of(context).textTheme.display4.copyWith(fontSize: 192.0);
//   }
//   static TextStyle caption1(BuildContext context){
//     return Theme.of(context).textTheme.display4.copyWith(fontSize: 192.0);
//   }
//   static TextStyle caption2(BuildContext context){
//     return Theme.of(context).textTheme.display4.copyWith(fontSize: 192.0);
//   }
//   static TextStyle display5(BuildContext context) {
//     return Theme.of(context).textTheme.display4.copyWith(fontSize: 192.0);
//   }
// }
// class TexStyle{
//
// }