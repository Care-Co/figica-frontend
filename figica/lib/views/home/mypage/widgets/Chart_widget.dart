import 'package:fisica/index.dart';
import 'package:fisica/models/WeightData.dart';
import 'package:fisica/views/home/mypage/widgets/calendar.dart';
import 'package:fisica/views/home/scan/Foot_Controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/streams.dart';

class Chart extends StatefulWidget {
  final List<WeightData> data;

  const Chart({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<DateTime> timeData = [];
  List<double> weights = [];
  List<String> weightTypes = [];
  LineBarSpot? _lastTouchedSpot;
  DateTime? selectedDate2;
  bool isCalendarOpened = false;
  String selectedSortOption = '최신순';

  final List<String> sortOptions = ['최신순', '오래된 순'];
  void initState() {
    super.initState();
    processData(widget.data);
    selectedDate2 = timeData.last;
    sortData();
    print(widget.data);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void processData(List<WeightData> data) {
    timeData = [];
    weights = [];
    weightTypes = [];

    for (var item in data) {
      DateTime dateTime = item.measuredTime;

      timeData.add(dateTime);
      weights.add(item.weight);
      weightTypes.add(item.weightType);
    }
    print(weights.length);
  }

  List<Color> gradientColors = [
    AppColors.primary,
    AppColors.Black,
  ];

  bool showAvg = false;
  void _onDateSelected(DateTime newDate) {
    DateTime matchedDate = timeData.firstWhere(
      (date) => date.year == newDate.year && date.month == newDate.month && date.day == newDate.day,
    );
    setState(() {
      selectedDate2 = matchedDate;
    });
  }

  String formatDateTime(DateTime timeStr) {
    String formatted = DateFormat('yy/MM/dd EEEE HH:mm', 'ko_KR').format(timeStr);
    return formatted;
  }

  String typestring(String type) {
    switch (type) {
      case 'FOOTPRINT':
        {
          return 'Footprint 측정';
        }
      case 'WEIGHT':
        {
          return 'Weight 측정';
        }
      case 'USER':
        {
          return '직접 입력';
        }
    }
    return type;
  }

  void sortData() {
    if (selectedSortOption == '최신순') {
      widget.data.sort((a, b) => b.measuredTime.compareTo(a.measuredTime));
    } else if (selectedSortOption == '오래된 순') {
      widget.data.sort((a, b) => a.measuredTime.compareTo(b.measuredTime));
    }
  }

  @override
  Widget build(BuildContext context) {
    double chartWidth = timeData.length * 60.0;
    return Scaffold(
      backgroundColor: AppColors.Black,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                                            selectedDate: selectedDate2,
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
                            value: selectedDate2,
                            onChanged: (DateTime? newValue) {
                              setState(() {
                                selectedDate2 = newValue;
                              });
                            },
                            items: timeData.map<DropdownMenuItem<DateTime>>((DateTime weightValue) {
                              String weightDate =
                                  "${weightValue.year}.${weightValue.month.toString().padLeft(2, '0')}.${weightValue.day.toString().padLeft(2, '0')}";

                              return DropdownMenuItem<DateTime>(
                                value: weightValue,
                                child: Text(
                                  weightDate,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: chartWidth,
                      height: 170,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LineChart(
                          mainData(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 300,
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
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
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
                          bool plus = true;
                          if (widget.data[index].weightChange != null) {
                            if (widget.data[index].weightChange < 0) {
                              plus = true;
                            } else {
                              plus = false;
                            }
                          }
                          return Container(
                            height: 86,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            formatDateTime(widget.data[index].measuredTime),
                                            style: AppFont.r16.overrides(color: AppColors.Gray500, fontSize: 10),
                                          ),
                                          Text(
                                            typestring(widget.data[index].weightType),
                                            style: AppFont.s12,
                                          )
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            widget.data[index].weightChange.toString() + 'kg',
                                            style: AppFont.s12.overrides(color: plus ? AppColors.AlertGreen : AppColors.red),
                                          ),
                                          Text(
                                            '${widget.data[index].weight}kg',
                                            style: AppFont.s12.overrides(fontSize: 16, color: AppColors.Black),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: AppColors.Gray100,
                                )
                              ],
                            ),

                            // title: Text("Type: ${widget.data[index]['weightType']}"),
                            // subtitle: Text(
                            //     "Date: ${widget.data[index]['measuredDate']} Time: ${widget.data[index]['measuredTime']}\nWeight: ${widget.data[index]['weight']}kg Difference: ${diff != null ? diff.toStringAsFixed(2) : 'N/A'}kg"),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Color LineTooltipColor(LineBarSpot touchedSpot) {
    return AppColors.primary;
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
          setState(() {
            if (event is! FlPointerExitEvent && touchResponse?.lineBarSpots != null) {
              _lastTouchedSpot = touchResponse!.lineBarSpots!.first;
            } else if (event is FlPointerExitEvent) {
              //print(_lastTouchedSpot.toString());
            }
          });
        },
        touchTooltipData: LineTouchTooltipData(
          tooltipRoundedRadius: 16,
          getTooltipColor: LineTooltipColor,
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            if (_lastTouchedSpot != null) {
              final textStyle = AppFont.s12.overrides(color: AppColors.Black);
              return [LineTooltipItem('${_lastTouchedSpot!.y}', textStyle)];
            }
            return [];
          },
        ),
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: AppColors.DarkenGreen,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: AppColors.Black,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) {
              final DateTime date = timeData[value.toInt()];
              return Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  '${date.month}/${date.day}',
                  style: AppFont.s12.overrides(color: AppColors.Gray200),
                ),
              );
            },
            reservedSize: 40,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(bottom: (BorderSide(color: AppColors.Gray700))),
      ),
      minX: 0,
      maxX: timeData.length.toDouble() - 1,
      minY: weights.reduce(min) - 0.5,
      maxY: weights.reduce(max) + 0.5,
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(
            timeData.length,
            (index) => FlSpot(index.toDouble(), weights[index]),
          ),
          isCurved: false,
          barWidth: 1,
          color: AppColors.primaryBackground,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
