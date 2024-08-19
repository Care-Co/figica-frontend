import 'package:fisica/index.dart';
import 'package:fisica/models/FootData.dart';
import 'package:fisica/utils/service/Foot_Controller.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ToggleImageSwitch extends StatefulWidget {
  final String mode;
  final int type;

  const ToggleImageSwitch({Key? key, required this.mode, required this.type}) : super(key: key);

  @override
  _ToggleImageSwitchState createState() => _ToggleImageSwitchState();
}

class _ToggleImageSwitchState extends State<ToggleImageSwitch> {
  late String gender;
  String image = '';
  List<String> imageList = [];
  bool main = true;

  final PageController _pageController = PageController();

  int _currentIndex = 0;
  Future<void> getData() async {
    var data = AppStateNotifier.instance.userdata;

    var genderset = data?.gender ?? 'MALE';
    gender = genderset.toLowerCase();

    settype(widget.type);
  }

  Future<void> getData2() async {
    gender = 'male';

    settype(widget.type);
  }

  void settype(int typeint) {
    image = 'assets/bodygrapic';
    switch (typeint) {
      case 0:
        getImagePath3('normal');
        break;
      case 1:
        getImagePath3('yo');
        break;
      case 2:
        getImagePath3('flat');
        break;
      case 3:
        getImagePath3('front');
        break;
      case 4:
        getImagePath3('back');
        break;
      case 5:
        getImagePath4('left');
        break;
      case 6:
        getImagePath4('right');
        break;
      case 7:
        getImagePath4('leftroll');
        break;
      case 8:
        getImagePath4('rightroll');
        break;
      default:
    }
  }

  void getImagePath3(String type) {
    imageList.add('assets/bodygrapic/$type/$gender/front.png');
    imageList.add('assets/bodygrapic/$type/$gender/side.png');
    imageList.add('assets/bodygrapic/$type/$gender/back.png');
  }

  void getImagePath4(String type) {
    imageList.add('assets/bodygrapic/$type/$gender/front.png');
    imageList.add('assets/bodygrapic/$type/$gender/side_l.png');
    imageList.add('assets/bodygrapic/$type/$gender/side_r.png');
    imageList.add('assets/bodygrapic/$type/$gender/back.png');
  }

  @override
  void initState() {
    super.initState();
    if (widget.mode != 'main') {
      getData2();
    } else
      getData();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose(); // 리소스 해제
  }

  @override
  Widget build(BuildContext context) {
    final List<String> labels = imageList.length == 4
        ? [
            SetLocalizations.of(context).getText('reportPlantarPressureDetailPainButtonFrontLabel'),
            SetLocalizations.of(context).getText('reportPlantarPressureDetailPainButtonLSideLabel'),
            SetLocalizations.of(context).getText('reportPlantarPressureDetailPainButtonRSideLabel'),
            SetLocalizations.of(context).getText('reportPlantarPressureDetailPainButtonBackLabel')
          ]
        : [
            SetLocalizations.of(context).getText('reportPlantarPressureDetailPainButtonFrontLabel'),
            SetLocalizations.of(context).getText('reportPlantarPressureDetailPainButtonSideLabel'),
            SetLocalizations.of(context).getText('reportPlantarPressureDetailPainButtonBackLabel')
          ];
    final int totalSwitches = labels.length; // 전환 스위치의 총 개수
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 460,
          child: PageView.builder(
            controller: _pageController,
            itemCount: imageList.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.asset(
                imageList[index],
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: ToggleSwitch(
            minWidth: 70.0,
            minHeight: 36,
            initialLabelIndex: _currentIndex,
            cornerRadius: 20.0,
            activeFgColor: AppColors.primary,
            inactiveBgColor: AppColors.Gray200,
            inactiveFgColor: AppColors.Gray500,
            totalSwitches: totalSwitches,
            labels: labels,
            radiusStyle: true,
            activeBgColors: List.generate(totalSwitches, (_) => [AppColors.Black]),
            onToggle: (index) {
              setState(() {
                _currentIndex = index!;
                _pageController.animateToPage(
                  _currentIndex,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              });
            },
          ),
        ),
      ],
    );
  }
}
