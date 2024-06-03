import 'package:fisica/models/FootData.dart';
import 'package:fisica/models/WeightData.dart';
import 'package:fisica/views/home/mypage/widgets/Chart_widget.dart';
import 'package:fisica/views/home/mypage/mypage_foot_view.dart';
import 'package:fisica/views/home/scan/Foot_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fisica/index.dart';
import 'package:toggle_switch/toggle_switch.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({Key? key}) : super(key: key);
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<HistoryWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future? _loadDataFuture;
  late List<FootData> footData;
  late List<WeightData> weightdata;

  int _currentIndex = 0;

  Future<void> getData() async {
    final now = DateTime.now();

    try {
      print('history ---- getData');

      weightdata = AppStateNotifier.instance.weightData!;
      WeightData.sortData(weightdata);
      footData = AppStateNotifier.instance.footdata!;
      //footDataClass.sortData(footData);
    } on Exception catch (e) {
      print(e);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadDataFuture = getData();
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
              'cmrwjdgltm' /* Page Title */,
            ),
            style: AppFont.s18.overrides(color: AppColors.primaryBackground),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: Icon(
                  Icons.cancel,
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
          child: FutureBuilder(
              future: _loadDataFuture,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("데이터 로딩 중 에러 발생"));
                } else {
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
                                  totalSwitches: 2,
                                  labels: ['족저압 분석', '체중 측정'],
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
                            child: _currentIndex == 0 ? Footreport(data: footData) : Chart(data: weightdata),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
