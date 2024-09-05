import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fisica/index.dart';

class UptosWidget extends StatefulWidget {
  final int index;
  final Function(bool) onAgree;

  const UptosWidget({Key? key, required this.onAgree, required this.index}) : super(key: key);

  @override
  _UptosWidgetState createState() => _UptosWidgetState();
}

class _UptosWidgetState extends State<UptosWidget> {
  String text = '';
  String title = '';
  String lang = '';

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  @override
  void initState() {
    super.initState();
    Locale? locale = SetLocalizations.getStoredLocale();
    if (locale != null) {
      lang = '${locale.languageCode}';
      print(lang);
    } else {
      print('No locale stored');
    }
    loadTextFileContent(widget.index, lang);

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadTextFileContent(int index, String langt) async {
    switch (index) {
      case 1:
        text = (langt == 'en')
            ? await rootBundle.loadString('assets/text/service_agreement_en.txt')
            : await rootBundle.loadString('assets/text/service_agreement.txt');
        title = SetLocalizations.of(context).getText('signupHomeCheckboxTermsLabel' /* 이용 약관 동의 */
            );
        break;
      case 2:
        text = (langt == 'en')
            ? await rootBundle.loadString('assets/text/info_agreement_en.txt')
            : await rootBundle.loadString('assets/text/info_agreement.txt');
        title = SetLocalizations.of(context).getText('signupHomeCheckboxPrivacyLabel' /* 개인정보 수집 및 이용 동의*/
            );

        break;
      case 3:
        text = await rootBundle.loadString('assets/text/ad_agreement.txt');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 44.0, 0.0, 0.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 4.0,
              color: Color(0x25090F13),
              offset: Offset(0.0, 2.0),
            )
          ],
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24.0, 4.0, 24.0, 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60.0,
                    height: 4.0,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                child: Text(title, style: AppFont.b24),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(text ?? '내용이 비어있습니다.', style: AppFont.r16),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    height: 56.0,
                    decoration: BoxDecoration(color: AppColors.primaryBackground),
                    child: LodingButtonWidget(
                      onPressed: () async {
                        widget.onAgree(true);
                        Navigator.pop(context);
                      },
                      text: SetLocalizations.of(context).getText(
                        'signupHomeButtonReturnLabel' /* 동의 */,
                      ),
                      options: LodingButtonOptions(
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: AppColors.Black,
                        textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.primaryBackground),
                        elevation: 3.0,
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
            ],
          ),
        ),
      ),
    );
  }
}
