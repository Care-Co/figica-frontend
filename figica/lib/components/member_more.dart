import 'package:figica/flutter_set/Loding_button_widget.dart';
import 'package:figica/flutter_set/figica_theme.dart';
import 'package:figica/flutter_set/internationalization.dart';

import '../flutter_set/flutter_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MemberMore extends StatefulWidget {
  const MemberMore({Key? key}) : super(key: key);

  @override
  _MemberMoreState createState() => _MemberMoreState();
}

class _MemberMoreState extends State<MemberMore> {
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
            topLeft: Radius.circular(18.0),
            topRight: Radius.circular(18.0),
          ),
        ),
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () => context.pushNamed('removeMember'),
                  child: Container(
                    child: Center(child: Text(SetLocalizations.of(context).getText('doaqjqkdcnf' /*방출*/))),
                  ),
                ),
              ),
              Divider(),
              Expanded(
                child: InkWell(
                  onTap: () => print('Clicked Area 2'),
                  child: Container(
                    child: Center(child: Text(SetLocalizations.of(context).getText('rmvnqkddlwjs' /*그룹장 이전*/))),
                  ),
                ),
              ),
              Divider(),
              Expanded(
                child: InkWell(
                  onTap: () => print('Clicked Area 3'),
                  child: Container(
                    child: Center(child: Text(SetLocalizations.of(context).getText('tlscjrhksfl' /*신청관리*/))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}