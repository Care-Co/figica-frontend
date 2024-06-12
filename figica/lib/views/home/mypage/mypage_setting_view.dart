import 'package:fisica/views/home/mypage/mypage_components/out_popup.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fisica/index.dart';

class MySetting extends StatefulWidget {
  const MySetting({Key? key}) : super(key: key);

  @override
  _MySettingState createState() => _MySettingState();
}

class _MySettingState extends State<MySetting> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  _showLeaveDialog() {
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
              child: Exitservice(
                state: 'logout',
              ),
            ),
          ),
        );
      },
    );
  }

  _showDeleteDialog() {
    print("tst");
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
              child: Exitservice(state: 'singout'),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> Menu = {
      '디바이스 관리': 'MemberManage',
      '알림 설정': 'GroupJoinRequest',
      '언어 설정': 'ChangeGroupName',
      '로그인 방식 추가': 'InvitationCodeManage',
      '전화번호 변경': 'DeleteGroup',
      '개인정보 처리방침': 'PublicInfoSetting',
      '서비스 이용 약관': 'NotificationSetting',
      '로그아웃': 'GroupHistory',
      '서비스 탈퇴': 'GroupHistory',
    };

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
      child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: AppColors.Black,
            appBar: AppBar(
              leading: AppIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 40.0,
                icon: Icon(
                  Icons.chevron_left,
                  color: AppColors.primaryBackground,
                  size: 24.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              backgroundColor: Color(0x00CCFF8B),
              automaticallyImplyLeading: false,
              title: Text(
                  SetLocalizations.of(context).getText(
                    'tjfwjd' /* 설정  */,
                  ),
                  style: AppFont.s18.overrides(color: AppColors.primaryBackground)),
              centerTitle: false,
              elevation: 0.0,
            ),
            body: ListView.builder(
              itemCount: Menu.length,
              itemBuilder: (context, index) {
                String menuTitle = Menu.keys.elementAt(index);
                return ListTile(
                  title: Text(menuTitle, style: AppFont.s12.overrides(fontSize: 16, color: AppColors.Gray100)),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: AppColors.Gray100,
                  ),
                  onTap: () {
                    if (menuTitle == '로그아웃') {
                      _showLeaveDialog();
                    } else if (menuTitle == '서비스 탈퇴') {
                      _showDeleteDialog();
                    } else {
                      context.pushNamed(Menu[menuTitle]!);
                    }
                  },
                );
              },
            ),
          )),
    );
  }
}
