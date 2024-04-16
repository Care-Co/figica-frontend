import 'dart:convert';

import 'package:fisica/group/Wait_group_Screen.dart';
import 'package:fisica/group/No_group_Screen.dart';
import 'package:fisica/group/Yes_group_Screen.dart';
import 'package:fisica/main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fisica/index.dart';

class GroupWidget extends StatefulWidget {
  const GroupWidget({Key? key}) : super(key: key);

  @override
  _GroupWidgetState createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  String printAuthority(String response) {
    var decodedResponse = json.decode(response);
    String authority = decodedResponse['data']['myself']['authority'];
    print(authority);
    return authority;
  }

  String groupname(String response) {
    var decodedResponse = json.decode(response);
    String groupname = decodedResponse['data']['groupName'];
    print(groupname);
    return groupname;
  }

  String groupStatus = "loading";

  @override
  void initState() {
    super.initState();
    GroupApi.findGroup().then((status) {
      setState(() {
        groupStatus = status;
        print(groupStatus);
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget result(String groupStatus) {
    if (groupStatus == 'fail') {
      return NogroupScreen();
    } else if (groupStatus == 'loading') {
      return CircularProgressIndicator();
    } else if (groupStatus == 'waiting') {
      return WaitgroupScreen();
    } else {
      GroupApi.saveGroup(groupStatus);
      return YesgroupScreen(
        authority: printAuthority(groupStatus),
        data: groupStatus,
      );
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
      child: GestureDetector(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: (groupStatus == "fail") ? AppColors.Black : AppColors.Gray850,
          appBar: AppBar(
            backgroundColor: Color(0x00CCFF8B),
            automaticallyImplyLeading: false,
            title: Text(
                SetLocalizations.of(context).getText(
                  'ze1uteze' /* 그룹   */,
                ),
                style: AppFont.s18.overrides(color: AppColors.primaryBackground)),
            actions: (groupStatus == "fail")
                ? []
                : <Widget>[
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        context.pushNamed(
                          'groupSetting',
                          extra: {'authority': printAuthority(groupStatus), 'groupname': groupname(groupStatus)},
                        );
                      },
                    ),
                  ],
            centerTitle: false,
            elevation: 0.0,
          ),
          body: SmartRefresher(
            header: const ClassicHeader(
              spacing: 0,
              releaseText: '',
              completeText: '',
            ),
            // footer: const ClassicFooter(
            //   spacing: 0,
            //   loadingText: '',
            //   canLoadingText: '',
            //   idleText: '',
            // ),
            enablePullDown: true,
            enablePullUp: false,
            onRefresh: () {
              GroupApi.findGroup().then((status) {
                setState(() {
                  groupStatus = status;
                  print(groupStatus);
                });
              });
              _refreshController.refreshCompleted();
            },
            onLoading: () {
              _refreshController.loadComplete();
            },
            controller: _refreshController,
            child: result(groupStatus),
          ),
        ),
      ),
    );
  }
}
