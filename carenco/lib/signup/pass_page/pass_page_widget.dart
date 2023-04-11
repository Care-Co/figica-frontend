// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_util.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
//
// import 'pass_page_model.dart';
// export 'pass_page_model.dart';
// import 'package:flutter/material.dart';
//
// /* 아임포트 휴대폰 본인인증 모듈을 불러옵니다. */
// import 'package:iamport_flutter/iamport_certification.dart';
// /* 아임포트 휴대폰 본인인증 데이터 모델을 불러옵니다. */
// import 'package:iamport_flutter/model/certification_data.dart';
// class Certification extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return IamportCertification(
//       appBar: new AppBar(
//         title: new Text('아임포트 본인인증'),
//       ),
//       /* 웹뷰 로딩 컴포넌트 */
//       initialChild: Container(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset('assets/images/iamport-logo.png'),
//               Container(
//                 padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
//                 child: Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20.0)),
//               ),
//             ],
//           ),
//         ),
//       ),
//       /* [필수입력] 가맹점 식별코드 */
//       userCode: 'iamport',
//       /* [필수입력] 본인인증 데이터 */
//       data: CertificationData({
//         merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}', // 주문번호
//         company: '아임포트',                                            // 회사명 또는 URL
//         carrier: 'SKT',                                               // 통신사
//         name: '홍길동',                                                 // 이름
//         phone: '01012341234',                                         // 전화번호
//       }),
//       /* [필수입력] 콜백 함수 */
//       callback: (Map<String, String> result) {
//         Navigator.pushReplacementNamed(
//           context,
//           '/certification-result',
//           arguments: result,
//         );
//       },
//     );
//   }
// }