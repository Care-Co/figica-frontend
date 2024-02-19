import 'dart:convert';

import 'package:figica/components/changeLeader_pop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:figica/index.dart';

class ChangeLeaderPage extends StatefulWidget {
  const ChangeLeaderPage({Key? key}) : super(key: key);

  @override
  _ChangeLeaderPageState createState() => _ChangeLeaderPageState();
}

class _ChangeLeaderPageState extends State<ChangeLeaderPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<GroupMember> groupMembers = [];
  String selectedUserIds = '';
  String onlyname = '';
  String group = '';

  @override
  void initState() {
    super.initState();
    initGroupData();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  Future<void> initGroupData() async {
    var groupData = await GroupApi.getGroup();
    var parsedJson = json.decode(groupData!);

    print("test");
    setState(() {
      group = parsedJson['data']['groupName'];
      groupMembers = GroupMember.parseGroupInvitation(groupData);
    });
  }

  void _onMemberSelected(bool isSelected, String userId, String auth, String name) {
    setState(() {
      if (isSelected) {
        selectedUserIds = userId;
        onlyname = name;
      } else if (selectedUserIds == userId) {
        selectedUserIds = '';
        onlyname = '';
      }
    });
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
                actions: [
                  IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () async {
                      context.pop();
                    },
                  ),
                ],
                backgroundColor: Color(0x00CCFF8B),
                automaticallyImplyLeading: false,
                title: Text(SetLocalizations.of(context).getText('rmfwnqkddlwjs'), style: AppFont.s18.overrides(color: AppColors.primaryBackground)),
                centerTitle: false,
                elevation: 0.0,
              ),
              body: Column(
                children: [
                  Flexible(
                    child: ListView.builder(
                      itemCount: groupMembers.length,
                      itemBuilder: (context, index) {
                        bool isSelected = selectedUserIds == groupMembers[index].userUid;
                        return Container(
                          width: 232,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                groupMembers[index].name,
                                                style: AppFont.s18.overrides(fontSize: 16, color: AppColors.primaryBackground),
                                              ),
                                              Text(groupMembers[index].authority,
                                                  style: AppFont.r16.overrides(fontSize: 12, color: AppColors.Gray300)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Theme(
                                            data: ThemeData(
                                                checkboxTheme: CheckboxThemeData(
                                                  visualDensity: VisualDensity.compact,
                                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(12.0),
                                                  ),
                                                ),
                                                unselectedWidgetColor: AppColors.Gray700),
                                            child: Checkbox(
                                              value: isSelected,
                                              checkColor: AppColors.Black, // Color of the tick
                                              activeColor: AppColors.Gray100, // Background color
                                              onChanged: (bool? newValue) {
                                                _onMemberSelected(
                                                    newValue!, groupMembers[index].userUid, groupMembers[index].authority, groupMembers[index].name);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: AppColors.Gray700,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      width: double.infinity,
                      height: 56.0,
                      child: LodingButtonWidget(
                        onPressed: () async {
                          if (selectedUserIds.isNotEmpty) {
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
                                      child: ChangeLeaderpop(
                                        selectedUserIds: selectedUserIds,
                                        group: group,
                                        name: onlyname,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                        text: SetLocalizations.of(context).getText('rmfnqwk'),
                        options: LodingButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                          color: selectedUserIds.isEmpty ? AppColors.Gray200 : AppColors.primaryBackground,
                          textStyle:
                              AppFont.s18.overrides(fontSize: 16, color: selectedUserIds.isEmpty ? AppColors.primaryBackground : AppColors.Black),
                          elevation: 0,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}
