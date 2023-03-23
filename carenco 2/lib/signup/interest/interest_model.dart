import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InterestModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue;
  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  TextEditingController? addController;
  String? Function(BuildContext, String?)? addControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
  }

  void dispose() {
    addController?.dispose();
  }


  /// Additional helper methods are added here.

}
