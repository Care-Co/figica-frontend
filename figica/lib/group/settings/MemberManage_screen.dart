import 'package:fisica/components/member_more.dart';
import 'package:fisica/models/GroupData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fisica/index.dart';

class MemberManagementPage extends StatefulWidget {
  const MemberManagementPage({Key? key}) : super(key: key);

  @override
  _MemberManagementPageState createState() => _MemberManagementPageState();
}

class _MemberManagementPageState extends State<MemberManagementPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Member> memberData = [];

  @override
  void initState() {
    super.initState();
    initGroupData();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  Future<void> initGroupData() async {
    print("test");
    // var loadedmemberdata = await GroupStorageManager.loadMember();

    // setState(() {
    //   memberData = loadedmemberdata;
    // });
  }

  @override
  void dispose() {
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
      onTap: () => FocusScope.of(context).unfocus(),
      child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
              key: scaffoldKey,
              backgroundColor: AppColors.Black,
              appBar: AppBar(
                leading: AppIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                  icon: Icon(
                    Icons.chevron_left,
                    color: AppColors.primaryBackground,
                    size: 24.0,
                  ),
                  onPressed: () async {
                    context.pop();
                  },
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.more_horiz),
                    onPressed: () async {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return GestureDetector(
                            child: Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: Container(height: MediaQuery.sizeOf(context).height * 0.4, child: MemberMore()),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    },
                  ),
                ],
                backgroundColor: Color(0x00CCFF8B),
                automaticallyImplyLeading: false,
                title: Text(SetLocalizations.of(context).getText('aoqejrhksfl'), style: AppFont.s18.overrides(color: AppColors.primaryBackground)),
                centerTitle: false,
                elevation: 0.0,
              ),
              body: ListView.builder(
                itemCount: memberData!.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 232,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                  'https://picsum.photos/seed/279/600',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 13),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      memberData![index].firstName,
                                      style: AppFont.s18.overrides(fontSize: 16, color: AppColors.primaryBackground),
                                    ),
                                    Text(memberData![index].authority, style: AppFont.r16.overrides(fontSize: 12, color: AppColors.Gray300)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: AppColors.Gray700,
                        )
                      ],
                    ),
                  );
                },
              ))),
    );
  }
}
