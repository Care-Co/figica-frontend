import 'package:fisica/index.dart';
import 'package:fisica/utils/service/Foot_Controller.dart';
import 'package:fisica/utils/TypeManager.dart';
import 'package:fisica/views/home/mypage/widgets/deleteList.dart';
import 'package:fisica/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FootList extends StatefulWidget {
  @override
  _FootListState createState() => _FootListState();
}

class _FootListState extends State<FootList> {
  String _selectedItem = 'new';
  List<String> selectedFootprints = [];
  List<String> allFootprints = [];
  bool isshow = false;

  void initState() {
    super.initState();
  }

  void showdelAllDialog(List<String> allFootprints) {
    showCustomDialog(
      context: context,
      checkButtonColor: AppColors.red,
      titleText: SetLocalizations.of(context).getText('popupDecideDeleteReportPlantarPressureAllLabel'),
      descriptionText: SetLocalizations.of(context).getText('popupDecideDeleteReportPlantarPressureAllDescription'),
      upperButtonText: SetLocalizations.of(context).getText('popupDecideDeleteReportPlantarPressureAllButtonConfirmLabel'),
      upperButtonFunction: () async {
        //todo 모든 리포트 삭제
        // for (String item in allFootprints) {
        //   FootprintApi.deleteSomePrint(item);
        // }
        showCustomSnackBar(context, SetLocalizations.of(context).getText('historyDeletePlantarPressureAllToast'));
        context.safePop();

        print(allFootprints);
      },
      lowerButtonText: SetLocalizations.of(context).getText('popupDecideDeleteReportPlantarPressureAllButtonCancelLabel'),
      /* 이전으로 돌아가기 */
    );
  }

  void showcheckbox() {
    setState(() {
      isshow = !isshow;
      print(isshow);
    });
  }

  void showdelSomeDialog(List<String> selectedFootprints) {
    showCustomDialog(
      context: context,
      checkButtonColor: AppColors.red,
      titleText: SetLocalizations.of(context).getText(
        'popupDecideDeleteReportPlantarPressureSelectedLabel',
        values: {
          'count': selectedFootprints.length.toString(),
        },
      ),
      descriptionText: SetLocalizations.of(context).getText('popupDecideDeleteReportPlantarPressureSelectedDescription'),
      upperButtonText: SetLocalizations.of(context).getText('popupDecideDeleteReportPlantarPressureSelectedButtonConfirmLabel'),
      upperButtonFunction: () async {
        //todo 선택한리포트 삭제
        for (String item in selectedFootprints) {
          FootprintApi.deleteSomePrint(item);
          showCustomSnackBar(context, SetLocalizations.of(context).getText('historyDeletePlantarPressureSelectedToast'));
        }
        context.safePop();
        print(selectedFootprints);
      },
      lowerButtonText: SetLocalizations.of(context).getText('popupDecideDeleteReportPlantarPressureSelectedButtonCancelLabel'),
    );
  }

