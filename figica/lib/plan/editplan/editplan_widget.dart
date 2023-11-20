import '../../flutter_set/flutter_drop_down.dart';
import '../../flutter_set/flutter_flow_theme.dart';
import '../../flutter_set/flutter_flow_util.dart';
import '../../flutter_set/flutter_flow_widgets.dart';
import '../../flutter_set/form_field_controller.dart';
import '/plan/dateuntil/dateuntil_widget.dart';
import '/plan/weeklist/weeklist_widget.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'editplan_model.dart';
export 'editplan_model.dart';

class EditplanWidget extends StatefulWidget {
  const EditplanWidget({Key? key}) : super(key: key);

  @override
  _EditplanWidgetState createState() => _EditplanWidgetState();
}

class _EditplanWidgetState extends State<EditplanWidget> {
  late EditplanModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditplanModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();
    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();
    _model.textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();
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
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 24.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              SetLocalizations.of(context).getText(
                '92bik326' /* 일정 등록 */,
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Pretendard',
                    fontSize: 20.0,
                    useGoogleFonts: false,
                  ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
              child: Text(
                SetLocalizations.of(context).getText(
                  'pnbrd5e7' /* 일정명 */,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Pretendard',
                      color: Color(0xFF4B4D51),
                      fontSize: 12.0,
                      useGoogleFonts: false,
                    ),
              ),
            ),
            TextFormField(
              controller: _model.textController1,
              focusNode: _model.textFieldFocusNode1,
              autofocus: true,
              obscureText: false,
              decoration: InputDecoration(
                labelStyle: FlutterFlowTheme.of(context).labelMedium,
                hintStyle: FlutterFlowTheme.of(context).labelMedium,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primary,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).error,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).error,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              style: FlutterFlowTheme.of(context).bodyMedium,
              validator: _model.textController1Validator.asValidator(context),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 32.0, 0.0, 0.0),
                        child: Text(
                          SetLocalizations.of(context).getText(
                            '34sxaeik' /* 일자 */,
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Pretendard',
                                color: Color(0xFF4B4D51),
                                fontSize: 12.0,
                                useGoogleFonts: false,
                              ),
                        ),
                      ),
                      TextFormField(
                        controller: _model.textController2,
                        focusNode: _model.textFieldFocusNode2,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: FlutterFlowTheme.of(context).labelMedium,
                          hintText: SetLocalizations.of(context).getText(
                            '8c3xmhn8' /* 0000/00/00 */,
                          ),
                          hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Pretendard',
                                color: Color(0xFFAEB2B8),
                                useGoogleFonts: false,
                              ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium,
                        keyboardType: TextInputType.datetime,
                        validator: _model.textController2Validator.asValidator(context),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 32.0, 0.0, 0.0),
                        child: Text(
                          SetLocalizations.of(context).getText(
                            'ovyamwcu' /* 시간 */,
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Pretendard',
                                color: Color(0xFF4B4D51),
                                fontSize: 12.0,
                                useGoogleFonts: false,
                              ),
                        ),
                      ),
                      TextFormField(
                        controller: _model.textController3,
                        focusNode: _model.textFieldFocusNode3,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: FlutterFlowTheme.of(context).labelMedium,
                          hintText: SetLocalizations.of(context).getText(
                            'ulwgir5h' /* 00:00 */,
                          ),
                          hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Pretendard',
                                color: Color(0xFFAEB2B8),
                                useGoogleFonts: false,
                              ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium,
                        keyboardType: TextInputType.datetime,
                        validator: _model.textController3Validator.asValidator(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 32.0, 0.0, 0.0),
              child: Text(
                SetLocalizations.of(context).getText(
                  'ylnsjweu' /* 종류 */,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Pretendard',
                      color: Color(0xFF4B4D51),
                      fontSize: 12.0,
                      useGoogleFonts: false,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
              child: FlutterDropDown<String>(
                controller: _model.dropDownValueController ??= FormFieldController<String>(null),
                options: [
                  SetLocalizations.of(context).getText(
                    '3vciuik7' /* 약복용 */,
                  ),
                  SetLocalizations.of(context).getText(
                    'nfx1h22l' /* 병원 */,
                  ),
                  SetLocalizations.of(context).getText(
                    'nz4e3azb' /* 운동 */,
                  ),
                  SetLocalizations.of(context).getText(
                    'djwfq2vn' /* 기타 */,
                  )
                ],
                onChanged: (val) => setState(() => _model.dropDownValue = val),
                width: double.infinity,
                height: 50.0,
                textStyle: FlutterFlowTheme.of(context).bodyMedium,
                hintText: SetLocalizations.of(context).getText(
                  'bk6vyuqd' /* Please select... */,
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 24.0,
                ),
                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                elevation: 2.0,
                borderColor: FlutterFlowTheme.of(context).alternate,
                borderWidth: 2.0,
                borderRadius: 8.0,
                margin: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                hidesUnderline: true,
                isSearchable: false,
                isMultiSelect: false,
              ),
            ),
            Builder(
              builder: (context) => Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 36.0, 0.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await showAlignedDialog(
                      context: context,
                      isGlobal: true,
                      avoidOverflow: false,
                      targetAnchor: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                      followerAnchor: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                      builder: (dialogContext) {
                        return Material(
                          color: Colors.transparent,
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.7,
                            width: MediaQuery.sizeOf(context).width * 0.7,
                            child: WeeklistWidget(),
                          ),
                        );
                      },
                    ).then((value) => setState(() {}));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 44.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFECEEF1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            SetLocalizations.of(context).getText(
                              '330bj6j3' /* 반복 */,
                            ),
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                          Text(
                            SetLocalizations.of(context).getText(
                              '7dfvr1c0' /* Hello World */,
                            ),
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    enableDrag: false,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.viewInsetsOf(context),
                        child: Container(
                          height: MediaQuery.sizeOf(context).height * 0.6,
                          child: DateuntilWidget(),
                        ),
                      );
                    },
                  ).then((value) => safeSetState(() {}));
                },
                child: Container(
                  width: double.infinity,
                  height: 44.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFECEEF1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          SetLocalizations.of(context).getText(
                            'zw3zrbie' /* 반복 */,
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                        Text(
                          SetLocalizations.of(context).getText(
                            'awqvpclp' /* Hello World */,
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 28.0, 0.0, 0.0),
              child: Container(
                width: double.infinity,
                height: 56.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: FFButtonWidget(
                  onPressed: () {
                    print('Button pressed ...');
                  },
                  text: SetLocalizations.of(context).getText(
                    '8q4dexz5' /* 일정 삭제 */,
                  ),
                  options: FFButtonOptions(
                    height: 40.0,
                    padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Pretendard',
                          color: FlutterFlowTheme.of(context).accent1,
                          useGoogleFonts: false,
                        ),
                    elevation: 3.0,
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).accent1,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
              child: Container(
                width: double.infinity,
                height: 56.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: FFButtonWidget(
                  onPressed: () {
                    print('Button pressed ...');
                  },
                  text: SetLocalizations.of(context).getText(
                    '4hislfbr' /* 수정하기 */,
                  ),
                  options: FFButtonOptions(
                    height: 40.0,
                    padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).tertiary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Pretendard',
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
      ),
    );
  }
}
