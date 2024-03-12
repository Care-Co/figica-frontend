import 'package:figica/components/No_device.dart';
import 'package:figica/components/Yes_device.dart';
import 'package:figica/scan/Foot_Controller.dart';
import 'package:flutter/material.dart';
import 'index.dart'; // 필요한 위젯을 불러오는 부분

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  int _selectedIndex = 0; // 가운데를 기본 선택으로 설정

  final List<Widget> _widgetOptions = <Widget>[
    HomePageWidget(),
    GroupWidget(),
    planWidget(),
    MypageWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> show(BuildContext context) async {
    await FootprintData.getdevice().then((value) {
      if (value == null) {
        showAlignedDialog(
          context: context,
          isGlobal: true,
          avoidOverflow: false,
          targetAnchor: AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
          followerAnchor: AlignmentDirectional(0, 0.5).resolve(Directionality.of(context)),
          builder: (dialogContext) {
            return Material(
              color: Colors.transparent,
              child: GestureDetector(
                child: Container(
                  height: 200,
                  width: 327,
                  child: NoDivice(),
                ),
              ),
            );
          },
        );
      } else {
        showAlignedDialog(
          context: context,
          isGlobal: true,
          avoidOverflow: false,
          targetAnchor: AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
          followerAnchor: AlignmentDirectional(0, 0.5).resolve(Directionality.of(context)),
          builder: (dialogContext) {
            return Material(
              color: Colors.transparent,
              child: GestureDetector(
                child: Container(
                  height: 60,
                  width: 327,
                  child: YesDivice(),
                ),
              ),
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => show(context),
        child: _buildSvgIcon('assets/icons/scan.svg', _selectedIndex == 2),
        backgroundColor: AppColors.DarkenGreen,
      ),
      floatingActionButtonLocation: CustomFabLoc(),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: BottomAppBar(
          color: AppColors.Gray850,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: _buildSvgIcon('assets/icons/home.svg', _selectedIndex == 0),
                onPressed: () => _onItemTapped(0),
              ),
              IconButton(
                icon: _buildSvgIcon('assets/icons/user.svg', _selectedIndex == 1),
                onPressed: () => _onItemTapped(1),
              ),
              SizedBox(width: 48),
              IconButton(
                icon: _buildSvgIcon('assets/icons/calendar.svg', _selectedIndex == 3),
                onPressed: () => _onItemTapped(2),
              ),
              IconButton(
                icon: _buildSvgIcon('assets/icons/my.svg', _selectedIndex == 4),
                onPressed: () => _onItemTapped(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomFabLoc extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double scaffoldWidth = scaffoldGeometry.scaffoldSize.width;
    final double scaffoldHeight = scaffoldGeometry.scaffoldSize.height;

    final double fabWidth = scaffoldGeometry.floatingActionButtonSize.width;
    final double fabHeight = scaffoldGeometry.floatingActionButtonSize.height;

    final double x = (scaffoldWidth / 2) - (fabWidth / 2);
    final double y = scaffoldHeight - fabHeight - 30;

    return Offset(x, y);
  }
}

Widget _buildSvgIcon(String assetName, bool isSelected) {
  return SvgPicture.asset(
    assetName,
    color: isSelected ? Colors.white : Colors.grey, // 선택 상태에 따른 색상 변경
    width: 24.0, // 아이콘 크기 조정
    height: 24.0,
  );
}
