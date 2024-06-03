import 'package:fisica/views/home/plan/createSchedule.dart';
import 'package:fisica/widgets/BotNav_widget.dart';
import 'package:fisica/views/home/group/CreateCode.dart';
import 'package:fisica/views/home/group/settings/changeLeader_screen.dart';
import 'package:fisica/views/home/mypage/mypage_histroy_view.dart';
import 'package:fisica/views/home/mypage/mypage_modify_info_view.dart';
import 'package:fisica/views/home/mypage/mypage_avata_view.dart';
import 'package:fisica/views/home/mypage/mypage_setting_view.dart';
import 'package:fisica/views/home/scan/Find_blue.dart';
import 'package:fisica/views/home/scan/FootPrintScreen.dart';
import 'package:fisica/views/home/scan/Foot_result.dart';
import 'package:fisica/testmode.dart/TesterData.dart';
import 'package:fisica/testmode.dart/test_tos_.dart';
import 'package:flutter/material.dart';
import '../views/home/group/group_setting.dart';
import '/index.dart';
export 'package:go_router/go_router.dart';

const kTransitionInfoKey = '__transition_info__';

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
        initialLocation: '/',
        debugLogDiagnostics: true,
        refreshListenable: appStateNotifier,
        redirect: (context, state) {
          final loggedIn = appStateNotifier.loggedIn;
          final loggingIn = state.matchedLocation.startsWith('/login');
          if (!loggedIn && !loggingIn) {
            return '/login';
          } else if (loggedIn && loggingIn) {
            return '/';
          }
          return null;
        },
        routes: <RouteBase>[
          GoRoute(
            name: 'home',
            path: '/',
            builder: (context, state) {
              return BotNav();
            },
            routes: [
              GoRoute(
                  name: 'MySetting',
                  path: 'MySetting',
                  builder: (context, state) {
                    return MySetting();
                  },
                  routes: []),
              GoRoute(
                  name: 'Modiinfo',
                  path: 'Modiinfo',
                  builder: (context, state) {
                    return ModiUserInfoWidget();
                  },
                  routes: []),
              GoRoute(
                  name: 'Myavata',
                  path: 'Myavata',
                  builder: (context, state) {
                    return Myavata();
                  },
                  routes: []),
              GoRoute(
                  name: 'history',
                  path: 'history',
                  builder: (context, state) {
                    return HistoryWidget();
                  },
                  routes: []),
              GoRoute(
                  path: 'Footprint',
                  name: 'Footprint',
                  builder: (context, state) {
                    final mode = state.extra as String;
                    return FootPrint(
                      mode: mode,
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'Footresult',
                      name: 'Footresult',
                      builder: (context, state) {
                        final mode = state.extra as String;

                        return FootResult(
                          mode: mode,
                        );
                      },
                    )
                  ]),
              GoRoute(
                name: 'FindBlue',
                path: 'FindBlue',
                builder: (context, state) {
                  final mode = state.extra as String;

                  return FindBlue(
                    mode: mode,
                  );
                },
              ),
              GoRoute(
                name: 'AddSchedule',
                path: 'AddSchedule',
                builder: (context, state) {
                  return AddSchedulePage();
                },
              ),
              GoRoute(
                  name: 'groupSetting',
                  path: 'groupSetting',
                  builder: (context, state) {
                    final Map<String, dynamic> item = state.extra as Map<String, dynamic>;
                    final authority = item['authority'];
                    final groupname = item['groupname'];
                    return GroupSetting(authority: authority, groupname: groupname);
                  },
                  routes: [
                    GoRoute(
                        name: 'MemberManage',
                        path: 'MemberManage',
                        builder: (context, state) {
                          return MemberManagementPage();
                        },
                        routes: [
                          GoRoute(
                            name: 'removeMember',
                            path: 'removeMember',
                            builder: (context, state) {
                              return RemoveMemberPage();
                            },
                          ),
                          GoRoute(
                            name: 'ChangeLeader',
                            path: 'ChangeLeader',
                            builder: (context, state) {
                              return ChangeLeaderPage();
                            },
                          ),
                          GoRoute(
                            name: 'member_GroupJoinRequest',
                            path: 'member_GroupJoinRequest',
                            builder: (context, state) {
                              return GroupJoinRequestsPage();
                            },
                          ),
                        ]),
                    GoRoute(
                      name: 'GroupJoinRequest',
                      path: 'GroupJoinRequest',
                      builder: (context, state) {
                        return GroupJoinRequestsPage();
                      },
                    ),
                    GoRoute(
                      name: 'ChangeGroupName',
                      path: 'ChangeGroupName',
                      builder: (context, state) {
                        return ChangeGroupNamePage();
                      },
                    ),
                    GoRoute(
                      name: 'InvitationCodeManage',
                      path: 'InvitationCodeManage',
                      builder: (context, state) {
                        return InvitationCodeManagementPage();
                      },
                    ),
                    GoRoute(
                      name: 'DeleteGroup',
                      path: 'DeleteGroup',
                      builder: (context, state) {
                        return DeleteGroupPage();
                      },
                    ),
                    GoRoute(
                      name: 'PublicInfoSetting',
                      path: 'PublicInfoSetting',
                      builder: (context, state) {
                        return PublicInfoSettingsPage();
                      },
                    ),
                    GoRoute(
                      name: 'NotificationSetting',
                      path: 'NotificationSetting',
                      builder: (context, state) {
                        return NotificationSettingsPage();
                      },
                    ),
                    GoRoute(
                      name: 'GroupHistory',
                      path: 'GroupHistory',
                      builder: (context, state) {
                        return GroupHistoryPage();
                      },
                    ),
                    GoRoute(
                      name: 'LeaveGroup',
                      path: 'LeaveGroup',
                      builder: (context, state) {
                        return LeaveGroupPage();
                      },
                    )
                  ]),
              GoRoute(
                  name: 'Creategroup',
                  path: 'Creategroup',
                  builder: (context, state) {
                    return CreategroupWidget();
                  },
                  routes: [
                    GoRoute(
                      name: 'GroupCreatecode',
                      path: 'GroupCreatecode',
                      builder: (context, state) {
                        return CreateCodeWidget();
                      },
                      routes: [
                        GoRoute(
                          name: 'GroupInvitation',
                          path: 'GroupInvitation',
                          builder: (context, state) {
                            return GroupInvitationScreen();
                          },
                        )
                      ],
                    ),
                  ]),
              GoRoute(
                  name: 'Joingroup',
                  path: 'Joingroup',
                  builder: (context, state) {
                    return JoingroupWidget();
                  },
                  routes: [
                    GoRoute(
                      path: 'GroupInfo',
                      name: 'GroupInfo',
                      builder: (context, state) {
                        final Map<String, dynamic> item = state.extra as Map<String, dynamic>;
                        final data = item['data'];
                        final code = item['code'];
                        return GroupInfoScreen(data: data, code: code);
                      },
                    )
                  ])
            ],
          ),

          //login

          GoRoute(
              name: 'login',
              path: '/login',
              builder: (context, state) {
                return LoginWidget();
              },
              routes: [
                GoRoute(
                  name: 'Input_pw',
                  path: 'Input_pw',
                  builder: (context, state) {
                    final item = state.extra as String;
                    return InputPwWidget(email: item);
                  },
                ),
                //로그인 sms코드
                GoRoute(
                  name: 'smscode',
                  path: 'smscode',
                  builder: (context, state) {
                    return SmscodeWidget();
                  },
                ),
                GoRoute(
                    name: 'Guest_agree_tos',
                    path: 'Guest_agree_tos',
                    builder: (context, state) {
                      return TestTos();
                    },
                    routes: [
                      GoRoute(
                          path: 'TesterData',
                          name: 'TesterData',
                          builder: (context, state) {
                            return TesterData();
                          },
                          routes: [
                            GoRoute(
                                path: 'testFootprint',
                                name: 'testFootprint',
                                builder: (context, state) {
                                  final mode = state.extra as String;
                                  return FootPrint(
                                    mode: mode,
                                  );
                                },
                                routes: [
                                  GoRoute(
                                    path: 'testFootresult',
                                    name: 'testFootresult',
                                    builder: (context, state) {
                                      final mode = state.extra as String;

                                      return FootResult(
                                        mode: mode,
                                      );
                                    },
                                  )
                                ]),
                            GoRoute(
                              name: 'testFindBlue',
                              path: 'testFindBlue',
                              builder: (context, state) {
                                final mode = state.extra as String;

                                return FindBlue(
                                  mode: mode,
                                );
                              },
                            ),
                          ])
                    ]),
                //회원가입
                GoRoute(
                    name: 'agree_tos',
                    path: 'agree_tos',
                    builder: (context, state) {
                      return AgreeTosWidget();
                    },
                    routes: [
                      GoRoute(
                          name: 'Get_id',
                          path: 'Get_id',
                          builder: (context, state) {
                            return GetidWidget();
                          },
                          routes: [
                            GoRoute(
                              name: 'Set_pw',
                              path: 'Set_pw',
                              builder: (context, state) {
                                final item = state.extra as String;
                                return SetPwWidget(email: item);
                              },
                            ),
                            GoRoute(
                                name: 'singup_smscode',
                                path: 'singup_smscode',
                                builder: (context, state) {
                                  return SmscodeWidget();
                                },
                                routes: [
                                  GoRoute(
                                    name: 'singup_userinfo',
                                    path: 'singup_userinfo',
                                    builder: (context, params) {
                                      return UserInfoWidget();
                                    },
                                  ),
                                ]),

                            //회원가입 sms코드
                          ])
                    ]),
                GoRoute(
                  path: 'check_email',
                  builder: (context, state) {
                    return checkemailWidget();
                  },
                )
              ]),
        ]);

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries.where((e) => e.value != null).map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}
