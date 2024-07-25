import 'package:fisica/models/FootData.dart';
import 'package:fisica/models/WeightData.dart';
import 'package:fisica/views/home/mypage/mypage_Chart_widget.dart';
import 'package:fisica/views/home/mypage/mypage_foot_view.dart';
import 'package:fisica/service/Foot_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fisica/index.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({Key? key}) : super(key: key);
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<HistoryWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
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
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.Black,
        appBar: AppBar(
          backgroundColor: AppColors.Gray850,
          automaticallyImplyLeading: false,
          title: Text(
            SetLocalizations.of(context).getText(
              'profileHistoryLabel' /* Page Title */,
            ),
            style: AppFont.s18.overrides(color: AppColors.primaryBackground),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: AppColors.primaryBackground,
                ),
                onPressed: () {
                  context.pop();
                },
              ),
            )
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Consumer<AppStateNotifier>(builder: (context, AppStateNotifier, child) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: AppColors.Gray850,
                    width: double.infinity,
                    height: 50,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                          child: ToggleSwitch(
                            minWidth: 300,
                            minHeight: 32,
                            initialLabelIndex: _currentIndex,
                            cornerRadius: 20.0,
                            activeFgColor: AppColors.Black,
                            inactiveBgColor: AppColors.Black,
                            inactiveFgColor: AppColors.Gray500,
                            customTextStyles: [AppFont.s12, AppFont.s12],
                            totalSwitches: 2,
                            labels: [
                              SetLocalizations.of(context).getText('historyPlantarPressureLabel'),
                              SetLocalizations.of(context).getText('historyWeightLabel')
                            ],
                            radiusStyle: true,
                            activeBgColors: List.generate(2, (_) => [AppColors.primary]),
                            onToggle: (index) {
                              setState(() {
                                _currentIndex = index!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: _currentIndex == 0 ? Footreport() : Chart(),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