  @override
  Widget build(BuildContext context) {
    Locale? locale = SetLocalizations.getStoredLocale();

    final Map<String, String> items = {
      'new': SetLocalizations.of(context).getText('groupSettingHistoryFilterSortNewLabel'),
      'old': SetLocalizations.of(context).getText('groupSettingHistoryFilterSortOldLabel'),
    };
    return Consumer<AppStateNotifier>(builder: (context, appStateNotifier, child) {
      allFootprints = appStateNotifier.footdata!.map((item) => item.footprintId).toList();

      return Stack(
        children: [
          Container(
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
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton<String>(
                          value: items[_selectedItem],
                          onChanged: (String? newValue) {
                            setState(() {
                              String value = items.keys.firstWhere((element) => items[element] == newValue);
                              if (value == 'new') {
                                _selectedItem = 'new';
                              } else if (value == 'old') {
                                _selectedItem = 'old';
                              }
                              appStateNotifier.sortfootdata(_selectedItem); // 데이터 정렬 함수
                            });
                          },
                          underline: Container(),
                          icon: Icon(Icons.keyboard_arrow_down_rounded),
                          items: items.values.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: AppFont.s12.overrides(fontSize: 18),
                              ),
                            );
                          }).toList(),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.more_horiz,
                            color: AppColors.Black,
                          ),
                          onPressed: () async {
                            showAlignedDialog(
                              context: context,
                              isGlobal: true,
                              avoidOverflow: false,
                              targetAnchor: AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
                              followerAnchor: AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
                              builder: (dialogContext) {
                                return Material(
                                  color: Colors.transparent,
                                  child: GestureDetector(
                                    child: Container(
                                      height: 96,
                                      width: 200,
                                      child: DeleteOptionsWidget(
                                        onshow: () => showcheckbox(),
                                        onDeleteAll: () => showdelAllDialog(allFootprints), // 함수 호출이 아닌 함수 참조 전달
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: appStateNotifier.footdata!.length,
                      itemBuilder: (context, index) {
                        final TypeManager typeManager = TypeManager();

                        final item = appStateNotifier.footdata![index];
                        final isChecked = selectedFootprints.contains(item.footprintId);
                        typeManager.setType(context, item.classType);

                        return Container(
                          height: 242,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      SetLocalizations.of(context).getText(
                                        'historyPlantarPressureDetailDateLabel',
                                        values: {'date': DateFormat('yyyy.MM.dd').format(item.measuredDate)},
                                      ),
                                      style: AppFont.s12.overrides(fontSize: 18, color: AppColors.Black),
                                    ),
                                    if (isshow)
                                      Theme(
                                        data: ThemeData(
                                          checkboxTheme: CheckboxThemeData(
                                            visualDensity: VisualDensity.compact,
                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12.0),
                                            ),
                                          ),
                                          unselectedWidgetColor: AppColors.Gray200,
                                        ),
                                        child: Checkbox(
                                          value: isChecked,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (value == true) {
                                                selectedFootprints.add(item.footprintId);
                                              } else {
                                                selectedFootprints.remove(item.footprintId);
                                              }
                                            });
                                          },
                                          activeColor: AppColors.Black,
                                          checkColor: AppColors.primaryBackground,
                                        ),
                                      ),
                                  ],
                                ),
                                Text(
                                  SetLocalizations.of(context).getText(
                                    'historyPlantarPressureDetailTimeLabel',
                                    values: {
                                      'time': DateFormat(
                                              'a hh:mm', (locale?.languageCode == null) ? 'ko_KR' : '${locale!.languageCode}_${locale.countryCode}')
                                          .format(item.measuredTime)
                                    },
                                  ),
                                  style: AppFont.r16.overrides(fontSize: 12, color: AppColors.Gray500),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                                  child: Container(
                                    height: 153,
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
                                                  SetLocalizations.of(context).getText('historyPlantarPressureDetailTypeLabel'),
                                                  style: AppFont.s12.overrides(color: AppColors.Gray500),
                                                ),
                                                SizedBox(height: 2),
                                                Text(
                                                  typeManager.type,
                                                  style: AppFont.b24.overrides(fontSize: 20, color: AppColors.Black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          height: 1.0,
                                          thickness: 1.0,
                                          color: AppColors.primaryBackground,
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
                                                        SetLocalizations.of(context).getText('historyPlantarPressureDetailSimilarityLabel'),
                                                        style: AppFont.s12.overrides(color: AppColors.Gray500),
                                                      ),
                                                      Text(
                                                        '${item.accuracy}%',
                                                        style: AppFont.b24.overrides(fontSize: 20, color: AppColors.Black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              VerticalDivider(
                                                width: 1.0,
                                                thickness: 1.0,
                                                color: AppColors.primaryBackground,
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        SetLocalizations.of(context).getText('historyPlantarPressureDetailWeightLabel'),
                                                        style: AppFont.s12.overrides(color: AppColors.Gray500),
                                                      ),
                                                      Text(
                                                        '${item.weight}kg',
                                                        style: AppFont.b24.overrides(fontSize: 20, color: AppColors.Black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(color: AppColors.Gray100),
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
          if (isshow)
            Positioned(
              right: 20,
              bottom: 60,
              child: Container(
                width: 327,
                height: 56.0,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(1), // 흰색 그림자, 투명도 조절 가능
                      spreadRadius: 82, // 그림자의 범위를 넓힘
                      blurRadius: 15, // 그림자의 흐릿함 정도
                      offset: Offset(0, 50), // 그림자의 방향 (x, y)
                    ),
                  ],
                ),
                child: LodingButtonWidget(
                  onPressed: () async {
                    selectedFootprints.isEmpty ? null : showdelSomeDialog(selectedFootprints);
                  },
                  text: SetLocalizations.of(context).getText('historyButtonDeleteLabel'),
                  options: LodingButtonOptions(
                    height: 40.0,
                    padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: selectedFootprints.isEmpty ? AppColors.Gray200 : AppColors.Black,
                    textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.primaryBackground),
                    elevation: 0,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
