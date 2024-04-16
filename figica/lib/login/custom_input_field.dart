import 'package:fisica/flutter_set/fisica_theme.dart';
import 'package:fisica/flutter_set/flutter_drop_down.dart';
import 'package:fisica/flutter_set/form_field_controller.dart';
import 'package:fisica/flutter_set/internationalization.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onStatusChanged;
  final Function(String) onSelected;

  CustomInputField({Key? key, required this.controller, required this.onStatusChanged, required this.onSelected}) : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  FormFieldController<String>? dropDownValueController2;
  String? selectedDropdownValue = '+82';

  String inputType = 'none';

  TextInputType keyboardType = TextInputType.text;

  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode noneFocusNode = FocusNode();

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '이메일을 입력해주세요.';
    } else if (!value.contains('@')) {
      return SetLocalizations.of(context).getText(
        '8u5gojh7' /* @를 포함한 정확한 이메일을 입력해 주세요 */,
      );
    }
    return null; // 유효한 경우 null을 반환
  }

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '전화번호를 입력해주세요.';
    } else if (!value.startsWith('010')) {
      return SetLocalizations.of(context).getText(
        '8u5gojhdg' /* 010 */,
      );
    }
    return null;
  }

  void _onTextChanged() {
    String input = widget.controller.text;
    String newInputType = 'none';
    TextInputType newKeyboardType = TextInputType.text;

    if (input.length >= 2) {
      if (isNumeric(input.substring(0, 2))) {
        newInputType = 'phone';
        newKeyboardType = TextInputType.phone;
      } else if (isAlphabet(input.substring(0, 2))) {
        newInputType = 'email';
        newKeyboardType = TextInputType.emailAddress;
      }
    }

    if (newInputType != inputType) {
      setState(() {
        inputType = newInputType;
        keyboardType = newKeyboardType;
      });

      // 프레임 렌더링 후 키보드 업데이트
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateKeyboard(inputType);
      });
    }
    widget.onStatusChanged(inputType);
  }

  void _updateKeyboard(String inputType) {
    if (inputType == 'email') {
      FocusScope.of(context).requestFocus(emailFocusNode);
    } else if (inputType == 'phone') {
      FocusScope.of(context).requestFocus(phoneFocusNode);
    } else {
      FocusScope.of(context).requestFocus(noneFocusNode);
    }
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  bool isAlphabet(String s) {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(s);
  }

  @override
  Widget build(BuildContext context) {
    switch (inputType) {
      case 'none':
        return TextFormField(
          controller: widget.controller,
          focusNode: noneFocusNode,
          decoration: InputDecoration(
            hintText: SetLocalizations.of(context).getText(
              'n7oaur8tc',
            ),
            hintStyle: AppFont.r16.overrides(color: AppColors.Gray300),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.Gray200,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.Gray200,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.Gray200,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.Gray200,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            suffixIcon: widget.controller.text.isNotEmpty
                ? InkWell(
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: AppColors.Gray100, // 연한 회색 배경
                        shape: BoxShape.circle,
                      ),
                      margin: EdgeInsets.all(14),
                      child: Icon(
                        Icons.clear, // 취소 아이콘 사용
                        color: AppColors.Gray500, size: 10,
                      ),
                    ),
                    onTap: () {
                      widget.controller.clear();
                    },
                  )
                : null,
          ),
          style: AppFont.r16.overrides(color: AppColors.Gray700),
          keyboardType: keyboardType,
        );
      case 'email':
        return TextFormField(
          controller: widget.controller,
          focusNode: emailFocusNode,
          autofocus: false,
          decoration: InputDecoration(
            labelStyle: AppFont.r16.overrides(color: AppColors.Gray500),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.Gray200,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.Gray200,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.Gray200,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.Gray200,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            suffixIcon: widget.controller.text.isNotEmpty
                ? InkWell(
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: AppColors.Gray100, // 연한 회색 배경
                        shape: BoxShape.circle,
                      ),
                      margin: EdgeInsets.all(14),
                      child: Icon(
                        Icons.clear, // 취소 아이콘 사용
                        color: AppColors.Gray500, size: 10,
                      ),
                    ),
                    onTap: () {
                      widget.controller.clear();
                    },
                  )
                : null,
            errorText: emailValidator(widget.controller.text),
          ),
          style: AppFont.r16.overrides(color: AppColors.Gray700),
          keyboardType: keyboardType,
          validator: emailValidator,
        );
      // 이메일 필드 구성
      case 'phone':
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10.5, 0, 0),
                child: Column(
                  children: [
                    FlutterDropDown<String>(
                      controller: dropDownValueController2 ??= FormFieldController<String>("+82"),
                      hintText: '+82',
                      options: ['+1', '+91', '+82', '+81'],
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedDropdownValue = newValue ?? '+82';
                        });
                        widget.onSelected(selectedDropdownValue!);
                      },
                      height: 38.0,
                      textStyle: AppFont.r16.overrides(color: AppColors.Gray500),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.Gray500,
                        size: 20.0,
                      ),
                      elevation: 2.0,
                      borderColor: AppColors.Gray200,
                      borderWidth: 1.0,
                      borderRadius: 8.0,
                      borderStyle: 'bottom',
                      margin: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 4.0),
                      hidesUnderline: true,
                      isSearchable: false,
                      isMultiSelect: false,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextFormField(
                  controller: widget.controller,
                  focusNode: phoneFocusNode,
                  decoration: InputDecoration(
                    labelStyle: AppFont.r16,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.Gray200,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.Gray200,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.Gray200,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.Gray200,
                        width: 1.0,
                      ),
                    ),
                    suffixIcon: widget.controller.text.isNotEmpty
                        ? InkWell(
                            child: Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                color: AppColors.Gray100, // 연한 회색 배경
                                shape: BoxShape.circle,
                              ),
                              margin: EdgeInsets.all(14),
                              child: Icon(
                                Icons.clear, // 취소 아이콘 사용
                                color: AppColors.Gray500, size: 10,
                              ),
                            ),
                            onTap: () {
                              widget.controller.clear();
                            },
                          )
                        : null,
                    errorText: phoneValidator(widget.controller.text),
                  ),
                  style: AppFont.r16.overrides(color: AppColors.Gray700),
                  keyboardType: keyboardType,
                  validator: phoneValidator),
            ),
          ],
        );
      // 전화번호 필드 구성
      default:
        return Container(); // 기본값
    }
  }
}
