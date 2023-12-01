import 'package:figica/flutter_set/figica_theme.dart';

import '../flutter_set/App_icon_button.dart';
import '../flutter_set/flutter_flow_theme.dart';
import '../flutter_set/flutter_flow_util.dart';
import '../flutter_set/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'group_model.dart';
export 'group_model.dart';

class groupWidget extends StatefulWidget {
  const groupWidget({Key? key}) : super(key: key);

  @override
  _groupWidgetState createState() => _groupWidgetState();
}

class _groupWidgetState extends State<groupWidget> {
  late ScanpageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScanpageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

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
      onTap: () => _model.unfocusNode.canRequestFocus ? FocusScope.of(context).requestFocus(_model.unfocusNode) : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.Black,
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
              color: AppColors.primaryBackground,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
              SetLocalizations.of(context).getText(
                'ze1uteze' /* 그룹   */,
              ),
              style: AppFont.s18.overrides(color: AppColors.primaryBackground)),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 42, 0, 123),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: AppColors.Gray850,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                    child: Text(
                                        SetLocalizations.of(context).getText(
                                          'ckadue1uteze' /* 그룹이 없네요! */,
                                        ),
                                        style: AppFont.s18.overrides(fontSize: 16, color: AppColors.primaryBackground)),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                                    child: Text(
                                        SetLocalizations.of(context).getText(
                                          'ckadurmfnqteze' /* 를 공유할 수 있 */,
                                        ),
                                        style: AppFont.r16.overrides(fontSize: 12, color: AppColors.Gray300)),
                                  ),
                                ],
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: InkWell(
                          onTap: () {
                            context.pushNamed('groupCreate');
                          },
                          child: Container(
                            height: 232,
                            decoration: BoxDecoration(
                              color: AppColors.Gray850,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Container(
                          height: 232,
                          decoration: BoxDecoration(
                            color: AppColors.Gray850,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
