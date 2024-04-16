import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fisica/index.dart';

class GroupJoinRequestsPage extends StatefulWidget {
  const GroupJoinRequestsPage({Key? key}) : super(key: key);

  @override
  _GroupJoinRequestsPageState createState() => _GroupJoinRequestsPageState();
}

class _GroupJoinRequestsPageState extends State<GroupJoinRequestsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<GroupInvitation> groupInvitation = [];
  var parsedJson;
  @override
  void initState() {
    super.initState();
    initGroupData();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  Future<void> initGroupData() async {
    GroupApi.getGroupInvitations().then((value) => setState(() {
          parsedJson = value;
          groupInvitation = GroupInvitation.parseGroupInvitation(parsedJson);
          print(groupInvitation);
        }));
  }

  void showCustomSnackBar(BuildContext context, String type, String name) {
    final snackBar = SnackBar(
      backgroundColor: AppColors.primary,

      content: Text(
        (type == 'ok') ? name + SetLocalizations.of(context).getText('tmddlsehla') : name + SetLocalizations.of(context).getText('rjwjdehla'),
        style: AppFont.s12.overrides(
          color: AppColors.Black,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 3), // Set the duration to 3 seconds
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    super.dispose();
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
                      'rmfnqdk' /* 그룹 참여신청관리  */,
                    ),
                    style: AppFont.s18.overrides(color: AppColors.primaryBackground)),
                centerTitle: false,
                elevation: 0.0,
              ),
              body: Column(
                children: [
                  Flexible(
                    child: ListView.builder(
                      itemCount: groupInvitation.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 48,
                                          height: 48,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.network(
                                            'https://picsum.photos/seed/279/600',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 13),
                                          child: Text(
                                            groupInvitation[index].requestUserName,
                                            style: AppFont.r16.overrides(color: AppColors.primaryBackground),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 42,
                                              child: LodingButtonWidget(
                                                onPressed: () async {
                                                  await GroupApi.updateGroupInvitationByGroupLeader('DECLINED', groupInvitation[index].requestUid);
                                                  showCustomSnackBar(
                                                    context,
                                                    'no',
                                                    groupInvitation[index].requestUserName,
                                                  );
                                                },
                                                text: SetLocalizations.of(context).getText(
                                                  'tlscudrj' /* 신청거절 */,
                                                ),
                                                options: LodingButtonOptions(
                                                  height: 40.0,
                                                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                  color: AppColors.Black,
                                                  textStyle: AppFont.s18.overrides(fontSize: 12, color: AppColors.primaryBackground),
                                                  elevation: 0,
                                                  borderSide: BorderSide(
                                                    color: AppColors.primaryBackground,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 17,
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 42,
                                              child: LodingButtonWidget(
                                                onPressed: () async {
                                                  await GroupApi.updateGroupInvitationByGroupLeader('ACCEPTED', groupInvitation[index].requestUid);
                                                  showCustomSnackBar(
                                                    context,
                                                    'ok',
                                                    groupInvitation[index].requestUserName,
                                                  );
                                                },
                                                text: SetLocalizations.of(context).getText(
                                                  'gkalt' /* 참여신청승인 */,
                                                ),
                                                options: LodingButtonOptions(
                                                  height: 40.0,
                                                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                  color: AppColors.primaryBackground,
                                                  textStyle: AppFont.s18.overrides(fontSize: 12, color: AppColors.Black),
                                                  elevation: 0,
                                                  borderSide: BorderSide(
                                                    color: AppColors.primaryBackground,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Divider(color: AppColors.Gray700),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
                    child: TextButton(
                      onPressed: () {
                        context.pushNamed('GroupJoinHistory');
                      },
                      child: Text(
                          SetLocalizations.of(context).getText(
                            'rlfhrqhrl' /* 기록보기 */,
                          ),
                          style: AppFont.r16.overrides(
                            fontSize: 12, color: AppColors.Gray300, decoration: TextDecoration.underline, // Adding underline
                          )),
                      // Style your button here
                    ),
                  ),
                ],
              ))),
    );
  }
}
