import 'dart:convert';

import 'package:flutter_svg/flutter_svg.dart';

import '../newresult/newresult_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


import 'guset_model.dart';
export 'guset_model.dart';

class GusetWidget extends StatefulWidget {
  const GusetWidget({Key? key}) : super(key: key);

  @override
  _GusetWidgetState createState() => _GusetWidgetState();
}

class _GusetWidgetState extends State<GusetWidget> {
  late GusetModel _model;
  // String bodydata = '{"id":586,"image":"https://carenco-image-server2.s3.ap-northeast-2.amazonaws.com/835a1319-d608-42eb-9051-36bd577eba1a.jpg","weight":"0","type":5,"description":"잘못된 자세 습관을 확인해 보세요!\\n\\n척추의 가슴쪽 흉추부와 엉덩이쪽 천추부가 뒤로 휜 모양을 나타내며 후만 변형이 보이는 상태로 자세성 후만증, 청소년기 후만증, 선천성 후만증 등이 있습니다. 대부분의 척추 후만증의 경우 바른 자세를 위한 교육과 훈련, 등 근육 강화 운동으로 교정이 가능하나 심한 후만 변형을 보이거나 신경학적 이상 소견이 있는 경우, 혹은 척추의 선천성 기형이 동반되어 있는 경우에는 수술적 치료가 필요합니다."}';
  String bodydata = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GusetModel());
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }
  void callAPI() async {
    var url1 = Uri.parse(
      'http://ecs-loadbalancer-1692201378.ap-northeast-1.elb.amazonaws.com/foot-prints/create'
      ,
    );
    Map data = {

      "rawData": "000000000000000000000036000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000034a2000f0100000000000010190900000000000000562b41188b4c14000000da639c002db125000000000000000000200c9b00000099690000000030000000000000008f0c6b440000000022000012000000000000000026b3c4cfc582720000007d4482446eae00005a0000009dcf85d6b8ad6a00001350475f9910668b20000000004b68eb62f9f4ab00000b1d4650c55806607b000000001c73f2a07b33180000007067afa41c061b24000600000c26ae142a0200000000002602a9a02b083700000000ef46630000000000000000000000af97efbd00000000a8c30900000000000000000000003c35c27500000000b2810000000000000000000000002777370000000000c96300000000000000000000000013a84b00000000007942190000000000000000000000440500000000000000a7010000000000000000000035ae990d000000000000000001000000000000000000c7190000000000000000003f5b2f3d000000000001f7a98b00000000000000020b77a351f65f00001651e4d90686000000000000000c14ffc4c1e32f0000c11fc6b6492f0000000000000003096e171ab82c00000d5c0b977c24000000000000000d12981d30070200000fc7d81f90060000000000000003062b9bf35dc9000039c0abe71500000000000000000000003a78320e0000005b42a600000000000000000000000000000000000000000000000000000000000000000000000000000014f9000000000000000000f00f3d0059f00f"
    };

    String body = json.encode(data);
    var response = await http.post(url1,headers: {"Content-Type": "application/json"}, body: body);
    print('post Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    setState(() {
      bodydata = '${response.body}';
    });
    print (bodydata);
  }
  void getd(){
    callAPI();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).black,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 29, 24, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SvgPicture.asset(
                          'assets/images/symbol.svg',
                          width: 200,
                          height: 200,
                          color: Colors.white,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 21, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        '만나서 반가워요!',
                        style: FlutterFlowTheme.of(context).subtitle2.override(
                              fontFamily: 'Pretendard',
                              color: FlutterFlowTheme.of(context).white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              useGoogleFonts: false,
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Fisica 서비스를 한 번 체험해 보세요',
                        style: FlutterFlowTheme.of(context).subtitle2.override(
                              fontFamily: 'Pretendard',
                              color: FlutterFlowTheme.of(context).grey200,
                              fontSize: 16,
                              useGoogleFonts: false,
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 80, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          //callAPI();
                          context.pushNamed('newscan');


                          // Navigator.push(
                          //
                          //     context,
                          //     MaterialPageRoute(
                          //
                          //         builder: (context) => NewresultWidget(bodydata)
                          //     )
                          // );

                        },
                        child: Container(
                          width: 240,
                          height: 240,
                          decoration: BoxDecoration(
                            gradient: RadialGradient(radius: 0.8, colors: [
                              FlutterFlowTheme.of(context).black,
                              FlutterFlowTheme.of(context).darkenGreen,
                              FlutterFlowTheme.of(context).darkenGreen,
                              FlutterFlowTheme.of(context).black,
                              FlutterFlowTheme.of(context).black,
                              FlutterFlowTheme.of(context).darkenGreen,
                              FlutterFlowTheme.of(context).darkenGreen,
                              FlutterFlowTheme.of(context).black,
                            ], stops: [
                              0.435,
                              0.435,
                              0.44,
                              0.44,
                              0.5,
                              0.5,
                              0.51,
                              0.54,
                            ]),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '체험 하기',
                                      style: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Pretendard',
                                            color: FlutterFlowTheme.of(context)
                                                .darkenGreen,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            useGoogleFonts: false,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
