import 'package:fisica/index.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  final List<DateTime> timeData;
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  CustomCalendar({
    required this.timeData,
    this.selectedDate,
    required this.onDateSelected,
  });

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime? _tempSelectedDate;
  DateTime _focusedDay = DateTime.now();
  late List<DropdownMenuItem<int>> monthDropdownItems;
  late List<DropdownMenuItem<int>> yearDropdownItems;

  late int selectedMonth;
  late int selectedYear;

  void initState() {
    super.initState();
    selectedMonth = _focusedDay.month;
    selectedYear = _focusedDay.year;
    yearDropdownItems = List.generate(6, (index) {
      // 2020년부터 2025년까지 예시
      int year = 2020 + index;
      return DropdownMenuItem<int>(
        value: year,
        child: Text("$year"),
      );
    });
    monthDropdownItems = List.generate(12, (index) {
      String month = (index + 1).toString().padLeft(2, '0');
      return DropdownMenuItem<int>(
        value: index + 1,
        child: Text(month),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 타이틀
                  Row(
                    children: [
                      DropdownButton<int>(
                        dropdownColor: AppColors.Gray850,
                        value: _focusedDay.year,
                        items: yearDropdownItems,
                        style: AppFont.b24.overrides(fontSize: 20, color: AppColors.Gray100),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedYear = value;
                              _focusedDay = DateTime(selectedYear, selectedMonth, _focusedDay.day);
                            });
                          }
                        },
                        underline: Container(),
                        icon: SizedBox.shrink(),
                      ),
                      Text(
                        '. ',
                        style: AppFont.b24.overrides(fontSize: 20, color: AppColors.Gray100),
                      ),
                      DropdownButton<int>(
                        dropdownColor: AppColors.Gray850,
                        value: _focusedDay.month,
                        items: monthDropdownItems,
                        style: AppFont.b24.overrides(fontSize: 20, color: AppColors.Gray100),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedMonth = value;
                              _focusedDay = DateTime(selectedYear, selectedMonth, _focusedDay.day);
                            });
                          }
                        },
                        underline: Container(),
                        icon: Icon(Icons.keyboard_arrow_down_rounded),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, size: 20),
                        onPressed: () {
                          setState(() {
                            _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1, _focusedDay.day);
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward_ios, size: 20),
                        onPressed: () {
                          setState(() {
                            _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1, _focusedDay.day);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              TableCalendar(
                headerVisible: false,
                firstDay: DateTime.utc(2010, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_tempSelectedDate, day),
                onDaySelected: (selectedDay, focusedDay) {
                  if (widget.timeData.any((date) => isSameDay(date, selectedDay))) {
                    setState(() {
                      _tempSelectedDate = selectedDay;
                    });
                  }
                },
                calendarStyle: CalendarStyle(),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    for (DateTime date in widget.timeData) {
                      if (isSameDay(date, day)) {
                        return Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.Black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            day.day.toString(),
                            style: AppFont.s18.overrides(color: AppColors.Gray100),
                          ),
                        );
                      }
                    }
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.Black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        day.day.toString(),
                        style: AppFont.s18.overrides(color: AppColors.Gray700),
                      ),
                    );
                  },
                  outsideBuilder: (context, day, focusedDay) {
                    for (DateTime date in widget.timeData) {
                      if (isSameDay(date, day)) {
                        return Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.Black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            day.day.toString(),
                            style: AppFont.s18.overrides(color: AppColors.Gray100),
                          ),
                        );
                      }
                    }
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.Gray850,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        day.day.toString(),
                        style: AppFont.s18.overrides(color: AppColors.Gray700),
                      ),
                    );
                  },
                  todayBuilder: (context, day, focusedDay) {
                    for (DateTime date in widget.timeData) {
                      if (isSameDay(date, day)) {
                        return Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.Black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            day.day.toString(),
                            style: AppFont.s18.overrides(color: AppColors.Gray100),
                          ),
                        );
                      }
                    }
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.Black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        day.day.toString(),
                        style: AppFont.s18.overrides(color: AppColors.Gray700),
                      ),
                    );
                  },
                  selectedBuilder: (context, day, focusedDay) {
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.Black,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.primary),
                      ),
                      child: Text(
                        day.day.toString(),
                        style: AppFont.s18.overrides(color: AppColors.primary),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
            child: Container(
              height: 56,
              width: double.infinity,
              child: LodingButtonWidget(
                onPressed: () {
                  if (_tempSelectedDate != null) {
                    widget.onDateSelected(_tempSelectedDate!);
                    Navigator.of(context).pop();
                  }
                },
                text: SetLocalizations.of(context).getText(
                  'goeidkfwk' /* 해당일자 선택 */,
                ),
                options: LodingButtonOptions(
                  height: 40.0,
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: AppColors.primaryBackground,
                  textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.Black),
                  elevation: 0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
