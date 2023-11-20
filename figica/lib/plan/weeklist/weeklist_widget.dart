import '../../flutter_set/flutter_flow_theme.dart';
import '../../flutter_set/flutter_flow_util.dart';
import '../../flutter_set/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'weeklist_model.dart';
export 'weeklist_model.dart';

class WeeklistWidget extends StatefulWidget {
  const WeeklistWidget({Key? key}) : super(key: key);

  @override
  _WeeklistWidgetState createState() => _WeeklistWidgetState();
}

class _WeeklistWidgetState extends State<WeeklistWidget> {
  late WeeklistModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WeeklistModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF2F3135),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 24.0, 0.0),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                Theme(
                  data: ThemeData(
                    checkboxTheme: CheckboxThemeData(
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                  ),
                  child: CheckboxListTile(
                    value: _model.checkboxListTileValue1 ??= false,
                    onChanged: (newValue) async {
                      setState(() => _model.checkboxListTileValue1 = newValue!);
                    },
                    title: Text(
                      SetLocalizations.of(context).getText(
                        'yn2iubpu' /* 반복없음 */,
                      ),
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'Pretendard',
                            color: Color(0xFFFCFDFF),
                            fontSize: 16.0,
                            useGoogleFonts: false,
                          ),
                    ),
                    tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                    activeColor: FlutterFlowTheme.of(context).secondaryBackground,
                    checkColor: FlutterFlowTheme.of(context).primaryBackground,
                    dense: false,
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                ),
                Theme(
                  data: ThemeData(
                    checkboxTheme: CheckboxThemeData(
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                  ),
                  child: CheckboxListTile(
                    value: _model.checkboxListTileValue2 ??= false,
                    onChanged: (newValue) async {
                      setState(() => _model.checkboxListTileValue2 = newValue!);
                    },
                    title: Text(
                      SetLocalizations.of(context).getText(
                        'kdwrdrtp' /* 월요일 마다 */,
                      ),
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'Pretendard',
                            color: Color(0xFFFCFDFF),
                            fontSize: 16.0,
                            useGoogleFonts: false,
                          ),
                    ),
                    tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                    activeColor: FlutterFlowTheme.of(context).secondaryBackground,
                    checkColor: FlutterFlowTheme.of(context).primaryBackground,
                    dense: false,
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                ),
                Theme(
                  data: ThemeData(
                    checkboxTheme: CheckboxThemeData(
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                  ),
                  child: CheckboxListTile(
                    value: _model.checkboxListTileValue3 ??= false,
                    onChanged: (newValue) async {
                      setState(() => _model.checkboxListTileValue3 = newValue!);
                    },
                    title: Text(
                      SetLocalizations.of(context).getText(
                        'zx7gtwsj' /* 화요일 마다 */,
                      ),
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'Pretendard',
                            color: Color(0xFFFCFDFF),
                            fontSize: 16.0,
                            useGoogleFonts: false,
                          ),
                    ),
                    tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                    activeColor: FlutterFlowTheme.of(context).secondaryBackground,
                    checkColor: FlutterFlowTheme.of(context).primaryBackground,
                    dense: false,
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                ),
                Theme(
                  data: ThemeData(
                    checkboxTheme: CheckboxThemeData(
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                  ),
                  child: CheckboxListTile(
                    value: _model.checkboxListTileValue4 ??= false,
                    onChanged: (newValue) async {
                      setState(() => _model.checkboxListTileValue4 = newValue!);
                    },
                    title: Text(
                      SetLocalizations.of(context).getText(
                        'rzdo5bn7' /* 수요일 마다  */,
                      ),
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'Pretendard',
                            color: Color(0xFFFCFDFF),
                            fontSize: 16.0,
                            useGoogleFonts: false,
                          ),
                    ),
                    tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                    activeColor: FlutterFlowTheme.of(context).secondaryBackground,
                    checkColor: FlutterFlowTheme.of(context).primaryBackground,
                    dense: false,
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                ),
                Theme(
                  data: ThemeData(
                    checkboxTheme: CheckboxThemeData(
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                  ),
                  child: CheckboxListTile(
                    value: _model.checkboxListTileValue5 ??= false,
                    onChanged: (newValue) async {
                      setState(() => _model.checkboxListTileValue5 = newValue!);
                    },
                    title: Text(
                      SetLocalizations.of(context).getText(
                        'gufcw4gb' /* 목요일 마다 */,
                      ),
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'Pretendard',
                            color: Color(0xFFFCFDFF),
                            fontSize: 16.0,
                            useGoogleFonts: false,
                          ),
                    ),
                    tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                    activeColor: FlutterFlowTheme.of(context).secondaryBackground,
                    checkColor: FlutterFlowTheme.of(context).primaryBackground,
                    dense: false,
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                ),
                Theme(
                  data: ThemeData(
                    checkboxTheme: CheckboxThemeData(
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                  ),
                  child: CheckboxListTile(
                    value: _model.checkboxListTileValue6 ??= false,
                    onChanged: (newValue) async {
                      setState(() => _model.checkboxListTileValue6 = newValue!);
                    },
                    title: Text(
                      SetLocalizations.of(context).getText(
                        'mfvqbiu1' /* 금요일 마다 */,
                      ),
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'Pretendard',
                            color: Color(0xFFFCFDFF),
                            fontSize: 16.0,
                            useGoogleFonts: false,
                          ),
                    ),
                    tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                    activeColor: FlutterFlowTheme.of(context).secondaryBackground,
                    checkColor: FlutterFlowTheme.of(context).primaryBackground,
                    dense: false,
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                ),
                Theme(
                  data: ThemeData(
                    checkboxTheme: CheckboxThemeData(
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                  ),
                  child: CheckboxListTile(
                    value: _model.checkboxListTileValue7 ??= false,
                    onChanged: (newValue) async {
                      setState(() => _model.checkboxListTileValue7 = newValue!);
                    },
                    title: Text(
                      SetLocalizations.of(context).getText(
                        '0i4vdzkm' /* 토요일 마다 */,
                      ),
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'Pretendard',
                            color: Color(0xFFFCFDFF),
                            fontSize: 16.0,
                            useGoogleFonts: false,
                          ),
                    ),
                    tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                    activeColor: FlutterFlowTheme.of(context).secondaryBackground,
                    checkColor: FlutterFlowTheme.of(context).primaryBackground,
                    dense: false,
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                ),
                Theme(
                  data: ThemeData(
                    checkboxTheme: CheckboxThemeData(
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                  ),
                  child: CheckboxListTile(
                    value: _model.checkboxListTileValue8 ??= false,
                    onChanged: (newValue) async {
                      setState(() => _model.checkboxListTileValue8 = newValue!);
                    },
                    title: Text(
                      SetLocalizations.of(context).getText(
                        '742mqz79' /* 일요일 마다 */,
                      ),
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'Pretendard',
                            color: Color(0xFFFCFDFF),
                            fontSize: 16.0,
                            useGoogleFonts: false,
                          ),
                    ),
                    tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                    activeColor: FlutterFlowTheme.of(context).secondaryBackground,
                    checkColor: FlutterFlowTheme.of(context).primaryBackground,
                    dense: false,
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                ),
              ].divide(SizedBox(height: 2.0)),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 10.0, 24.0, 0.0),
            child: Container(
              width: double.infinity,
              height: 56.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: FFButtonWidget(
                onPressed: () async {
                  Navigator.pop(context, _model.daylist.take(7).toList().where((e) => _model.checkboxListTileValue1!).toList());
                },
                text: SetLocalizations.of(context).getText(
                  'ze1u6oze' /* 확인 */,
                ),
                options: FFButtonOptions(
                  height: 40.0,
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Pretendard',
                        color: FlutterFlowTheme.of(context).tertiary,
                        useGoogleFonts: false,
                      ),
                  elevation: 3.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
