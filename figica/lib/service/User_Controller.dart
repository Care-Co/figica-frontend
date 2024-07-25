import 'dart:convert';
import 'package:fisica/main.dart';
import 'package:fisica/models/UserData.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:fisica/index.dart';

class UserController {
  static const _testuserdata = 'testuserdata';
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static String linkurl = mainurl;

  //유효성 검사
  static Future<bool> validate(String text, String inputType) async {
    var url = Uri.parse('$linkurl/validate');
    var headers = {'accept': '*/*', 'Content-Type': 'application/json'};
    var body = inputType == 'phone' ? jsonEncode({'phoneNumber': text}) : jsonEncode({'email': text});
    try {
      loggerNoStack.t({'Name': 'validate', 'url': url, 'body': body});
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        loggerNoStack.i('계정 사용가능');
        return true;
      } else {
        loggerNoStack.i('계정 존재');
        return false;
      }
    } catch (e) {
      print(e);
      loggerNoStack.i('계정 존재');
      return false;
    }
  }

  static Future<bool> signUpWithEmail(String email, String password) async {
    try {
      loggerNoStack.t({'Name': 'signUpWithEmail', 'email': email, 'password': password});

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      String? newToken = await userCredential.user?.getIdToken();

      if (newToken != null) {
        AppStateNotifier.instance.UpToken(newToken, false);
        await AppStateNotifier.instance.UpfirebaseToken(newToken);
      }
      return true;
    } catch (e) {
      loggerNoStack.e(e);
      return false;
    }
  }

  static Future<bool> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      String? newToken = await userCredential.user?.getIdToken();
      if (newToken != null) {
        await CreateNewToken(newToken);
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> AuthEmail(String email, String password) async {
    try {
      loggerNoStack.t({'Name': 'AuthEmail', 'email': email, 'password': password});
      late UserCredential userCredential;
      if (AppStateNotifier.instance.isSignUp) {
        userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      } else if (AppStateNotifier.instance.isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      }

      String? newToken = await userCredential.user?.getIdToken();

      if (newToken != null && AppStateNotifier.instance.isSignUp) {
        await AppStateNotifier.instance.UpfirebaseToken(newToken);
      } else if (newToken != null && AppStateNotifier.instance.isLogin) {
        await CreateNewToken(newToken);
      }
      return true;
    } catch (e) {
      loggerNoStack.e(e);
      return false;
    }
  }

  static Future<bool> AuthPhone(String verificationId, String smsCode) async {
    print(verificationId);
    print(smsCode);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    try {
      final getfiretoken = await FirebaseAuth.instance.signInWithCredential(credential);
      final String? newToken = await getfiretoken.user?.getIdToken();
      print("firebase Token: $newToken");
      if (newToken != null && AppStateNotifier.instance.isSignUp) {
        await AppStateNotifier.instance.UpfirebaseToken(newToken);
      } else if (newToken != null && AppStateNotifier.instance.isLogin) {
        await CreateNewToken(newToken);
      }
    } on FirebaseAuthException catch (e) {
      loggerNoStack.e(e);

      if (e.code == 'invalid-verification-code') {
        print('틀림');
        return false;
      }
    } catch (e) {
      print(e);
    }
    return true;
  }

  static Future<void> deleteUser() async {
    print('deleteUser');
    // final String? token = await UserController.getsavedToken();
    String? token = AppStateNotifier.instance.apiToken;
    String? uid = AppStateNotifier.instance.userdata?.uid;
    if (token == null || uid == null) {
      loggerNoStack.e('토큰이나 UID가 null입니다.');
      return;
    }

    var url = Uri.parse('$linkurl/users/$uid');
    var headers = {'accept': '*/*', 'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

    var response = await http.delete(url, headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      await AppStateNotifier.instance.logout();
    } else {
      print(response.statusCode);
    }
  }

  // 토큰 생성
  static Future<void> CreateNewToken(String token) async {
    try {
      final url = Uri.parse('$linkurl/auth/tokens?firebaseToken=$token');

      final response = await http.post(url);
      loggerNoStack.t({'Name': 'CreateNewToken', 'url': url});

      if (response.statusCode == 200) {
        String decodedBody = utf8.decode(response.bodyBytes);
        var jsonResponse = jsonDecode(decodedBody);
        loggerNoStack.i(jsonResponse);

        String newtoken = jsonResponse['token']['accessToken'];
        String refreshToken = jsonResponse['token']['refreshToken'];
        await AppStateNotifier.instance.UpToken(newtoken, true);
        await AppStateNotifier.instance.UprefreshToken(refreshToken);
      } else {}
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<void> RefreshNewToken(String token) async {
    try {
      final url = Uri.parse('$linkurl/auth/access-token?refreshToken=$token');
      final response = await http.post(url);
      loggerNoStack.t({'Name': 'RefreshNewToken', 'url': url});
      if (response.statusCode == 200) {
        String decodedBody = utf8.decode(response.bodyBytes);
        var jsonResponse = jsonDecode(decodedBody);
        loggerNoStack.i(jsonResponse);

        String refreshToken = jsonResponse['token']['accessToken'];

        await AppStateNotifier.instance.UpToken(refreshToken, true);
      } else {
        loggerNoStack.e(response.body);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<bool> signUpInputData(
      String birthday, String firstName, String lastName, String gender, double height, double weight, String optionRegion) async {
    String token = await AppStateNotifier.instance.firebaseToken!;
    print(token);

    final url = Uri.parse('$linkurl/users').replace(queryParameters: {
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'birthday': birthday,
      //'region': optionRegion,
      'height': height.toString(),
      'weight': weight.toString(),
      'firebaseToken': token,
    });

    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    loggerNoStack.t({'Name': 'signUpInputData', 'url': url});

    try {
      final response = await http.post(url, headers: headers);
      print(response.body);
      if (response.statusCode == 201) {
        String decodedBody = utf8.decode(response.bodyBytes);
        var jsonResponse = jsonDecode(decodedBody);
        print(jsonResponse);

        String newtoken = jsonResponse['token']['accessToken'];
        String refreshToken = jsonResponse['token']['refreshToken'];
        await AppStateNotifier.instance.UpToken(newtoken, true);
        await AppStateNotifier.instance.UprefreshToken(refreshToken);

        AppStateNotifier.instance.UpUserInfo(UserData.fromJson(jsonResponse['data']));
        return true;
      } else {
        print(response.body);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<void> updatetester(
      String birthday, String firstName, String lastName, String gender, double height, double weight, String optionRegion) async {
    print('Start -------- updatetester');
    Map<String, dynamic> body = ({
      "birthday": birthday,
      'firstName': firstName,
      "lastName": lastName,
      "gender": gender,
      "height": height,
      "weight": weight,
      "region": optionRegion
    });
    await savetester(body);
  }

  static Future<bool> modiProfile(String birthday, String firstName, String lastName, String gender, double height, double weight) async {
    String? uid = AppStateNotifier.instance.userdata?.uid;
    final String? token = await AppStateNotifier.instance.apiToken;

    final url =
        Uri.parse('$linkurl/users/${uid}?firstName=$firstName&lastName=$lastName&gender=$gender&birthday=$birthday&height=$height&weight=$weight');

    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final body =
        jsonEncode({'firstName': firstName, "lastName": lastName, "gender": gender, "birthday": birthday, "height": height, "weight": weight});
    loggerNoStack.t({'Name': 'modiProfile', 'url': url, 'body': body});

    try {
      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        String decodedBody = utf8.decode(response.bodyBytes);

        var jsonResponse = jsonDecode(decodedBody);
        loggerNoStack.i(jsonResponse);

        AppStateNotifier.instance.UpUserInfo(UserData.fromJson(jsonResponse['data']));
        return true;
      } else {
        var jsonResponse = jsonDecode(response.body);
        loggerNoStack.e(jsonResponse);

        return false;
      }
    } catch (e) {
      print('Error occurred: $e');
      return false;
    }
  }

  static Future<bool> getprofile(String token) async {
    final url = Uri.parse('$linkurl/profile');

    final response = await http.get(
      url,
      headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
    );
    loggerNoStack.t({'Name': 'getprofile', 'url': url, 'token': token});

    if (response.statusCode == 200) {
      loggerNoStack.i(response.body);
      String decodedBody = utf8.decode(response.bodyBytes);
      var jsonResponse = jsonDecode(decodedBody);
      AppStateNotifier.instance.UpUserInfo(UserData.fromJson(jsonResponse['data']));
      return true;
    } else {
      loggerNoStack.e(response.body);
      return false;
    }
  }

  static Future<bool> savetester(Map<String, dynamic> data) async {
    print('saveuserinfo');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_testuserdata, jsonEncode(data));
    AppStateNotifier.instance.notifyListeners();
    return true;
  }

  static Future<Map<String, dynamic>> gettester() async {
    print('Start ------ getuserinfo');
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_testuserdata) == null) {
      return {};
    } else {
      String? jsonData = prefs.getString(_testuserdata);

      return jsonDecode(jsonData!);
    }
  }

  static Future<String?> removetester() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_testuserdata);
    print('removedata');
    return null;
  }
}
