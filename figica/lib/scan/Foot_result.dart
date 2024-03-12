import 'dart:convert';

import 'package:figica/scan/scandata.dart';
import 'package:figica/scan/Foot_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:figica/index.dart';

class FootResult extends StatefulWidget {
  const FootResult({Key? key}) : super(key: key);

  @override
  State<FootResult> createState() => _FootResultState();
}

class _FootResultState extends State<FootResult> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var data;
  final DraggableScrollableController _controller = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    getData();
    showModalBottomSheetWithStates(context);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getData() async {
    var tempData = await FootprintData.getDataFromSharedPreferences();
    print(tempData);
    data = tempData;
  }

  Future<void> showModalBottomSheetWithStates(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (context) => ScanData(),
    );
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
        backgroundColor: AppColors.Black,
        appBar: AppBar(
          backgroundColor: Color(0x00CCFF8B),
          automaticallyImplyLeading: false,
          title: Text(
            SetLocalizations.of(context).getText(
              'xcmrjdju' /* Page Title */,
            ),
            style: AppFont.s18,
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.cancel,
                size: 20,
              ),
              onPressed: () {
                context.pop();
              },
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: FutureBuilder(
          future: getData(), // 비동기 데이터 로드 함수
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("데이터 로딩 중 에러 발생"));
            }
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 327,
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Image.network(
                    data['data']['url'],
                    width: 327,
                    fit: BoxFit.contain,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 56.0,
                        decoration: BoxDecoration(),
                        child: LodingButtonWidget(
                          onPressed: () {
                            showModalBottomSheetWithStates(context);
                          },
                          text: '리포트 상세 내용 보기',
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
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: double.infinity,
                        height: 56.0,
                        decoration: BoxDecoration(),
                        child: LodingButtonWidget(
                          onPressed: () {
                            context.goNamed('Footprint');
                          },
                          text: '다시 측정하기',
                          options: LodingButtonOptions(
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                            color: AppColors.Black,
                            textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.primaryBackground),
                            elevation: 0,
                            borderSide: BorderSide(
                              color: AppColors.primaryBackground,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
