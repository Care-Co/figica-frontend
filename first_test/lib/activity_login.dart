import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:first_test/constants.dart';
//import 'package:login_example/custom_route.dart';
//import 'package:login_example/dashboard_screen.dart';
import 'package:first_test/users.dart';
import 'package:flutter_login/theme.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/auth';

  const LoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String?> _loginUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(data.name)) {
        return 'User not exists';
      }
      if (mockUsers[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  Future<String?> _signupConfirm(String error, LoginData data) {
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {

    return FlutterLogin(
      theme: LoginTheme(
        pageColorLight: Colors.blue,
        inputTheme: const InputDecorationTheme(
            filled: false,
            border:UnderlineInputBorder(),
        ),
        cardInitialHeight: double.infinity,
        cardTheme: const CardTheme(

        ),


      ),
      logoTag: Constants.logoTag,
      titleTag: Constants.titleTag,
      navigateBackAfterRecovery: true,
      onConfirmRecover: _signupConfirm,
      onConfirmSignup: _signupConfirm,
      loginAfterSignUp: false,
      loginProviders: [
        LoginProvider(
          icon: FontAwesomeIcons.google,
          label: 'Google',
          callback: () async {
            return null;
          },
        ),
      ],
      termsOfService: [
        TermOfService(
          id: 'newsletter',
          mandatory: false,
          text: 'Newsletter subscription',
        ),
        TermOfService(
          id: 'general-term',
          mandatory: true,
          text: 'Term of services',
          linkUrl: 'https://github.com/NearHuscarl/flutter_login',
        ),
      ],
      additionalSignupFields: [
        const UserFormField(
          keyName: 'Username',
          icon: Icon(FontAwesomeIcons.userLarge),
        ),
        const UserFormField(keyName: 'Name'),
        const UserFormField(keyName: 'Surname'),
        UserFormField(
          keyName: 'phone_number',
          displayName: 'Phone Number',
          userType: LoginUserType.phone,
          fieldValidator: (value) {
            final phoneRegExp = RegExp(
              '^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]?\\d{3}[\\s.-]?\\d{4}\$',
            );
            if (value != null &&
                value.length < 7 &&
                !phoneRegExp.hasMatch(value)) {
              return "This isn't a valid phone number";
            }
            return null;
          },
        ),
      ],
      userValidator: (value) {
        if (!value!.contains('@') || !value.endsWith('.com')) {
          return "이메일 형식에는'@'와'.com'이 필수입니다";
        }
        return null;
      },
      passwordValidator: (value) {
        if (value!.isEmpty) {
          return '비밀번호를 입력해 주세요';
        }
        return null;
      },
      onLogin: (loginData) {
        debugPrint('Login info');
        debugPrint('Name: ${loginData.name}');
        debugPrint('Password: ${loginData.password}');
        return _loginUser(loginData);
      },
      onSignup: (signupData) {
        debugPrint('Signup info');
        debugPrint('Name: ${signupData.name}');
        debugPrint('Password: ${signupData.password}');

        signupData.additionalSignupData?.forEach((key, value) {
          debugPrint('$key: $value');
        });
        if (signupData.termsOfService.isNotEmpty) {
          debugPrint('Terms of service: ');
          for (final element in signupData.termsOfService) {
            debugPrint(
              ' - ${element.term.id}: ${element.accepted == true ? 'accepted' : 'rejected'}',
            );
          }
        }
        return _signupUser(signupData);
      },
      onSubmitAnimationCompleted: () {
        // Navigator.of(context).pushReplacement(
        //   FadePageRoute(
        //     builder: (context) => const DashboardScreen(),
        //   ),
        // );
      },
      onRecoverPassword: (name) {
        debugPrint('Recover password info');
        debugPrint('Name: $name');
        return _recoverPassword(name);
        // Show new password dialog
      },
      headerWidget: const IntroWidget(),
    );
  }
}

class IntroWidget extends StatelessWidget {
  const IntroWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    // return Scaffold(
    //   appBar: PreferredSize(
    //     preferredSize:
    //     Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
    //     child: AppBar(
    //       backgroundColor: Colors.black,
    //
    //       automaticallyImplyLeading: true,
    //
    //
    //       title: Text(
    //         '로그인',
    //         style: Theme.of(context).textTheme.subtitle2,
    //       ),
    //
    //       centerTitle: true,
    //       toolbarHeight: MediaQuery.of(context).size.height * 0.1,
    //       elevation: 0,
    //     ),
    //   ),
    //
    // );

    return Column(
      children: [
        const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "You are trying to login/sign up on server hosted on ",
              ),
              TextSpan(
                text: "example.com",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          textAlign: TextAlign.justify,
        ),
        Row(
          children: const <Widget>[
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Authenticate"),
            ),
            Expanded(child: Divider()),
          ],
        ),
      ],
    );
  }
}
