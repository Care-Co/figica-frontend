import 'package:fisica/scan/Foot_Controller.dart';
import 'package:fisica/scan/switch.dart';
import 'package:flutter/material.dart';
import 'package:fisica/index.dart';

class ScanData extends StatefulWidget {
  final String mode;
  const ScanData({Key? key, required this.mode}) : super(key: key);
  @override
  _ScanDataState createState() => _ScanDataState();
}

// StatefulWidget의 상태를 관리하는 클래스
class _ScanDataState extends State<ScanData> {
  var data;
  String type = '';
  String typetitle = '';
  String typeScript = '';
  bool main = true;

  @override
  void initState() {
    super.initState();
    getData();
    if (widget.mode != 'main') {
      main = false;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  bool _isDescriptionShown = false;

  void _toggleDescription() {
    setState(() {
      _isDescriptionShown = !_isDescriptionShown;
    });
  }

  Future<void> getData() async {
    var tempData = await DataController.get_apiData();
    print(tempData);
    data = tempData;
    settype(main ? tempData['classType'] : tempData['footprintClassType']);
  }

  void settype(int typeint) {
    switch (typeint) {
      case 0:
        type = '정상발';
        typetitle = '좋은 자세를 유지하고 있습니다.\n꾸준히 관리해주세요';
        typeScript = '평평하지도 너무 높지도 않은 정상적인 발의 상태입니다.꾸준히 관리하여 좋은 자세를 유지해주세요.';
        break;
      case 1:
        type = '요족';
        typetitle = '평소에 바른 자세를 유지하기 위해 관심을 기울여 주세요.';
        typeScript = '요족은 발등이 정상보다 높이 올라오는 상태로, 발바닥의 아치가 높아 옆에서 보면 발바닥이 위로 볼록하게 올라간 상태를 말합니다. 발의 모양 변형이나 종아리 근육 경직 등의 증상을 동반할 수 있습니다.';

        break;
      case 2:
        type = '평발';
        typetitle = '평소에 바른 자세를 유지하기 위해 관심을 기울여 주세요.';
        typeScript =
            '평발은 발바닥의 안쪽 아치가 비정상적으로 낮아지거나 소실되는 변형으로, 외관 상 발 안쪽 아치가 소실되고 발 뒤꿈치가 바깥쪽으로 기울어지게 된 상태를 말합니다. 신발 안쪽이 주로 닳으며 장시간 보행 및 운동 시 통증을 느낄 수 있습니다.';

        break;
      case 3:
        type = '척추 전만증';
        typetitle = '의료기관에 방문해 전문가와 상담을 권합니다';
        typeScript = '허리뼈(요추)의 전만각이 병적으로 증가된 상태입니다. 전만이란 옆에서 보았을 때 앞으로 밀려 나간 것을 의미하며, 상체를 뒤로 젖히는 자세가 된 상태를 말합니다.';

        break;
      case 4:
        type = '척추 후만증';
        typetitle = '의료기관에 방문해 전문가와 상담을 권합니다';
        typeScript = '척추의 가슴쪽 흉추부와 엉덩이쪽 천추부가 뒤로 휜 모양을 나타내며 후만 변형이 보이는 상태로, 뒤로 볼록한 커브가 증가한 상태를 말합니다.';

        break;
      case 5:
        type = '척추 좌 측만증';
        typetitle = '의료기관에 방문해 전문가와 상담을 권합니다';
        typeScript = '척추 측만증은 척추가 정면에서 보았을 때 옆으로 휜 것을 지칭하나, 실제로는 단순한 2차원적 변형이 아니라 척추뼈의 회전이 동반되어 측면도 정상적인 만곡 상태가 아닌 3차원적 변형이 이루어진 상태입니다.';

        break;
      case 6:
        type = '척추 우 측만증';
        typetitle = '의료기관에 방문해 전문가와 상담을 권합니다';
        typeScript = '척추 측만증은 척추가 정면에서 보았을 때 옆으로 휜 것을 지칭하나, 실제로는 단순한 2차원적 변형이 아니라 척추뼈의 회전이 동반되어 측면도 정상적인 만곡 상태가 아닌 3차원적 변형이 이루어진 상태입니다.';

        break;
      case 7:
        type = '골반 비틀림';
        typetitle = '의료기관에 방문해 전문가와 상담을 권합니다';
        typeScript = '골반이 좌우 비대칭하게 되거나 뒤틀린 경우 척추에도 영향을 주어 척추가 휘거나 틀어지게 되는 증상입니다. 골반이 틀어진 경우, 골반 높이의 차이로 인해 양쪽 다리 길이가 달라지고 통증이 발생할 수 있습니다.';
        break;
      default:
        type = '알 수 없는 상태';
        typetitle = '의료기관에 방문해 전문가와 상담을 권합니다';
        typeScript = '평평하지도 너무 높지도 않은 정상적인 발의 상태입니다. 꾸준히 관리하여 좋은 자세를 유지해주세요.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DraggableScrollableSheet(
          initialChildSize: 0.4, // 처음 표시될 때의 크기
          minChildSize: 0.4, // 최소 크기
          maxChildSize: 0.9, // 최대 크기
          builder: (BuildContext context, ScrollController scrollController) {
            return FutureBuilder(
                future: getData(), // 비동기 데이터 로딩
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("데이터 로딩 중 에러 발생"));
                  }
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
                                typetitle,
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
                                              Text('유형'),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    type,
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
                                                    typeScript,
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
                                                        '유사도',
                                                        style: AppFont.s12,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 12),
                                                        child: Text(
                                                          main ? data['accuracy'].toString() + '%' : data['footprintAccuracy'].toString() + '%',
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
                                                        '체중',
                                                        style: AppFont.s12,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 12),
                                                        child: Text(
                                                          main ? data['weight'].toString() + 'kg' : data['footprintWeight'].toString() + 'kg',
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
                                SetLocalizations.of(context).getText('qkfw' /* 서비스 이용약관  */),
                                style: AppFont.b24.overrides(fontSize: 20),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  ToggleImageSwitch(
                                    mode: widget.mode,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: Container(
            width: 327,
            height: 56.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(1), // 흰색 그림자, 투명도 조절 가능
                  spreadRadius: 32, // 그림자의 범위를 넓힘
                  blurRadius: 15, // 그림자의 흐릿함 정도
                  offset: Offset(0, 2), // 그림자의 방향 (x, y)
                ),
              ],
            ),
            child: LodingButtonWidget(
              onPressed: () async {
                main ? context.goNamed('Footprint', extra: 'main') : context.goNamed('testFootprint', extra: 'tester');
              },
              text: '다시 측정하기',
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
}
