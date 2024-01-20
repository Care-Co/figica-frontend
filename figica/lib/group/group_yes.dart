import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:figica/index.dart';

// 다른 필요한 패키지들을 여기에 임포트하세요.

class GroupScreen2 extends StatefulWidget {
  final List<History> histories;
  const GroupScreen2({Key? key, required this.histories}) : super(key: key);
  @override
  _GroupScreenState2 createState() => _GroupScreenState2();
}

class _GroupScreenState2 extends State<GroupScreen2> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 21, 0),
                          child: Container(
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
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 21, 0),
                          child: Container(
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
                        ),
                      ],
                    ),
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
                height: 100,
                child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.histories.length,
                      itemBuilder: (context, index) {
                        print(widget.histories[index].shortDescription);

                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.Gray850,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          width: 232,
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
                                        widget.histories[index].name,
                                        style: AppFont.s18.overrides(fontSize: 16, color: AppColors.primaryBackground),
                                      ),
                                      Text(GroupApi.historytext(widget.histories[index].shortDescription),
                                          style: AppFont.r16.overrides(color: AppColors.primaryBackground)),
                                      // Text(widget.histories[index].shortDescription,
                                      //     style: AppFont.r16.overrides(color: AppColors.primaryBackground)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
            ],
          ),
        ),
      ),
    );
  }
}
