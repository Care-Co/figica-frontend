import 'package:figica/flutter_set/App_icon_button.dart';
import 'package:figica/flutter_set/figica_theme.dart';
import 'package:figica/flutter_set/flutter_flow_util.dart';
import 'package:figica/flutter_set/flutter_flow_widgets.dart';
import 'package:figica/group/group_api.dart';
import 'package:figica/group/group_invitation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JoingroupWidget extends StatefulWidget {
  const JoingroupWidget({Key? key}) : super(key: key);

  @override
  _JoingroupWidgetState createState() => _JoingroupWidgetState();
}

class _JoingroupWidgetState extends State<JoingroupWidget> {
  final TextEditingController myController = TextEditingController();
  FocusNode? textFieldFocusNode;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
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
              'rmfnqckadu' /* Page Title */,
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
                        'cheozhemdlqfur' /* 초대코드 입력 */,
                      ),
                      style: AppFont.r16.overrides(color: AppColors.primaryBackground),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 10, 8, 0),
                      child: TextFormField(
                        controller: myController,
                        focusNode: textFieldFocusNode,
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
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Container(
                    width: double.infinity,
                    height: 56.0,
                    child: FFButtonWidget(
                      onPressed: () async {
                        String invitationCode = await GroupApi.createGroup(myController.text);
                        if (invitationCode != 'none') {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => GroupInvitationScreen(invitationCode: invitationCode),
                          ));
                        } else {
                          // 실패 처리, 예를 들어 오류 메시지 표시
                        }
                      },
                      text: SetLocalizations.of(context).getText(
                        'rmfqnckqrl' /* 그룹찾기 */,
                      ),
                      options: FFButtonOptions(
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
