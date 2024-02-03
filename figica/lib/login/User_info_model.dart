import 'package:figica/flutter_set/flutter_flow_model.dart';
import 'package:figica/flutter_set/form_field_controller.dart';
import 'package:figica/login/User_info_widget.dart';

import 'package:flutter/material.dart';

class UserInfoModel extends FlutterFlowModel<UserInfoWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for fi widget.
  FocusNode? fiFocusNode;
  TextEditingController? fiController;
  String? Function(BuildContext, String?)? fiControllerValidator;
  // State field(s) for nam widget.
  FocusNode? namFocusNode;
  TextEditingController? namController;
  String? Function(BuildContext, String?)? namControllerValidator;
  // State field(s) for bi widget.
  FocusNode? biFocusNode;
  TextEditingController? biController;
  String? Function(BuildContext, String?)? biControllerValidator;
  // State field(s) for he widget.
  FocusNode? heFocusNode;
  TextEditingController? heController;
  String? Function(BuildContext, String?)? heControllerValidator;
  // State field(s) for we widget.
  FocusNode? weFocusNode;
  TextEditingController? weController;
  String? Function(BuildContext, String?)? weControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    fiFocusNode?.dispose();
    fiController?.dispose();

    namFocusNode?.dispose();
    namController?.dispose();

    biFocusNode?.dispose();
    biController?.dispose();

    heFocusNode?.dispose();
    heController?.dispose();

    weFocusNode?.dispose();
    weController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
