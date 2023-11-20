import '../../flutter_set/flutter_flow_theme.dart';
import '../../flutter_set/flutter_flow_util.dart';
import '../../flutter_set/flutter_flow_widgets.dart';
import 'weeklist_widget.dart' show WeeklistWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WeeklistModel extends FlutterFlowModel<WeeklistWidget> {
  ///  Local state fields for this component.

  List<bool> daylist = [];
  void addToDaylist(bool item) => daylist.add(item);
  void removeFromDaylist(bool item) => daylist.remove(item);
  void removeAtIndexFromDaylist(int index) => daylist.removeAt(index);
  void insertAtIndexInDaylist(int index, bool item) => daylist.insert(index, item);
  void updateDaylistAtIndex(int index, Function(bool) updateFn) => daylist[index] = updateFn(daylist[index]);

  ///  State fields for stateful widgets in this component.

  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue1;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue2;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue3;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue4;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue5;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue6;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue7;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue8;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
