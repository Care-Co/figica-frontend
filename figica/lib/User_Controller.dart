import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:figica/index.dart';

class UserController {
  static const _keyToken = 'jwtToken';
  static const _uid = 'uid';
  static const _userdata = 'userdata';
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  late AppStateNotifier _appStateNotifier;

  //유효성 검사
  static Future<bool> validate(String text, String inputType) async {
    print("check validate");
    print(text);
    var url = Uri.parse('http://203.232.210.68:8080/api/v1/validate');
    var headers = {'accept': '*/*', 'Content-Type': 'application/json'};
    var body = inputType == 'phone' ? jsonEncode({'phoneNumber': text}) : jsonEncode({'email': text});
    try {
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print('계정 없음');
        return true;
      } else {
        print('계정 있음');
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> signUpWithEmail(String email, String password) async {
    print('Start -------- signUpWithEmail');
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      String? newtoken = await userCredential.user?.getIdToken();
      print("firebase Token: $newtoken");
      await UserController.setToken(newtoken!, false);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> signInWithEmail(String email, String password) async {
    print('Start -------- signInWithEmail');
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      String? token = await userCredential.user?.getIdToken();
      print("Firebase Token: $token");
      if (token != null) {
        await getapiToken(token);
      }
      print('ok -------- signInWithEmail');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> signUpWithPhone(String verificationId, String smsCode, bool info) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    try {
      final getfiretoken = await FirebaseAuth.instance.signInWithCredential(credential);
      final String? token = await getfiretoken.user?.getIdToken();
      print("firebase Token: $token");

      if (info) {
        await UserController.setToken(token!, false);
        return true;
      } else if (!info) {
        await getapiToken(token!);
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-verification-code') {
        print('틀림');
        return false;
      }
    } catch (e) {
      print(e);
    }
    return true;
  }
  // static Future<String> signUpWithPhone(String token, String phoneNumber) async {
  //   print('getapitoken');
  //   final url = Uri.parse('http://203.232.210.68:8080/api/v1/user/signup/phone');
  //   Map<String, dynamic> requestData = {"phoneNumber": phoneNumber};

  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: <String, String>{
  //         'accept': '*/*',
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: jsonEncode(requestData),
  //     );
  //     if (response.statusCode == 201) {
  //       var jsonResponse = jsonDecode(response.body);
  //       String newtoken = jsonResponse['token'];
  //       await UserController.setToken(newtoken, false);
  //       await getprofile(newtoken);
  //       return jsonResponse['token'];
  //     } else {
  //       print(response.statusCode);
  //       print('Failed to fetch token');
  //       return 'Null';
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     return 'Null';
  //   }
  // }

  // 토큰 생성
  static Future<void> getapiToken(String token) async {
    print('getapitoken');

    try {
      final response = await http.post(
        Uri.parse('http://203.232.210.68:8080/api/v1/jwt'),
        headers: <String, String>{
          'accept': '*/*',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        String newtoken = jsonResponse['token']['accessToken'];
        await getprofile(newtoken);
        await UserController.setToken(newtoken, true);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // 토큰 저장
  static Future<void> setToken(String token, bool update) async {
    if (token.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyToken, token);
      print('Ok -------- setToken');
      if (update) {
        AppStateNotifier.instance.update(token);
      }
    } else {
      print('Token is empty, not updating.');
    }
  }

  // 토큰 가져오기
  static Future<String?> getsavedToken() async {
    print('Start -------- getsavedtoken');
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_keyToken) == null) {
      return null;
    } else {
      print('Ok -------- getsavedtoken');
      return prefs.getString(_keyToken);
    }
  }

  static Future<void> saveuid(String uid) async {
    print('saveuid');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_uid, uid);
  }

  static Future<String?> getsaveduid() async {
    print('getsavedtoken');
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_uid) == null) {
      return 'Null';
    } else {
      return prefs.getString(_uid);
    }
  }

  // 토큰 삭제
  static Future<String?> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
    print('removeToken');
    return null;
  }

  static Future<bool> updateProfile(
      String birthday, String firstName, String lastName, String gender, double height, double weight, String optionRegion) async {
    print('Start -------- updateProfile');
    final url = Uri.parse('http://203.232.210.68:8080/api/v1/signup/completeRegistrationProcess');
    String? token = await getsavedToken();
    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      "birthday": birthday,
      'firstName': firstName,
      "lastName": lastName,
      "gender": gender,
      "height": height,
      "weight": weight,
      "optionRegion": optionRegion
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        String decodedBody = utf8.decode(response.bodyBytes);
        print('Response data: $decodedBody');
        var jsonResponse = jsonDecode(decodedBody);
        setToken(jsonResponse['token']['accessToken'], true);
        saveuserinfo(jsonResponse['data']);
        return true;
      } else {
        print('Failed to update profile: ${response.statusCode}');
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        return false;
      }
    } catch (e) {
      print('Error occurred: $e');
      return false;
    }
  }

  static Future<void> getprofile(String token) async {
    print('Strat ------ getprofile');
    final url = Uri.parse('http://203.232.210.68:8080/api/v1/profile');
    try {
      final response = await http.get(
        url,
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        String decodedBody = utf8.decode(response.bodyBytes);
        var jsonResponse = jsonDecode(decodedBody);
        print(jsonResponse['data']);
        await UserController.saveuserinfo(jsonResponse['data']);
      } else {
        print('Error: ${response.statusCode}');
        print('Error message: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<void> saveuserinfo(Map<String, dynamic> data) async {
    print('saveuserinfo');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userdata, jsonEncode(data));
  }

  static Future<Map<String, dynamic>> getuserinfo() async {
    print('Start ------ getuserinfo');
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_userdata) == null) {
      return {
        'status': null,
        'message': null,
        'data': {'accuracy': 0, 'battery': 0, 'classType': 10, 'url': null, 'weight': 0}
      };
    } else {
      String? jsonData = prefs.getString(_userdata);

      return jsonDecode(jsonData!);
    }
  }

  static Future<String?> removedata() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userdata);
    print('removedata');
    return null;
  }
}
