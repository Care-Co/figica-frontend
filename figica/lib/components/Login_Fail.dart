import 'package:fisica/flutter_set/Loding_button_widget.dart';
import 'package:fisica/flutter_set/fisica_theme.dart';
import 'package:fisica/flutter_set/flutter_util.dart';
import 'package:fisica/flutter_set/internationalization.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginFailWidget extends StatefulWidget {
  final VoidCallback onConfirmed;
  final String message;
  const LoginFailWidget({Key? key, required this.onConfirmed, required this.message}) : super(key: key);

  @override
  _LoginFailWidgetState createState() => _LoginFailWidgetState();
}

class _LoginFailWidgetState extends State<LoginFailWidget> {
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
                    color: AppColors.red,
                    size: 16,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 20),
                    child: Text(
                      SetLocalizations.of(context).getText(
                        'l7iyr39a' /* Hello World */,
                      ),
                      style: AppFont.s18,
                    ),
                  ),
                  if (widget.message == "phone")
                    Text(
                      SetLocalizations.of(context).getText(
                        'onxlo4te' /* Hello World */,
                      ),
                      style: AppFont.r16.overrides(color: AppColors.Gray500),
                    ),
                  if (widget.message == "email")
                    Text(
                      SetLocalizations.of(context).getText(
                        'onxlo41w' /* Hello World */,
                      ),
                      style: AppFont.r16.overrides(color: AppColors.Gray500),
                    ),
                  if (widget.message == "pwfail")
                    Text(
                      SetLocalizations.of(context).getText(
                        'onxtso41w' /* Hello World */,
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
                  Column(
                    children: [
                      if (widget.message == "email" || widget.message == "phone")
                        Container(
                          width: 140,
                          height: 30,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                SetLocalizations.of(context).getText(
                                  'onxlo4sfhw' /* 아직 회원이 아니라면 */,
                                ),
                                style: AppFont.s12,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  if (widget.message == "email" || widget.message == "phone")
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 3, 0, 12),
                      child: Container(
                        width: double.infinity,
                        height: 56.0,
                        child: LodingButtonWidget(
                          onPressed: () async {
                            context.pushNamed('agree_tos');
                          },
                          text: SetLocalizations.of(context).getText(
                            'f1vk38nh' /* 회원 가입하기 */,
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
                  if (widget.message == "pwfail")
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 3, 0, 12),
                      child: Container(
                        width: double.infinity,
                        height: 56.0,
                        child: LodingButtonWidget(
                          onPressed: () async {
                            context.safePop();
                            widget.onConfirmed();
                          },
                          text: SetLocalizations.of(context).getText(
                            '3787ocsp' /* 비밀번호 찾기 */,
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
                  Container(
                    width: double.infinity,
                    height: 56.0,
                    child: LodingButtonWidget(
                      onPressed: () async {
                        context.safePop();
                      },
                      text: SetLocalizations.of(context).getText(
                        'ze1u6oze' /* 확인 */,
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
