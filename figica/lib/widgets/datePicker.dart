import 'package:bottom_picker/bottom_picker.dart';
import 'package:fisica/index.dart';
import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const DatePickerWidget({Key? key, required this.onDateSelected}) : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? selectedDate;

  void _showDatePicker() {
    BottomPicker.date(
      title: "",
      titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
      onSubmit: (date) {
        setState(() {
          selectedDate = date;
          widget.onDateSelected(date);
          print(date); // For debugging, to see the selected date in the console
        });
      },
      onClose: () {
        print("Picker closed");
      },
      dismissable: true,
      height: 360,
      displayCloseIcon: false,
      buttonWidth: 300,
      buttonText: '선택',
      displayButtonIcon: false,
      buttonTextStyle: const TextStyle(color: Colors.white),
      buttonSingleColor: AppColors.Black,
      minDateTime: DateTime(1800, 1, 1),
      maxDateTime: DateTime(2021, 8, 2),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _showDatePicker,
      child: Text(
        selectedDate == null ? 'Select Date' : selectedDate.toString(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
