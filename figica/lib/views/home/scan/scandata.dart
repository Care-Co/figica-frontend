import 'package:fisica/models/FootData.dart';
import 'package:fisica/utils/service/Foot_Controller.dart';
import 'package:fisica/utils/TypeManager.dart';
import 'package:fisica/views/home/scan/switch.dart';
import 'package:flutter/material.dart';
import 'package:fisica/index.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ScanData extends StatefulWidget {
  final String mode;
  final FootData footdata;
  const ScanData({Key? key, required this.mode, required this.footdata}) : super(key: key);
  @override
  _ScanDataState createState() => _ScanDataState();
}

class _ScanDataState extends State<ScanData> {
  var data;
  List<ClassType> classTypes = [];
  List<Item> filteredItems = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  bool _isDescriptionShown = false;

  void _toggleDescription() {
    setState(() {
      _isDescriptionShown = !_isDescriptionShown;
    });
  }

  String gs(String code) {
    return SetLocalizations.of(context).getText(code);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    classTypes = [
      ClassType(
        type: 1,
        items: [
          Item(title: gs('PossibleConditions1a'), description: gs('PossibleConditionsScript1a')),
          Item(title: gs('PossibleConditions1b'), description: gs('PossibleConditionsScript1b')),
          Item(title: gs('PossibleConditions1c'), description: gs('PossibleConditionsScript1c')),
          Item(title: gs('PossibleConditions1d'), description: gs('PossibleConditionsScript1d')),
          Item(title: gs('PossibleConditions1e'), description: gs('PossibleConditionsScript1e')),
        ],
      ),
      ClassType(
        type: 2,
        items: [
          Item(title: gs('PossibleConditions2a'), description: gs('PossibleConditionsScript2a')),
          Item(title: gs('PossibleConditions2b'), description: gs('PossibleConditionsScript2b')),
          Item(title: gs('PossibleConditions2c'), description: gs('PossibleConditionsScript2c')),
          Item(title: gs('PossibleConditions2d'), description: gs('PossibleConditionsScript2d')),
          Item(title: gs('PossibleConditions2e'), description: gs('PossibleConditionsScript2e')),
        ],
      ),
      ClassType(
        type: 3,
        items: [
          Item(title: gs('PossibleConditions3a'), description: gs('PossibleConditionsScript3a')),
          Item(title: gs('PossibleConditions3b'), description: gs('PossibleConditionsScript3b')),
          Item(title: gs('PossibleConditions3c'), description: gs('PossibleConditionsScript3c')),
          Item(title: gs('PossibleConditions3d'), description: gs('PossibleConditionsScript3d')),
          Item(title: gs('PossibleConditions3e'), description: gs('PossibleConditionsScript3e')),
        ],
      ),
      ClassType(
        type: 4,
        items: [
          Item(title: gs('PossibleConditions4a'), description: gs('PossibleConditionsScript4a')),
          Item(title: gs('PossibleConditions4b'), description: gs('PossibleConditionsScript4b')),
          Item(title: gs('PossibleConditions4c'), description: gs('PossibleConditionsScript4c')),
          Item(title: gs('PossibleConditions4d'), description: gs('PossibleConditionsScript4d')),
          Item(title: gs('PossibleConditions4e'), description: gs('PossibleConditionsScript4e')),
        ],
      ),
      ClassType(
        type: 5,
        items: [
          Item(title: gs('PossibleConditions5a'), description: gs('PossibleConditionsScript5a')),
          Item(title: gs('PossibleConditions5b'), description: gs('PossibleConditionsScript5b')),
          Item(title: gs('PossibleConditions5c'), description: gs('PossibleConditionsScript5c')),
          Item(title: gs('PossibleConditions5d'), description: gs('PossibleConditionsScript5d')),
        ],
      ),
      ClassType(
        type: 6,
        items: [
          Item(title: gs('PossibleConditions5a'), description: gs('PossibleConditionsScript5a')),
          Item(title: gs('PossibleConditions5b'), description: gs('PossibleConditionsScript5b')),
          Item(title: gs('PossibleConditions5c'), description: gs('PossibleConditionsScript5c')),
          Item(title: gs('PossibleConditions5d'), description: gs('PossibleConditionsScript5d')),
        ],
      ),
      ClassType(
        type: 7,
        items: [
          Item(title: gs('PossibleConditions6a'), description: gs('PossibleConditionsScript6a')),
          Item(title: gs('PossibleConditions6b'), description: gs('PossibleConditionsScript6b')),
          Item(title: gs('PossibleConditions6c'), description: gs('PossibleConditionsScript6c')),
          Item(title: gs('PossibleConditions6d'), description: gs('PossibleConditionsScript6d')),
          Item(title: gs('PossibleConditions6e'), description: gs('PossibleConditionsScript6e')),
        ],
      ),
    ];

    if (widget.footdata.classType != 0) {
      filteredItems = classTypes.firstWhere((classType) => classType.type == widget.footdata.classType).items;
    }
    return Stack(
      children: [
        DraggableScrollableSheet(
          initialChildSize: 0.4, // 처음 표시될 때의 크기
          minChildSize: 0.4, // 최소 크기
          maxChildSize: 0.9, // 최대 크기
          builder: (BuildContext context, ScrollController scrollController) {
            return Consumer<AppStateNotifier>(builder: (context, AppStateNotifier, child) {
              final TypeManager typeManager = TypeManager();
              typeManager.setType(context, widget.footdata.classType);
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Container(width: 60, height: 4)],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 20),
                          child: Text(
                            typeManager.typeTitle,
                            style: AppFont.b24.overrides(fontSize: 20),
                          ),
                        ),
                        //확장 가능
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: AppColors.Gray100,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(SetLocalizations.of(context).getText('reportPlantarPressureDetailTypeLabel')),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                typeManager.type,
                                                style: AppFont.b24.overrides(fontSize: 20),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  _isDescriptionShown ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                                                  color: AppColors.Black,
                                                ),
                                                onPressed: _toggleDescription,
                                              ),
                                            ],
                                          ),
                                          if (_isDescriptionShown)
                                            Padding(
                                              padding: EdgeInsets.only(top: 12),
                                              child: Text(
                                                typeManager.typeScript,
                                                style: TextStyle(color: AppColors.Gray700),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    SetLocalizations.of(context).getText('reportPlantarPressureDetailSimilarityLabel'),
                                                    style: AppFont.s12,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 12),
                                                    child: Text(
                                                      (widget.footdata.accuracy.toString() ?? 'na') + '%',
                                                      style: AppFont.b24.overrides(fontSize: 20),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            child: VerticalDivider(
                                              thickness: 2,
                                              color: AppColors.primaryBackground,
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    SetLocalizations.of(context).getText('reportPlantarPressureDetailWeightLabel'),
                                                    style: AppFont.s12,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 12),
                                                    child: Text(
                                                      (widget.footdata.weight?.toString() ?? 'na') + 'kg',
                                                      style: AppFont.b24.overrides(fontSize: 20),
                                                    ),
                                                  )
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
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 20),
                          child: Text(
                            widget.footdata.classType != 0
                                ? SetLocalizations.of(context).getText('reportPlantarPressureDetailPainLabel' /* 이린 부외  */)
                                : SetLocalizations.of(context).getText('reportPlantarPressureNomalLabel' /* 이린 부외  */),
                            style: AppFont.b24.overrides(fontSize: 20, color: AppColors.Black),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              ToggleImageSwitch(
                                mode: 'main',
                                type: widget.footdata.classType,
                              ),
                            ],
                          ),
                        ),
                        if (widget.footdata.classType != 0) ...[
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 20),
                            child: Text(
                              SetLocalizations.of(context).getText('reportPlantarPressureDetailSymptomLabel' /* 이린 부외  */),
                              style: AppFont.b24.overrides(fontSize: 20, color: AppColors.Black),
                            ),
                          ),
                          _buildPossibleConditions(context)
                        ],

                        Container(
                          height: 140,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
          },
        ),
        if (widget.mode != 'histroy')
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
                  context.goNamed('Footprint', extra: 'main');
                },
                text: SetLocalizations.of(context).getText('reportPlantarPressureButtonRetryLabel'),
                options: LodingButtonOptions(
                  height: 40.0,
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: AppColors.primaryBackground,
                  textStyle: AppFont.s18.overrides(
                    fontSize: 16,
                    color: AppColors.Black,
                  ),
                  elevation: 0,
                  borderSide: BorderSide(
                    color: AppColors.Black,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPossibleConditions(BuildContext context) {
    return Container(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: filteredItems.length,
          itemBuilder: (context, index) {
            final item = filteredItems[index];

            return Row(
              children: [
                Container(
                  decoration: BoxDecoration(color: AppColors.Gray100, borderRadius: BorderRadius.all(Radius.circular(16))),
                  width: 180,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: AppFont.s18.overrides(color: AppColors.Black),
                        ),
                        Divider(
                          color: AppColors.primaryBackground,
                        ),
                        Container(
                          child: Text(
                            item.description,
                            style: AppFont.r16.overrides(color: AppColors.Gray500, fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                )
              ],
            );
          },
        ));
  }
}

class ClassType {
  final int type;
  final List<Item> items;

  ClassType({required this.type, required this.items});
}

class Item {
  final String title;
  final String description;

  Item({required this.title, required this.description});
}
