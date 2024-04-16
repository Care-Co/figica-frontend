import 'package:fisica/components/cancel_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:social_share/social_share.dart';

import 'package:fisica/index.dart';

Widget buildCircularShareButton(IconData icon) {
  return GestureDetector(
    onTap: () {
      SocialShare.shareSms("This is Social Share Sms example");
    },
    child: Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    ),
  );
}

class GroupInvitationScreen extends StatefulWidget {
  GroupInvitationScreen({Key? key}) : super(key: key);
  @override
  _CreategroupWidgetState createState() => _CreategroupWidgetState();
}

class _CreategroupWidgetState extends State<GroupInvitationScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String invitationCode = '';
  @override
  void initState() {
    super.initState();
    _loadInvitationCode();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadInvitationCode() async {
    try {
      String code = await GroupApi.createInvitationCode();
      setState(() {
        invitationCode = code;
      });
    } catch (e) {
      // 오류 처리
      print('Error getting invitation code: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: Text(
                    SetLocalizations.of(context).getText(
                      'rmfnqdhksfy' /* Page Title */,
                    ),
                    style: AppFont.b24.overrides(color: AppColors.primaryBackground),
                  ),
                ),
                Container(
                  width: 327,
                  height: 185,
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
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Text(
                                SetLocalizations.of(context).getText('cheo') + " : " + invitationCode,
                                style: AppFont.s18.overrides(color: AppColors.primaryBackground),
                              ),
                              IconButton(
                                icon: Icon(Icons.copy),
                                color: AppColors.primaryBackground,
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
                            Text(
                              SetLocalizations.of(context).getText(
                                'tofhqkfrmf' /* Page Title */,
                              ),
                              style: AppFont.r16.overrides(color: AppColors.Gray300),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          height: 56.0,
                          child: LodingButtonWidget(
                            onPressed: () async {
                              showAlignedDialog(
                                context: context,
                                isGlobal: true,
                                avoidOverflow: false,
                                targetAnchor: AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
                                followerAnchor: AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
                                builder: (dialogContext) {
                                  return Material(
                                    color: Colors.transparent,
                                    child: GestureDetector(
                                      child: Container(
                                        height: 432,
                                        width: 327,
                                        child: Cancelcode(),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            text: SetLocalizations.of(context).getText(
                              'xhemcnlth',
                            ),
                            options: LodingButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                              color: Colors.transparent,
                              textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.primaryBackground),
                              elevation: 0,
                              borderSide: BorderSide(
                                color: AppColors.primaryBackground,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 37),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '바로 공유하기',
                        style: AppFont.s18.overrides(color: AppColors.primaryBackground),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Container(
                          height: 112,
                          width: 327,
                          decoration: BoxDecoration(
                            color: AppColors.Gray850,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              buildCircularShareButton(Icons.facebook),
                              buildCircularShareButton(Icons.camera),
                              buildCircularShareButton(Icons.message),
                              buildCircularShareButton(Icons.link),
                              buildCircularShareButton(Icons.more),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Container(
                    width: double.infinity,
                    height: 56.0,
                    child: LodingButtonWidget(
                      onPressed: () {
                        context.goNamed('home');
                      },
                      text: SetLocalizations.of(context).getText(
                        'rmfnqghq',
                      ),
                      options: LodingButtonOptions(
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: Colors.transparent,
                        textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.primaryBackground),
                        elevation: 0,
                        borderSide: BorderSide(
                          color: AppColors.primaryBackground,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
