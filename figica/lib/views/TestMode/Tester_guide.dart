import 'package:flutter/material.dart';
import 'package:fisica/index.dart';

class TesterGuide extends StatefulWidget {
  const TesterGuide({super.key});

  @override
  State<TesterGuide> createState() => _TesterGuideState();
}

class _TesterGuideState extends State<TesterGuide> {
  @override
  Widget build(BuildContext context) {
    final List<String> instructions = [
      SetLocalizations.of(context).getText('required_field'),
      SetLocalizations.of(context).getText('start_instructions'),
      SetLocalizations.of(context).getText('enter_health_info'),
      SetLocalizations.of(context).getText('bluetooth_connection_instructions'),
      SetLocalizations.of(context).getText('measure_instructions'),
      SetLocalizations.of(context).getText('bluetooth_switch_instructions'),
      SetLocalizations.of(context).getText('measure_again_instructions'),
    ];
    final List<String> highlights = [
      SetLocalizations.of(context).getText('review_report_instructions'),
      SetLocalizations.of(context).getText('start_button_instructions'),
      SetLocalizations.of(context).getText('participant_info_entry_instructions'),
      SetLocalizations.of(context).getText('bluetooth_connection_info'),
      SetLocalizations.of(context).getText('measure_plantar_pressure_info'),
      SetLocalizations.of(context).getText('bluetooth_connection_info'),
      SetLocalizations.of(context).getText('bluetooth_switch_info'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          SetLocalizations.of(context).getText('trial_mode_process'),
          style: AppFont.s18,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 560,
              child: Image(
                  image: AssetImage(
                      SetLocalizations.getStoredLocale()?.languageCode == 'en' ? 'assets/images/exmode_en.png' : 'assets/images/exmode_kr.png')),
            ),
            // Container(
            //   height: 500,
            //   child: ListView.builder(
            //     itemCount: instructions.length,
            //     itemBuilder: (context, index) {
            //       return Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 8.0),
            //         child: Container(
            //           child: Row(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 '${index + 1}. ',
            //                 style: AppFont.s18.overrides(fontSize: 12),
            //               ),
            //               RichText(
            //                 text: TextSpan(
            //                   style: AppFont.r16.overrides(color: AppColors.Black),
            //                   children: [
            //                     ..._highlightText(instructions[index], highlights[index]),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Column(
                children: [
                  TextButton(
                      onPressed: () async {
                        context.goNamed('Test_ErrorData');
                      },
                      child: Text(
                        SetLocalizations.of(context).getText('go_back'),
                        style: AppFont.s12.overrides(color: AppColors.Gray500),
                      )),
                  Container(
                    width: double.infinity,
                    child: LodingButtonWidget(
                      onPressed: () async {
                        context.goNamed('Tester_GetData1');
                      },
                      text: SetLocalizations.of(context).getText('start'),
                      options: LodingButtonOptions(
                        height: 56.0,
                        padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: AppColors.Black,
                        textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.primaryBackground),
                        elevation: 0,
                        borderSide: BorderSide(
                          color: AppColors.Black,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            ), // Version s
          ],
        ),
      ),
    );
  }

  List<TextSpan> _highlightText(String text, String highlight) {
    List<TextSpan> spans = [];
    int start = text.indexOf(highlight);
    if (start == -1) {
      spans.add(TextSpan(text: text));
      return spans;
    }
    if (start > 0) {
      spans.add(TextSpan(text: text.substring(0, start)));
    }
    spans.add(TextSpan(
      text: highlight,
      style: TextStyle(backgroundColor: const Color.fromARGB(91, 205, 255, 139)),
    ));
    spans.add(TextSpan(text: text.substring(start + highlight.length)));
    return spans;
  }
}
