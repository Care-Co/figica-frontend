import 'package:figica/User_Controller.dart';
import 'package:figica/flutter_set/App_icon_button.dart';
import 'package:figica/flutter_set/figica_theme.dart';
import 'package:figica/flutter_set/flutter_flow_util.dart';
import 'package:figica/flutter_set/Loding_button_widget.dart';
import 'package:figica/group/group_api.dart';
import 'package:figica/group/group_invitation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'creategroup_model.dart';
export 'creategroup_model.dart';

class CreategroupWidget extends StatefulWidget {
  final VoidCallback updateCounter;
  const CreategroupWidget({Key? key, required this.updateCounter}) : super(key: key);

  @override
  _CreategroupWidgetState createState() => _CreategroupWidgetState();
}

class _CreategroupWidgetState extends State<CreategroupWidget> {
  late CreategroupModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreategroupModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.Black,
        appBar: AppBar(
          backgroundColor: Color(0x00CCFF8B),
          automaticallyImplyLeading: false,
          leading: AppIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.chevron_left,
              color: AppColors.primaryBackground,
              size: 30,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            SetLocalizations.of(context).getText(
              'rmfnqtodtjd' /* Page Title */,
            ),
            style: AppFont.s18,
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 40, 24, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      SetLocalizations.of(context).getText(
                        'rmfnqdlfma' /* 구릅이름 입력 */,
                      ),
                      style: AppFont.r16.overrides(color: AppColors.primaryBackground),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 10, 8, 0),
                      child: TextFormField(
                        controller: _model.textController,
                        focusNode: _model.textFieldFocusNode,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                            labelStyle: AppFont.r16,
                            hintStyle: AppFont.r16,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.Gray850,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.Gray850,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.Gray200,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.Gray200,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: AppColors.Gray850),
                        style: AppFont.r16.overrides(color: AppColors.primaryBackground),
                        validator: _model.textControllerValidator.asValidator(context),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Container(
                    width: double.infinity,
                    height: 56.0,
                    child: LodingButtonWidget(
                      onPressed: () async {
                        try {
                          bool groupCreated = await GroupApi.createGroup(_model.textController.text);

                          if (groupCreated) {
                            FocusScope.of(context).unfocus();
                            PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                              context,
                              settings: RouteSettings(name: '/group/CreategroupWidget/GroupInvitationScreen'),
                              screen: GroupInvitationScreen(updateCounter: widget.updateCounter),
                              withNavBar: false,
                            );
                          } else {
                            print('Failed to create group');
                          }
                        } catch (e) {}
                      },
                      text: SetLocalizations.of(context).getText(
                        'ze1u6oze' /* 확인 */,
                      ),
                      options: LodingButtonOptions(
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: AppColors.primaryBackground,
                        textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.Black),
                        elevation: 0,
                        borderSide: BorderSide(
                          color: AppColors.Black,
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
        ),
      ),
    );
  }
}
