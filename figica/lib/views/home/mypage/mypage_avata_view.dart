import 'package:fisica/views/home/home_page/home_info.dart';
import 'package:fisica/views/home/home_page/avata_widget.dart';
import 'package:fisica/models/FootData.dart';
import 'package:fisica/views/home/mypage/widgets/my_scandata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fisica/index.dart';
import 'package:provider/provider.dart';

class Myavata extends StatefulWidget {
  const Myavata({Key? key}) : super(key: key);
  @override
  _MyavataState createState() => _MyavataState();
}

class _MyavataState extends State<Myavata> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  double rightPosition = 0;
  bool detailstate = false;
  bool detailinfo = false;
  var mydata;

  void togglePositionAndControls() {
    setState(() {
      rightPosition = rightPosition == 0 ? -150 : 0;
      detailstate = !detailstate;
    });
  }

  void toggleddata() {
    setState(() {
      detailinfo = !detailinfo;
    });
  }

  late List<FootData>? foot;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  Future<void> showModalBottomSheetWithStates(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (context) => MyScanData(),
    );
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
    return Consumer<AppStateNotifier>(builder: (context, appStateNotifier, child) {
      foot = appStateNotifier.footdata;

      return GestureDetector(
        child: Scaffold(
            key: scaffoldKey,
            backgroundColor: AppColors.Black,
            appBar: AppBar(
              elevation: 0,
              titleSpacing: 10,
              backgroundColor: AppColors.Black,
              automaticallyImplyLeading: false,
              title: Text(SetLocalizations.of(context).getText('sodkqkxk')),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: AppColors.primaryBackground,
                    size: 20,
                  ),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ],
            ),
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Avata(
                    height: 400,
                  ),
                  MyScanData(),
                ],
              ),
            )),
      );
    });
  }
}
