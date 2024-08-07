import 'package:flutter/material.dart';
import '/index.dart';

class Changegroupname extends StatefulWidget {
  final String name;
  const Changegroupname({Key? key, required this.name}) : super(key: key);

  @override
  State<Changegroupname> createState() => _ChangegroupnameState();
}

class _ChangegroupnameState extends State<Changegroupname> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327,
      height: 366,
      decoration: BoxDecoration(
        color: AppColors.Gray850,
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
                  Icon(
                    Icons.check_circle_outline_rounded,
                    color: AppColors.DarkenGreen,
                    size: 16,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 20),
                    child: Text(
                      SetLocalizations.of(context).getText(
                        'qusrudhgks' /* Hello World */,
                      ),
                      style: AppFont.s18.overrides(color: AppColors.primaryBackground),
                    ),
                  ),
                  Text(
                    widget.name,
                    style: AppFont.r16.overrides(color: AppColors.Gray300),
                    textAlign: TextAlign.center,
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
                        context.pushNamed('home');
                      },
                      text: SetLocalizations.of(context).getText('ze1u6oze'),
                      options: LodingButtonOptions(
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: AppColors.primaryBackground,
                        textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.Black),
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
