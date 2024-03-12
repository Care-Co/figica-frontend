import 'dart:async';

import 'package:figica/botnav.dart';
import 'package:figica/group/settings/changeLeader_screen.dart';
import 'package:figica/scan/Find_blue.dart';
import 'package:figica/scan/FootPrintScreen.dart';
import 'package:figica/scan/Foot_result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../group/group_setting.dart';
import '/index.dart';
export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  bool showSplashImage = true;
  String? _redirectLocation;
  String? _apiToken;

  bool notifyOnAuthChange = true;
  String? get apiToken => _apiToken;
  bool get loading => _apiToken == null || showSplashImage;
  bool get loggedIn => _apiToken != null;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(String? newToken) {
    print('start -------- setToken');
    if (_apiToken != newToken) {
      _apiToken = newToken;
      print('update $_apiToken');
      notifyListeners(); // 상태가 변경되었으므로 리스너들에게 알림
    }
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
        initialLocation: '/',
        debugLogDiagnostics: true,
        refreshListenable: appStateNotifier,
        redirect: (context, state) {
          final loggedIn = appStateNotifier.loggedIn;
          print(loggedIn);
          final loggingIn = state.matchedLocation.startsWith('/login');
          if (!loggedIn) return loggingIn ? null : '/login';
          if (loggingIn) return '/';
          return null;
        },
        // HomePageWidget(),
        // GroupWidget(),
        // ScanpageWidget(), // 가정: 가운데 돌출 아이템
        // planWidget(),
        // MypageWidget(),
        routes: <RouteBase>[
          GoRoute(
            name: 'home',
            path: '/',
            builder: (context, state) {
              return MarketPage();
            },
            routes: [
              GoRoute(
                  path: 'Footprint',
                  name: 'Footprint',
                  builder: (context, state) {
                    return FootPrint();
                  },
                  routes: [
                    GoRoute(
                      path: 'Footresult',
                      name: 'Footresult',
                      builder: (context, state) {
                        return FootResult();
                      },
                    )
                  ]),
              GoRoute(
                name: 'FindBlue',
                path: 'FindBlue',
                builder: (context, state) {
                  return FindBlue();
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
                      name: 'GroupInvitation',
                      path: 'GroupInvitation',
                      builder: (context, state) {
                        return GroupInvitationScreen();
                      },
                    )
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
                    final verificationId = state.queryParameters['verificationId'];
                    final phone = state.queryParameters['phone'];
                    final setinfo = state.queryParameters['setinfo'];
                    return SmscodeWidget(
                      verificationId: verificationId ?? '',
                      phone: phone ?? '',
                      setinfo: setinfo ?? '',
                    );
                  },
                ),
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
                                  final verificationId = state.queryParameters['verificationId'];
                                  final phone = state.queryParameters['phone'];
                                  final setinfo = state.queryParameters['setinfo'];
                                  return SmscodeWidget(
                                    verificationId: verificationId ?? '',
                                    phone: phone ?? '',
                                    setinfo: setinfo ?? '',
                                  );
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

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) => appState.hasRedirect() && !ignoreRedirect ? null : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) => !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) => appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap => extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo =>
      extraMap.containsKey(kTransitionInfoKey) ? extraMap[kTransitionInfoKey] as TransitionInfo : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty => state.allParams.isEmpty || (state.extraMap.length == 1 && state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) => asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value).onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
    List<String>? collectionNamePath,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(param, type, isList, collectionNamePath: collectionNamePath);
  }
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouter.of(context).location;
    return isRootPage && location != '/' && location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}
