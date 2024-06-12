import 'package:flutter/material.dart';
import 'package:fisica/index.dart';

class TesterGuide extends StatefulWidget {
  const TesterGuide({super.key});

  @override
  State<TesterGuide> createState() => _TesterGuideState();
}

class _TesterGuideState extends State<TesterGuide> {
  final List<String> instructions = [
    '시작하기 버튼을 누르면 시작됩니다.',
    '체험자 정보 입력에서\n건강 및 개인정보를 입력해 주세요.',
    '정보 입력을 완료하면 블루투스를 통해\n족저압 측정 기기와 연결합니다\n기기 검색을 통해 인식되면 디바이스와\n서비스를 연결해 주세요.',
    '지시에 따라 족저압을 측정해 주세요.',
    '데이터 검증을 위해 다른 기기로\n 블루투스 연결을 변경합니다\n 자동으로 변경되니 잠시만 기다려 주세요',
    '새로 연결된 기기 위로 올라간\n 족저압을 측정해 주세요.',
    '족저압 리포트를 확인하고 처음으로 돌아가\n주세요.',
  ];
  final List<String> highlights = [
    '시작하기',
    '체험자 정보 입력',
    '족저압 측정 기기와 연결',
    '족저압을 측정',
    '블루투스 연결을 변경',
    '족저압을 측정',
    '족저압 리포트를 확인',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '체험 모드 프로세스 안내',
          style: AppFont.s18,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 500,
              child: ListView.builder(
                itemCount: instructions.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}. ',
                            style: AppFont.s18.overrides(fontSize: 12),
                          ),
                          RichText(
                            text: TextSpan(
                              style: AppFont.r16.overrides(color: AppColors.Black),
                              children: [
                                ..._highlightText(instructions[index], highlights[index]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                children: [
                  Text(version),
                  Container(
                    width: double.infinity,
                    child: LodingButtonWidget(
                      onPressed: () async {
                        context.goNamed('Tester_menu');
                      },
                      text: '시작하기',
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
