import 'dart:async';

import 'package:figica/group/settings/changeLeader_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../group/group_info_screen.dart';
import '../../group/group_setting.dart';
import '../../group/join_group.dart';
import '/index.dart';
import '/main.dart';
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
  String? _apiToken; // API 토큰을 저장할 새로운 필드

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;
  String? get apiToken => _apiToken;
  bool get loading => _apiToken == null || showSplashImage;
  bool get loggedIn => _apiToken != null && _apiToken != 'Null';
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(String? newToken) {
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
      errorBuilder: (context, state) => appStateNotifier.loggedIn ? NavBarPage() : LoginWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => appStateNotifier.loggedIn ? NavBarPage() : LoginWidget(),
        ),
        FFRoute(
          name: 'login',
          path: '/login',
          builder: (context, params) => LoginWidget(),
        ),
        FFRoute(
          name: 'homePage',
          path: '/homePage',
          builder: (context, params) => params.isEmpty ? NavBarPage(initialPage: 'homePage') : HomePageWidget(),
        ),
        FFRoute(
          name: 'smscode',
          path: '/smscode',
          builder: (context, params) => SmscodeWidget(
            verificationId: params.getParam(
              'verificationId',
              ParamType.String,
            ),
            phone: params.getParam(
              'phone',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'agree_tos',
          path: '/agreeTos',
          builder: (context, params) => AgreeTosWidget(),
        ),
        FFRoute(
          name: 'removeMember',
          path: '/removeMember',
          builder: (context, params) => RemoveMemberPage(),
        ),
        FFRoute(
          name: 'Get_id',
          path: '/Get_id',
          builder: (context, params) => GetidWidget(),
        ),
        FFRoute(
          name: 'certify',
          path: '/certify',
          builder: (context, params) => certifyWidget(),
        ),
        FFRoute(
          name: 'check_email',
          path: '/check_email',
          builder: (context, params) => checkemailWidget(),
        ),
        FFRoute(
          name: 'userinfo',
          path: '/userinfo',
          builder: (context, params) => UserInfoWidget(),
        ),
        FFRoute(
          name: 'Set_pw',
          path: '/Set_pw',
          builder: (context, params) => SetPwWidget(
            email: params.getParam('email', ParamType.String),
          ),
        ),
        FFRoute(
          name: 'Input_pw',
          path: '/Input_pw',
          builder: (context, params) => InputPwWidget(
            email: params.getParam('email', ParamType.String),
          ),
        ),
        FFRoute(
          name: 'groupInfo',
          path: '/groupInfo',
          builder: (context, params) => GroupInfoScreen(
            data: params.getParam('data', ParamType.String),
            code: params.getParam('code', ParamType.String),
          ),
        ),
        FFRoute(
          name: 'config',
          path: '/config',
          builder: (context, params) => ConfigWidget(),
        ),
        FFRoute(name: 'group', path: '/group', builder: (context, params) => NavBarPage(initialPage: 'group')),
        FFRoute(
          name: 'groupJoin',
          path: '/groupJoin',
          builder: (context, params) => JoingroupWidget(),
        ),
        FFRoute(
          name: 'GroupJoinHistory',
          path: '/GroupJoinHistory',
          builder: (context, params) => GroupJoinHistory(),
        ),
        FFRoute(
          name: 'ChangeLeaderPage',
          path: '/ChangeLeaderPage',
          builder: (context, params) => ChangeLeaderPage(),
        ),
        FFRoute(
          name: 'groupSetting',
          path: '/groupSetting',
          builder: (context, params) => GroupSetting(
            authority: params.getParam('authority', ParamType.String),
            groupname: params.getParam('groupname', ParamType.String),
          ),
        ),
        FFRoute(
          name: 'mypage',
          path: '/mypage',
          builder: (context, params) => params.isEmpty ? NavBarPage(initialPage: 'mypage') : MypageWidget(),
        ),
        FFRoute(
          name: 'scanpage',
          path: '/scanpage',
          builder: (context, params) => params.isEmpty ? NavBarPage(initialPage: 'scanpage') : ScanpageWidget(),
        ),
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries.where((e) => e.value != null).map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

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

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.location);
            return '/login';
          }
          return null;
        },
        pageBuilder: (context, state) {
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primaryBackground,
                      ),
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder: PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).transitionsBuilder,
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
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
