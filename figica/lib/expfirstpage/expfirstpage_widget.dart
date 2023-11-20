import 'package:figica/flutter_set/internationalization.dart';

import '../flutter_set/flutter_flow_theme.dart';
import '../flutter_set/flutter_flow_util.dart';
import '../flutter_set/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'expfirstpage_model.dart';
export 'expfirstpage_model.dart';

class ExpfirstpageWidget extends StatefulWidget {
  const ExpfirstpageWidget({Key? key}) : super(key: key);

  @override
  _ExpfirstpageWidgetState createState() => _ExpfirstpageWidgetState();
}

class _ExpfirstpageWidgetState extends State<ExpfirstpageWidget> {
  late ExpfirstpageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExpfirstpageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

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
      onTap: () => _model.unfocusNode.canRequestFocus ? FocusScope.of(context).requestFocus(_model.unfocusNode) : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryText,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 28.0, 24.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/simbol.png',
                      width: 83.0,
                      height: 79.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 22.0, 0.0, 0.0),
                    child: Text(
                      SetLocalizations.of(context).getText(
                        'bpqdr9i0' /* 만나서 반가워요! */,
                      ),
                      style: FlutterFlowTheme.of(context).headlineSmall.override(
                            fontFamily: 'Outfit',
                            color: Color(0xFFFCFDFF),
                          ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                    child: Text(
                      SetLocalizations.of(context).getText(
                        'tod4tt70' /* 시작하기 위해서는 로그인이 필요해요 */,
                      ),
                      style: FlutterFlowTheme.of(context).labelLarge.override(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFFAEB2B8),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
