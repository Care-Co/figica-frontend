import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupPage2Model extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for email widget.
  TextEditingController? emailController;
  String? Function(BuildContext, String?)? emailControllerValidator;
  // State field(s) for pw widget.
  TextEditingController? pwController;
  late bool pwVisibility;
  String? Function(BuildContext, String?)? pwControllerValidator;
  String? _pwControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for pw2 widget.
  TextEditingController? pw2Controller;
  late bool pw2Visibility;
  String? Function(BuildContext, String?)? pw2ControllerValidator;
  String? _pw2ControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    pwVisibility = false;
    pwControllerValidator = _pwControllerValidator;
    pw2Visibility = false;
    pw2ControllerValidator = _pw2ControllerValidator;
  }

  void dispose() {
    emailController?.dispose();
    pwController?.dispose();
    pw2Controller?.dispose();
  }

/// Additional helper methods are added here.

}
