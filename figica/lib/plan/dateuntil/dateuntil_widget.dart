import '../../flutter_set/flutter_flow_calendar.dart';
import '../../flutter_set/flutter_flow_theme.dart';
import '../../flutter_set/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dateuntil_model.dart';
export 'dateuntil_model.dart';

class DateuntilWidget extends StatefulWidget {
  const DateuntilWidget({Key? key}) : super(key: key);

  @override
  _DateuntilWidgetState createState() => _DateuntilWidgetState();
}

class _DateuntilWidgetState extends State<DateuntilWidget> {
  late DateuntilModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DateuntilModel());

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
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: FlutterFlowCalendar(
        color: FlutterFlowTheme.of(context).primary,
        iconColor: FlutterFlowTheme.of(context).secondaryText,
        weekFormat: false,
        weekStartsMonday: false,
        rowHeight: 50.0,
        onChange: (DateTimeRange? newSelectedDate) {
          setState(() => _model.calendarSelectedDay = newSelectedDate);
        },
        titleStyle: FlutterFlowTheme.of(context).titleMedium.override(
              fontFamily: 'Readex Pro',
              fontSize: 20.0,
            ),
        dayOfWeekStyle: FlutterFlowTheme.of(context).labelLarge.override(
              fontFamily: 'Pretendard',
              useGoogleFonts: false,
            ),
        dateStyle: FlutterFlowTheme.of(context).titleMedium,
        selectedDateStyle: FlutterFlowTheme.of(context).bodyLarge,
        inactiveDateStyle: FlutterFlowTheme.of(context).labelMedium,
        locale: SetLocalizations.of(context).languageCode,
      ),
    );
  }
}
