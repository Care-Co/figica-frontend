import 'package:fisica/components/check_cancel_invite.dart';
import 'package:fisica/components/check_delete_group.dart';
import 'package:fisica/components/check_exit_group.dart';
import 'package:fisica/views/home/mypage/mypage_components/ok_pop.dart';
import 'package:fisica/views/home/scan/Foot_Controller.dart';

import 'package:flutter/material.dart';

import 'package:fisica/index.dart';

class Exitservice extends StatefulWidget {
  final String state;
  const Exitservice({Key? key, required this.state}) : super(key: key);

  @override
  _ExitserviceState createState() => _ExitserviceState();
}

class _ExitserviceState extends State<Exitservice> {
  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  String mainText = '';
  String subText = '';

  String buttonText1 = '';
  String buttonText2 = '';
  late VoidCallback action;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => updateContent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  String gs(String code) {
    return SetLocalizations.of(context).getText(code);
  }

  void updateContent() {
    // 상태에 따라 내용 업데이트
    setState(() {
      if (widget.state == 'logout') {
        mainText = gs('rpwjddktn');
        subText = gs('dkffkashsh');
        buttonText1 = gs('fhrmdktn');
        buttonText2 = gs('cnlth');
        action = logout;
      } else if (widget.state == 'singout') {
        mainText = gs('xkfxhl');
        subText = gs('dldydahtgo');
        buttonText1 = gs('xkfehldks');
        buttonText2 = gs('cnlth');
        action = singout;
      }
    });
  }

  Future<void> logout() async {
    print('logout');
    await AppStateNotifier.instance.logout();
    showAlignedDialog(
      context: context,
      isGlobal: true,
      avoidOverflow: false,
      targetAnchor: AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
      followerAnchor: AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
      builder: (dialogContext) {
        return Material(
          color: Colors.transparent,
          child: GestureDetector(
            child: Container(
              height: 432,
              width: 327,
              child: OkPopup(state: 'logout_ok'),
            ),
          ),
        );
      },
    );
  }

  Future<void> singout() async {
    await UserController.deleteUser();

    showAlignedDialog(
      context: context,
      isGlobal: true,
      avoidOverflow: false,
      targetAnchor: AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
      followerAnchor: AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
      builder: (dialogContext) {
        return Material(
          color: Colors.transparent,
          child: GestureDetector(
            child: Container(
              height: 432,
              width: 327,
              child: OkPopup(state: 'singout_ok'),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327,
      height: 432,
      decoration: BoxDecoration(
        color: AppColors.Gray850,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 77, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    color: AppColors.red,
                    size: 16,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 20),
                    child: Text(
                      mainText,
                      style: AppFont.s18.overrides(color: AppColors.primaryBackground),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 20),
                    child: Text(subText, style: AppFont.r16.overrides(color: AppColors.Gray300), textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 3, 0, 12),
                    child: Container(
                      width: double.infinity,
                      height: 56.0,
                      child: LodingButtonWidget(
                        onPressed: () async {
                          action();
                        },
                        text: buttonText1,
                        options: LodingButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                          color: AppColors.primaryBackground,
                          textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.Black),
                          elevation: 0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 56.0,
                    child: LodingButtonWidget(
                      onPressed: () async {
                        context.safePop();
                      },
                      text: buttonText2,
                      options: LodingButtonOptions(
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: Colors.transparent,
                        textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.primaryBackground),
                        elevation: 0,
                        borderSide: BorderSide(
                          color: AppColors.primaryBackground,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
