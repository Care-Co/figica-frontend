import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:figica/index.dart';

// 다른 필요한 패키지들을 여기에 임포트하세요.

class YesgroupScreen extends StatefulWidget {
  final String authority;
  final String data;
  const YesgroupScreen({Key? key, required this.authority, required this.data}) : super(key: key);
  @override
  _YesgroupScreenState createState() => _YesgroupScreenState();
}

class _YesgroupScreenState extends State<YesgroupScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<History> histories = [];
  List<GroupMember> groupMember = [];
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    initGroupData();
  }

  @override
  void didUpdateWidget(YesgroupScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data) {
      // 부모 위젯에서 전달된 authority가 변경되었을 때 initGroupData를 실행
      initGroupData();
    }
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> initGroupData() async {
    var groupData = await GroupApi.getGroup();
    print("test");
    setState(() {
      histories = History.parseHistories(groupData!);
      groupMember = GroupMember.parseGroupMember(groupData);
      print(groupMember);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.Black,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 88,
                decoration: BoxDecoration(
                  color: AppColors.Gray850,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: groupMember.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 18, 0),
                          child: Column(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                  'https://picsum.photos/seed/279/600',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                groupMember[index].name,
                                style: AppFont.r16.overrides(fontSize: 10, color: AppColors.primaryBackground),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      SetLocalizations.of(context).getText(
                        'ngpljxdi' /* Hello World */,
                      ),
                      style: AppFont.s18.overrides(color: AppColors.Gray100),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.primaryBackground,
                      size: 18,
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 88,
                child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    child: Scrollbar(
                      thumbVisibility: true, // 스크롤바를 항상 보이게 설정
                      thickness: 4.0, // 스크롤바의 두께
                      radius: Radius.circular(10),
                      controller: _scrollController,

                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: histories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 12, 12),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.Gray850,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              width: 232,
                              height: 76,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        'https://picsum.photos/seed/279/600',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 13),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            histories[index].name,
                                            style: AppFont.s18.overrides(fontSize: 16, color: AppColors.primaryBackground),
                                          ),
                                          Text(GroupApi.historytext(histories[index].shortDescription),
                                              style: AppFont.r16.overrides(fontSize: 12, color: AppColors.primaryBackground)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      SetLocalizations.of(context).getText(
                        'rmfnqfdlfwjd' /* Hello World */,
                      ),
                      style: AppFont.s18.overrides(color: AppColors.Gray100),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.primaryBackground,
                      size: 18,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
