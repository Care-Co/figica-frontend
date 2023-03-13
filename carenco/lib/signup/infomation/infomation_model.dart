import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InfomationModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for name widget.
  TextEditingController? nameController;
  String? Function(BuildContext, String?)? nameControllerValidator;
  // State field(s) for phone widget.
  TextEditingController? phoneController1;
  late bool phoneVisibility;
  String? Function(BuildContext, String?)? phoneController1Validator;
  // State field(s) for phone widget.
  TextEditingController? phoneController2;
  String? Function(BuildContext, String?)? phoneController2Validator;
  // State field(s) for phone widget.
  TextEditingController? phoneController3;
  String? Function(BuildContext, String?)? phoneController3Validator;
  // State field(s) for phone widget.
  TextEditingController? phoneController4;
  String? Function(BuildContext, String?)? phoneController4Validator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    phoneVisibility = false;
  }

  void dispose() {
    nameController?.dispose();
    phoneController1?.dispose();
    phoneController2?.dispose();
    phoneController3?.dispose();
    phoneController4?.dispose();
  }

  /// Additional helper methods are added here.

}
