import 'package:fisica/auth/auth_service.dart';

import 'package:flutter/material.dart';
import 'package:fisica/index.dart';

class resetPwWidget extends StatefulWidget {
  final String email;
  const resetPwWidget({Key? key, required this.email}) : super(key: key);

  @override
  _resetPwWidgetState createState() => _resetPwWidgetState();
}

class _resetPwWidgetState extends State<resetPwWidget> {
  final AuthService _authService = AuthService();
  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

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
    return Container(
      width: 327,
      height: 432,
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
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
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    color: AppColors.primary,
                    size: 16,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 20),
                    child: Text(
                      SetLocalizations.of(context).getText(
                        'changePasswordpopuptitle' /* Hello World */,
                      ),
                      style: AppFont.s18,
                    ),
                  ),
                  Text(
                    SetLocalizations.of(context).getText(
                      'changePasswordpopupScript' /* Hello World */,
                    ),
                    style: AppFont.r16.overrides(color: AppColors.Gray500),
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
                  Container(
                    width: double.infinity,
                    height: 56.0,
                    child: LodingButtonWidget(
                      onPressed: () async {
                        context.pushNamed('LandingScreen');
                      },
                      text: SetLocalizations.of(context).getText(
                        'changePasswordButtonConfirmLabel' /*처음으로 돌아가기 */,
                      ),
                      options: LodingButtonOptions(
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: AppColors.Black,
                        textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.primaryBackground),
                        elevation: 0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
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
