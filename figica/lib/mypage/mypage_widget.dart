import '../flutter_set/App_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'mypage_model.dart';
export 'mypage_model.dart';

import 'package:figica/index.dart';

class MypageWidget extends StatefulWidget {
  const MypageWidget({Key? key}) : super(key: key);

  @override
  _MypageWidgetState createState() => _MypageWidgetState();
}

class _MypageWidgetState extends State<MypageWidget> {
  late MypageModel _model;
  late AppStateNotifier _appStateNotifier;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MypageModel());

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
        backgroundColor: AppColors.primaryBackground,
        appBar: AppBar(
          backgroundColor: Color(0x00CCFF8B),
          automaticallyImplyLeading: false,
          leading: AppIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            SetLocalizations.of(context).getText(
              'qqpwooly' /* Page Title */,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ElevatedButton(
                onPressed: () async {
                  _appStateNotifier = AppStateNotifier.instance;

                  UserController.removeToken().then((userData) {
                    _appStateNotifier.update(userData);
                  }).catchError((error) {
                    print('Error fetching user data: $error');
                  });
                  context.goNamed('login');
                },
                child: Text('로그아웃'),
              ),
              ElevatedButton(
                onPressed: () async {
                  print(await UserController.getsavedToken());
                },
                child: Text('token'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await UserController.getprofile();
                },
                child: Text('조회'),
              ),
              ElevatedButton(
                onPressed: () async {
                  String? token = await UserController.getsavedToken();
                  await UserController.getapiToken(token!);
                },
                child: Text('토큰 변경'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await GroupApi.deleteGroup();
                },
                child: Text('그룹 삭제'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await GroupApi.findGroup();
                },
                child: Text('그룹 찾기'),
              ),
              ElevatedButton(
                onPressed: () async {
                  print(await GroupApi.createInvitationCode());
                },
                child: Text('초대코드'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
