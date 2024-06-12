import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:fisica/index.dart';

class GroupWidget extends StatefulWidget {
  const GroupWidget({Key? key}) : super(key: key);

  @override
  _GroupWidgetState createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late AppStateNotifier _appStateNotifier;

  @override
  void initState() {
    super.initState();
    _appStateNotifier = AppStateNotifier.instance;
    WidgetsBinding.instance.addPostFrameCallback((_) {});
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

    return Consumer<AppStateNotifier>(builder: (context, appStateNotifier, child) {
      bool groif = appStateNotifier.isGroup;
      print(groif);
      return GestureDetector(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: AppColors.Black,
          appBar: AppBar(
            backgroundColor: groif ? AppColors.Gray850 : Color(0x00CCFF8B),
            automaticallyImplyLeading: false,
            title: Text(SetLocalizations.of(context).getText('ze1uteze'), style: AppFont.s18.overrides(color: AppColors.primaryBackground)),
            actions: (!groif)
                ? []
                : <Widget>[
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        context.pushNamed(
                          'groupSetting',
                          extra: {'authority': 'LEADER', 'groupname': 'name'},
                        );
                      },
                    ),
                  ],
            centerTitle: false,
            elevation: 0.0,
          ),
          body: result(),
        ),
      );
    });
  }

  Widget result() {
    print(_appStateNotifier.iswait);
    return _appStateNotifier.isGroup
        ? YesgroupScreen()
        : _appStateNotifier.iswait
            ? WaitgroupScreen()
            : NogroupScreen();

    // switch (groupStatus) {
    //   case 'NO_GROUPS':
    //     return NogroupScreen();
    //   case 'waiting':
    //     return WaitgroupScreen();
    //   default:
    //     return YesgroupScreen();
    // }
  }
}
