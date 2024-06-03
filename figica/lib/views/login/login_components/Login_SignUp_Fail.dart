

import 'package:flutter/material.dart';
import 'package:fisica/index.dart';


class SignupFailWidget extends StatefulWidget {
  final VoidCallback onConfirmed;
  final String message;
  const SignupFailWidget({Key? key, required this.onConfirmed, required this.message}) : super(key: key);

  @override
  _SignupFailWidgetState createState() => _SignupFailWidgetState();
}

class _SignupFailWidgetState extends State<SignupFailWidget> {
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.check_circle_outline_rounded,
                      color: AppColors.red,
                      size: 16,
                    ),
                  ),
                  if (widget.message == "phone")
                    Text(
                      SetLocalizations.of(context).getText(
                        'dlaltkdydwjs' /* Hello World */,
                      ),
                      style: AppFont.s18,
                    ),
                  if (widget.message == "email")
                    Text(
                      SetLocalizations.of(context).getText(
                        'dlaltkdydvel' /* Hello World */,
                      ),
                      style: AppFont.s18,
                    ),
                  if (widget.message == "pwfail")
                    Text(
                      SetLocalizations.of(context).getText(
                        'onxtso41w' /* Hello World */,
                      ),
                      style: AppFont.s18,
                    ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 20),
                    child: Center(
                      child: Text(
                          SetLocalizations.of(context).getText(
                            'rlwhsrowjd' /* Hello World */,
                          ),
                          style: AppFont.r16.overrides(color: AppColors.Gray500),
                          textAlign: TextAlign.center),
                    ),
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
                  if (widget.message == "email" || widget.message == "phone")
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 3, 0, 12),
                      child: Container(
                        width: double.infinity,
                        height: 56.0,
                        child: LodingButtonWidget(
                          onPressed: () async {
                            context.push('/');
                          },
                          text: SetLocalizations.of(context).getText(
                            'fhrmdls' /* 로그인으로 돌아가기*/,
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
                        widget.onConfirmed();
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
