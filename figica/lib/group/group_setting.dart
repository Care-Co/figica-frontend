import 'package:fisica/components/delete_group.dart';
import 'package:fisica/components/exit_group.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fisica/index.dart';

class GroupSetting extends StatefulWidget {
  final String authority;
  final String groupname;
  const GroupSetting({Key? key, required this.authority, required this.groupname}) : super(key: key);

  @override
  _GroupSettingState createState() => _GroupSettingState();
}

class _GroupSettingState extends State<GroupSetting> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    print(widget.authority);
    print(widget.groupname);

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  _showLeaveGroupDialog() {
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
              child: ExitGroup(),
            ),
          ),
        );
      },
    );
  }

  _showDeleteGroupDialog() {
    print("_showDeleteGroupDialog");
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
              child: DeleteGroup(name: widget.groupname),
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
    final Map<String, String> leaderMenu = {
      '멤버 관리': 'MemberManage',
      '그룹 참여 신청 관리': 'GroupJoinRequest',
      '그룹명 변경': 'ChangeGroupName',
      '초대 코드 관리': 'InvitationCodeManage',
      '그룹 삭제': 'DeleteGroup',
      '공개 정보 설정': 'PublicInfoSetting',
      '알림 설정': 'NotificationSetting',
      '그룹 히스토리': 'GroupHistory',
    };

    // 일반 사용자용 메뉴 리스트와 페이지 매핑
    final Map<String, String> userMenu = {
      '공개 정보 설정': 'PublicInfoSetting',
      '알림 설정': 'NotificationSetting',
      '그룹 히스토리': 'GroupHistory',
      '그룹 나가기': 'LeaveGroup',
    };
    final menuList = (widget.authority == 'LEADER') ? leaderMenu : userMenu;

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
                    'rmfnt' /* 그룹   */,
                  ),
                  style: AppFont.s18.overrides(color: AppColors.primaryBackground)),
              centerTitle: false,
              elevation: 0.0,
            ),
            body: ListView.builder(
              itemCount: menuList.length,
              itemBuilder: (context, index) {
                String menuTitle = menuList.keys.elementAt(index);
                return ListTile(
                  title: Text(menuTitle, style: AppFont.s12.overrides(fontSize: 16, color: AppColors.Gray100)),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: AppColors.Gray100,
                  ),
                  onTap: () {
                    if (menuTitle == '그룹 나가기') {
                      _showLeaveGroupDialog();
                    } else if (menuTitle == '그룹 삭제') {
                      _showDeleteGroupDialog();
                    } else {
                      context.pushNamed(menuList[menuTitle]!);
                    }
                  },
                );
              },
            ),
          )),
    );
  }
}
