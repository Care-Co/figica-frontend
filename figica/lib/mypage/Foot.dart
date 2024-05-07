import 'package:fisica/index.dart';
import 'package:fisica/models/FootData.dart';
import 'package:fisica/mypage/calendar.dart';
import 'package:fisica/scan/Foot_Controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/streams.dart';

class Footreport extends StatefulWidget {
  final List<FootData> data;

  const Footreport({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<Footreport> createState() => _Footreport2State();
}

class _Footreport2State extends State<Footreport> with SingleTickerProviderStateMixin {
  bool isempty = true;
  String type = '';
  double _height = 100; // 초기 높이 설정
  List<DateTime> timeData = [];
  List<String> imageUrl = [];
  DateTime? selectedDate1;
  String? selectedUrl;
  bool isCalendarOpened = false;
  String selectedSortOption = '최신순';
  final List<String> sortOptions = ['최신순', '오래된 순'];

  late AnimationController _controller;
  late Animation<double> _animation;

  void initState() {
    super.initState();
    isempty = widget.data.isEmpty; // 데이터가 비어있는지 체크
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 300, end: 800).animate(_controller)
      ..addListener(() {
        setState(() {
          _height = _animation.value;
        });
      });
    if (!isempty) {
      print('not empty');
      print(widget.data);
      processData(widget.data);
      selectedDate1 = widget.data.last.measuredTime;

      _onDateSelected(selectedDate1!);
      sortData();
    }
  }

  String settype(int typeint) {
    switch (typeint) {
      case 0:
        return '정상발';
      case 1:
        return '요족';
      case 2:
        return '평발';
      case 3:
        return '척추 전만증';
      case 4:
        return '척추 후만증';
      case 5:
        return '척추 좌 측만증';
      case 6:
        return '척추 우 측만증';
      case 7:
        return '골반 비틀림';
      default:
        return '알 수 없는 상태';
    }
  }

  void _onDateSelected(DateTime newDate) {
    int index = timeData.indexWhere(
      (date) => date.year == newDate.year && date.month == newDate.month && date.day == newDate.day,
    );
    if (index != -1) {
      setState(() {
        selectedDate1 = timeData[index];
        selectedUrl = imageUrl[index];
      });
    }
  }

  void processData(List<FootData> data) {
    timeData = [];
    imageUrl = [];
    for (var item in data) {
      DateTime dateTime = item.measuredTime;

      timeData.add(dateTime);
      imageUrl.add(item.imageUrl);
    }
  }

  void sortData() {
    if (selectedSortOption == '최신순') {
      widget.data.sort((a, b) => b.measuredTime.compareTo(a.measuredTime));
    } else if (selectedSortOption == '오래된 순') {
      widget.data.sort((a, b) => a.measuredTime.compareTo(b.measuredTime));
    }
  }

  void _updateHeight(DragUpdateDetails details) {
    setState(() {
      _height -= details.delta.dy;
      if (_height < 100) _height = 100;
      if (_height > 800) _height = 800;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Black,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 44,
                    width: 112,
                    decoration: BoxDecoration(
                      color: AppColors.Gray850,
                      borderRadius: BorderRadius.circular(42),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.calendar_today),
                          color: isCalendarOpened ? AppColors.primaryBackground : AppColors.Gray500,
                          onPressed: () {
                            showModalBottomSheet(
                              barrierColor: Colors.transparent,
                              isScrollControlled: true,
                              backgroundColor: AppColors.Gray850,
                              enableDrag: false,
                              context: context,
                              builder: (context) {
                                return GestureDetector(
                                  child: Padding(
                                    padding: MediaQuery.viewInsetsOf(context),
                                    child: Container(
                                      height: MediaQuery.sizeOf(context).height * 0.70,
                                      child: CustomCalendar(
                                        timeData: timeData,
                                        selectedDate: selectedDate1,
                                        onDateSelected: _onDateSelected,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).then((value) => safeSetState(() {
                                  isCalendarOpened = false;
                                }));
                            setState(() {
                              isCalendarOpened = true;
                            });
                          },
                        ),
                        VerticalDivider(
                          color: AppColors.Gray500,
                        ),
                        IconButton(
                          icon: Icon(Icons.list),
                          color: isCalendarOpened ? AppColors.Gray500 : AppColors.primaryBackground,
                          onPressed: () {
                            setState(() {
                              if (isCalendarOpened) {
                                isCalendarOpened = false;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 44,
                    width: 160,
                    decoration: BoxDecoration(
                      color: AppColors.Gray850,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                      child: DropdownButton<DateTime>(
                        dropdownColor: AppColors.Gray850,
                        hint: Text("날짜 선택"),
                        value: selectedDate1,
                        onChanged: (DateTime? newValue) {
                          _onDateSelected(newValue!);
                        },
                        items: timeData.map<DropdownMenuItem<DateTime>>((DateTime value) {
                          String formattedDate = "${value.year}.${value.month.toString().padLeft(2, '0')}.${value.day.toString().padLeft(2, '0')}";

                          return DropdownMenuItem<DateTime>(
                            value: value,
                            child: Text(
                              formattedDate,
                              style: AppFont.s12.overrides(fontSize: 16, color: AppColors.Gray100),
                            ),
                          );
                        }).toList(),
                        underline: SizedBox.shrink(),
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          //color: AppColors.Gray100,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            isempty
                ? Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '데이터가 없습니다.',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: Stack(
                      children: [
                        Align(
                          alignment: FractionalOffset(0.5, 0),
                          child: Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(66, 66, 66, 38),
                                  child: Container(
                                    width: double.infinity,
                                    height: 190,
                                    decoration: BoxDecoration(color: Colors.transparent),
                                    child: selectedUrl != null
                                        ? Image.network(
                                            selectedUrl!,
                                            width: 190,
                                            fit: BoxFit.contain,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Text('이미지를 로드할 수 없습니다.', style: TextStyle(color: Colors.white));
                                            },
                                          )
                                        : Container(
                                            color: Colors.black, // Display a black container if selectedUrl is null
                                          ),
                                  ),
                                ),
                                Container(
                                  width: 252,
                                  height: 52.0,
                                  decoration: BoxDecoration(),
                                  child: LodingButtonWidget(
                                    onPressed: () async {},
                                    text: '이상적인 Footprint와 비교하기',
                                    options: LodingButtonOptions(
                                      height: 40.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                      color: AppColors.primary,
                                      textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.Black),
                                      elevation: 0,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // 드래그 기능
                        Align(
                          alignment: FractionalOffset(0.5, 1), // 중앙
                          child: GestureDetector(
                            onVerticalDragUpdate: _updateHeight, // 드래그 감지

                            child: Container(
                              height: _height,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.primaryBackground,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(32), // 상단 왼쪽 모서리 둥글게
                                  topRight: Radius.circular(32), // 상단 오른쪽 모서리 둥글게
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 2,
                                        width: 44,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)), color: AppColors.Gray500),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          DropdownButton<String>(
                                            value: selectedSortOption,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedSortOption = newValue!;
                                                sortData(); // 데이터 정렬 함수
                                              });
                                            },
                                            underline: Container(),
                                            icon: Icon(Icons.keyboard_arrow_down_rounded),
                                            items: sortOptions.map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: AppFont.s12.overrides(fontSize: 18),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: widget.data.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            height: 242,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    DateFormat('yyyy.MM.dd').format(widget.data[index].measuredDate) + ' 측정 리포트',
                                                    style: AppFont.s12.overrides(fontSize: 18, color: AppColors.Black),
                                                  ),
                                                  Text(
                                                    DateFormat('a hh:mm', 'ko_KR').format(widget.data[index].measuredTime) + ' 측정',
                                                    style: AppFont.r16.overrides(fontSize: 12, color: AppColors.Gray500),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                                                    child: Container(
                                                      height: 156,
                                                      decoration: BoxDecoration(
                                                        color: AppColors.Gray100,
                                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    '유형',
                                                                    style: AppFont.s12.overrides(color: AppColors.Gray500),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 2,
                                                                  ),
                                                                  Text(
                                                                    settype(widget.data[index].classType),
                                                                    style: AppFont.b24.overrides(fontSize: 20, color: AppColors.Black),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Divider(
                                                              height: 1.0, // Divider의 총 높이를 선의 두께와 동일하게 설정
                                                              thickness: 1.0, // 실제 선의 두께
                                                              color: AppColors.primaryBackground // 선의 색상
                                                              ),
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(
                                                                          '유사도',
                                                                          style: AppFont.s12.overrides(color: AppColors.Gray500),
                                                                        ),
                                                                        Text(
                                                                          '${widget.data[index].accuracy}%',
                                                                          style: AppFont.b24.overrides(fontSize: 20, color: AppColors.Black),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                VerticalDivider(
                                                                    width: 1.0, // Divider의 총 높이를 선의 두께와 동일하게 설정
                                                                    thickness: 1.0, // 실제 선의 두께
                                                                    color: AppColors.primaryBackground // 선의 색상
                                                                    ),
                                                                Expanded(
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(
                                                                          '체중',
                                                                          style: AppFont.s12.overrides(color: AppColors.Gray500),
                                                                        ),
                                                                        Text(
                                                                          '${widget.data[index].weight}kg',
                                                                          style: AppFont.b24.overrides(fontSize: 20, color: AppColors.Black),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(
                                                    color: AppColors.Gray100,
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
