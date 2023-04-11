import '/auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InfomationModel extends FlutterFlowModel {
  ///  Local state fields for this page.

  bool? isman = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for birthday widget.
  TextEditingController? birthdayController;
  String? Function(BuildContext, String?)? birthdayControllerValidator;
  // State field(s) for height widget.
  TextEditingController? heightController;
  String? Function(BuildContext, String?)? heightControllerValidator;
  // State field(s) for weight widget.
  TextEditingController? weightController;
  String? Function(BuildContext, String?)? weightControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    birthdayController?.dispose();
    heightController?.dispose();
    weightController?.dispose();
  }

/// Additional helper methods are added here.

}
