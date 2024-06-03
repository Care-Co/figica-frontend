import 'package:fisica/utils/fisica_theme.dart';
import 'package:fisica/utils/form_field_controller.dart';
import 'package:fisica/utils/internationalization.dart';
import 'package:fisica/widgets/flutter_drop_down.dart';
import 'package:flutter/material.dart';

class AddSchedulePage extends StatefulWidget {
  @override
  _AddSchedulePageState createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _memoController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay endTime = TimeOfDay(hour: 0, minute: 0);
  String repeat = '반복 없음';
  String repeatPeriod = '없음';
  String location = '미등록';
  String notification = '정각 알림';
  String measurementType = '측정안 분석';

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _selectTime(bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? startTime : endTime,
    );
    if (picked != null && picked != (isStartTime ? startTime : endTime)) {
      setState(() {
        if (isStartTime) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  void _showBottomSheet(List<String> options, String selected, Function(String) onSelected) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: AppColors.Gray850,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...options.map((option) => RadioListTile<String>(
                    title: Text(
                      (option), // 옵션 텍스트
                      style: AppFont.s18.overrides(color: AppColors.primaryBackground),
                    ),
                    value: option,
                    groupValue: selected,
                    onChanged: (value) {
                      onSelected(value!);
                      Navigator.pop(context);
                    },
                  )),
              Container(
                color: AppColors.primary,
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    ('선택'), // 선택 버튼
                    style: AppFont.s18.overrides(color: AppColors.primaryBackground),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildForm() {
    switch (dropDownValue) {
      case '약복용':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('복용약', _titleController, 'textholder'),
            SizedBox(height: 16),
            _buildDateField(),
            _buildTimeFields(),
            _buildRepeatField(),
            _buildRepeatPeriodField(),
            _buildLocationField(),
            _buildNotificationField(),
            _buildSubmitButton(),
          ],
        );
      case '운동':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('일정명', _titleController, 'textholder'),
            SizedBox(height: 16),
            _buildDateField(),
            _buildTimeFields(),
            _buildRepeatField(),
            _buildRepeatPeriodField(),
            _buildLocationField(),
            _buildNotificationField(),
            _buildSubmitButton(),
          ],
        );
      case '측정하기':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('측정명', _titleController, 'textholder'),
            SizedBox(height: 16),
            _buildDropdownField('측정종류', measurementType, ['측정안 분석', '체중', 'Vision 분석', '기타'], (value) {
              setState(() {
                measurementType = value;
              });
            }),
            _buildDateField(),
            _buildTimeFields(),
            _buildRepeatField(),
            _buildRepeatPeriodField(),
            _buildNotificationField(),
            _buildMemoField(),
            _buildSubmitButton(),
          ],
        );
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('일정명', _titleController, 'textholder'),
            SizedBox(height: 16),
            _buildDateField(),
            _buildTimeFields(),
            _buildRepeatField(),
            _buildRepeatPeriodField(),
            _buildLocationField(),
            _buildNotificationField(),
            _buildSubmitButton(),
          ],
        );
    }
  }

  Widget _buildTextField(String label, TextEditingController controller, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppFont.s12.overrides(color: AppColors.Gray700)),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, String value, List<String> options, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        DropdownButton<String>(
          value: value,
          onChanged: (String? newValue) {
            onChanged(newValue!);
          },
          items: options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return GestureDetector(
      onTap: _selectDate,
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${selectedDate.year}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.day.toString().padLeft(2, '0')}'),
            Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeFields() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _selectTime(true),
            child: Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(startTime.format(context)),
                  Icon(Icons.access_time),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () => _selectTime(false),
            child: Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(endTime.format(context)),
                  Icon(Icons.access_time),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRepeatField() {
    return GestureDetector(
      onTap: () {
        _showBottomSheet(
          ['반복 없음', '매일', '매주', '매월', '매년'],
          repeat,
          (value) {
            setState(() {
              repeat = value;
            });
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(repeat),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }

  Widget _buildRepeatPeriodField() {
    return GestureDetector(
      onTap: () {
        _showBottomSheet(
          ['없음', '1주일', '2주일', '1개월', '3개월', '6개월', '1년'],
          repeatPeriod,
          (value) {
            setState(() {
              repeatPeriod = value;
            });
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(repeatPeriod),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationField() {
    return GestureDetector(
      onTap: () {
        _showBottomSheet(
          ['정각 알림', '10분 전 알림', '30분 전 알림', '1시간 전 알림'],
          notification,
          (value) {
            setState(() {
              notification = value;
            });
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              (notification), // 선택된 알림 텍스트 표시
              style: AppFont.s18.overrides(color: AppColors.primaryBackground),
            ),
            Icon(Icons.notifications),
          ],
        ),
      ),
    );
  }

  Widget _buildMemoField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ('메모'), // 메모
          style: AppFont.s18.overrides(color: AppColors.primaryBackground),
        ),
        TextField(
          controller: _memoController,
          decoration: InputDecoration(
            hintText: ('메모를 입력하세요'), // 메모를 입력하세요
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        // 등록하기 로직
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 48),
      ),
      child: Text(
        ('등록하기'), // 등록하기
        style: AppFont.s18.overrides(color: AppColors.primaryBackground),
      ),
    );
  }

  Widget _buildLocationField() {
    return GestureDetector(
      onTap: () {
        // 위치 선택 로직을 여기에 추가합니다.
      },
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              (location), // 미등록
              style: AppFont.s18.overrides(color: AppColors.primaryBackground),
            ),
            Icon(Icons.location_on),
          ],
        ),
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('일정 등록'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ('종류'), // 종류
              style: AppFont.s12.overrides(color: AppColors.Black),
            ),
            SizedBox(height: 8),
            FlutterDropDown<String>(
              controller: dropDownValueController ??= FormFieldController<String>(null),
              options: ['운동', '약복용', '병원', '측정하기', '기타'],
              onChanged: (value) async {
                print('value  = $value');
                setState(() {
                  dropDownValue = value!;
                  print(dropDownValue);
                });
              },
              width: double.infinity,
              height: 38.0,
              textStyle: AppFont.r16.overrides(color: AppColors.Gray500),
              elevation: 2,
              borderColor: AppColors.Gray200,
              borderWidth: 1.0,
              borderRadius: 8.0,
              borderStyle: 'all',
              margin: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
              hidesUnderline: true,
              isSearchable: false,
              isMultiSelect: false,
            ),
            SizedBox(height: 16),
            _buildForm(),
          ],
        ),
      ),
    );
  }
}
