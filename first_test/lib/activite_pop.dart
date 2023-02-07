import 'dart:convert';

import 'package:flutter/material.dart';
class pop extends StatefulWidget {
  const pop({Key? key}) : super(key: key);

  @override
  State<pop> createState() => _popState();
}

class _popState extends State<pop> {

  void bleDialog() {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 5), () {
            Navigator.pop(context);
          });
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            backgroundColor: Color(0xffffffff),
            //Dialog Main Title
            title: Column(
              children: <Widget>[

              ],
            ),
            //
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
