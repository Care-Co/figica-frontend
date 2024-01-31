import 'package:figica/flutter_set/App_icon_button.dart';
import 'package:figica/group/Wait_group_Screen.dart';
import 'package:figica/group/No_group_Screen.dart';
import 'package:figica/group/Yes_group_Screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:figica/index.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({Key? key}) : super(key: key);

  @override
  _HistoryWidgetState createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
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
            leading: AppIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 40.0,
              icon: Icon(
                Icons.chevron_left,
                color: AppColors.Gray700,
                size: 24.0,
              ),
              onPressed: () async {
                context.pop();
              },
            ),
          ),
          body: SafeArea(
            child: Container(),
          ),
        ),
      ),
    );
  }
}
