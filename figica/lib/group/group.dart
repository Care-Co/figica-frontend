import 'package:figica/User_Controller.dart';
import 'package:figica/flutter_set/figica_theme.dart';
import 'package:figica/group/creategroup_widget.dart';
import 'package:figica/group/group_api.dart';
import 'package:figica/group/group_no.dart';
import 'package:figica/group/group_yes.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../flutter_set/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class groupWidget extends StatefulWidget {
  const groupWidget({Key? key}) : super(key: key);

  @override
  _groupWidgetState createState() => _groupWidgetState();
}

class _groupWidgetState extends State<groupWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  String groupStatus = "loading";

  void updateCounter() {
    setState(() {
      groupStatus = 'success';
    });
  }

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
          backgroundColor: (groupStatus == "fail") ? AppColors.Black : AppColors.Gray850,
          appBar: AppBar(
            backgroundColor: Color(0x00CCFF8B),
            automaticallyImplyLeading: false,
            title: Text(
                SetLocalizations.of(context).getText(
                  'ze1uteze' /* 그룹   */,
                ),
                style: AppFont.s18.overrides(color: AppColors.primaryBackground)),
            actions: [],
            centerTitle: false,
            elevation: 0.0,
          ),
          body: SmartRefresher(
              header: const ClassicHeader(
                spacing: 0,
                releaseText: '',
                completeText: '',
              ),
              footer: const ClassicFooter(
                spacing: 0,
                loadingText: '',
                canLoadingText: '',
                idleText: '',
              ),
              enablePullDown: true,
              enablePullUp: true,
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
              child: (groupStatus == "loading")
                  ? CircularProgressIndicator()
                  : (groupStatus == "fail")
                      ? GroupScreen1(updateCounter: updateCounter)
                      : GroupScreen2(
                          histories: GroupApi.parseHistories(groupStatus),
                        )),
        ),
      ),
    );
  }
}
