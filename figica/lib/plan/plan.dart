import '../flutter_set/App_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fisica/index.dart';

class planWidget extends StatefulWidget {
  const planWidget({Key? key}) : super(key: key);

  @override
  _planWidgetState createState() => _planWidgetState();
}

class _planWidgetState extends State<planWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future? _loadDataFuture;

  @override
  void initState() {
    super.initState();
    //_loadDataFuture = getdata();
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
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.primaryBackground,
        appBar: AppBar(
          backgroundColor: Color(0x00CCFF8B),
          automaticallyImplyLeading: false,
          leading: AppIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text('plan'),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // TableCalendar(
              //   headerVisible: false,
              //   firstDay: DateTime.utc(2010, 1, 1),
              //   lastDay: DateTime.utc(2030, 12, 31),
              //   focusedDay: _focusedDay,
              //   selectedDayPredicate: (day) => isSameDay(_tempSelectedDate, day),
              //   onDaySelected: (selectedDay, focusedDay) {
              //     if (widget.timeData.any((date) => isSameDay(date, selectedDay))) {
              //       setState(() {
              //         _tempSelectedDate = selectedDay;
              //       });
              //     }
              //   },
              //   calendarStyle: CalendarStyle(),
              //   calendarBuilders: CalendarBuilders(
              //     defaultBuilder: (context, day, focusedDay) {
              //       for (DateTime date in widget.timeData) {
              //         if (isSameDay(date, day)) {
              //           return Container(
              //             margin: const EdgeInsets.all(4.0),
              //             alignment: Alignment.center,
              //             decoration: BoxDecoration(
              //               color: AppColors.Black,
              //               borderRadius: BorderRadius.circular(8),
              //             ),
              //             child: Text(
              //               day.day.toString(),
              //               style: AppFont.s18.overrides(color: AppColors.Gray100),
              //             ),
              //           );
              //         }
              //       }
              //       return Container(
              //         margin: const EdgeInsets.all(4.0),
              //         alignment: Alignment.center,
              //         decoration: BoxDecoration(
              //           color: AppColors.Black,
              //           borderRadius: BorderRadius.circular(8),
              //         ),
              //         child: Text(
              //           day.day.toString(),
              //           style: AppFont.s18.overrides(color: AppColors.Gray700),
              //         ),
              //       );
              //     },
              //     outsideBuilder: (context, day, focusedDay) {
              //       for (DateTime date in widget.timeData) {
              //         if (isSameDay(date, day)) {
              //           return Container(
              //             margin: const EdgeInsets.all(4.0),
              //             alignment: Alignment.center,
              //             decoration: BoxDecoration(
              //               color: AppColors.Black,
              //               borderRadius: BorderRadius.circular(8),
              //             ),
              //             child: Text(
              //               day.day.toString(),
              //               style: AppFont.s18.overrides(color: AppColors.Gray100),
              //             ),
              //           );
              //         }
              //       }
              //       return Container(
              //         margin: const EdgeInsets.all(4.0),
              //         alignment: Alignment.center,
              //         decoration: BoxDecoration(
              //           color: AppColors.Gray850,
              //           borderRadius: BorderRadius.circular(8),
              //         ),
              //         child: Text(
              //           day.day.toString(),
              //           style: AppFont.s18.overrides(color: AppColors.Gray700),
              //         ),
              //       );
              //     },
              //     todayBuilder: (context, day, focusedDay) {
              //       for (DateTime date in widget.timeData) {
              //         if (isSameDay(date, day)) {
              //           return Container(
              //             margin: const EdgeInsets.all(4.0),
              //             alignment: Alignment.center,
              //             decoration: BoxDecoration(
              //               color: AppColors.Black,
              //               borderRadius: BorderRadius.circular(8),
              //             ),
              //             child: Text(
              //               day.day.toString(),
              //               style: AppFont.s18.overrides(color: AppColors.Gray100),
              //             ),
              //           );
              //         }
              //       }
              //       return Container(
              //         margin: const EdgeInsets.all(4.0),
              //         alignment: Alignment.center,
              //         decoration: BoxDecoration(
              //           color: AppColors.Black,
              //           borderRadius: BorderRadius.circular(8),
              //         ),
              //         child: Text(
              //           day.day.toString(),
              //           style: AppFont.s18.overrides(color: AppColors.Gray700),
              //         ),
              //       );
              //     },
              //     selectedBuilder: (context, day, focusedDay) {
              //       return Container(
              //         margin: const EdgeInsets.all(4.0),
              //         alignment: Alignment.center,
              //         decoration: BoxDecoration(
              //           color: AppColors.Black,
              //           borderRadius: BorderRadius.circular(8),
              //           border: Border.all(color: AppColors.primary),
              //         ),
              //         child: Text(
              //           day.day.toString(),
              //           style: AppFont.s18.overrides(color: AppColors.primary),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
