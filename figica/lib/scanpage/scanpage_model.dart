import '../flutter_set/App_icon_button.dart';
import '../flutter_set/flutter_flow_util.dart';
import '../flutter_set/Loding_button_widget.dart';
import 'scanpage_widget.dart' show ScanpageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ScanpageModel extends FlutterFlowModel<ScanpageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
