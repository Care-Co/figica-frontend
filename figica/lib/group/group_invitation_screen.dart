import 'package:figica/flutter_set/App_icon_button.dart';
import 'package:figica/flutter_set/figica_theme.dart';
import 'package:figica/flutter_set/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GroupInvitationScreen extends StatelessWidget {
  final String invitationCode;

  GroupInvitationScreen({Key? key, required this.invitationCode}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.Black,
      appBar: AppBar(
        backgroundColor: Color(0x00CCFF8B),
        automaticallyImplyLeading: false,
        title: Text(
          SetLocalizations.of(context).getText(
            'rmfnqt' /* Page Title */,
          ),
          style: AppFont.s18,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24, 40, 24, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                SetLocalizations.of(context).getText(
                  'rmfnqdhksfy' /* Page Title */,
                ),
                style: AppFont.b24.overrides(color: AppColors.primaryBackground),
              ),
              Container(
                width: 327,
                height: 72,
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFCFDFF).withOpacity(0.20), // 시작 색상
                      Color(0xFFFCFDFF).withOpacity(0.04), // 끝 색상
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.50, color: Color(0x33FBFCFF)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0xB2121212),
                      blurRadius: 8,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(
                    SetLocalizations.of(context).getText(
                      '초대코드' + invitationCode,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: invitationCode));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("초대코드가 복사되었습니다."),
                        ),
                      );
                    },
                  )
                ]),
              ),
              Text(
                SetLocalizations.of(context).getText(
                  '초대코드' + invitationCode,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
