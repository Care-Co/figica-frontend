import 'dart:convert';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserController {
  static const _keyToken = 'jwtToken';
  static const bool _bottomstate = true;
  static const _device = '';
  static const _platformName = '';
  static const services = '';

  //유효성 검사
  static Future<bool> validate(String text, String inputType) async {
    print("check validate");
    print(text);
    var url = Uri.parse('http://203.232.210.68:8080/api/user/validate');
    var headers = {'accept': '*/*', 'Content-Type': 'application/json'};
    var body = inputType == 'phone' ? jsonEncode({'phoneNumber': text}) : jsonEncode({'email': text});
    try {
      var response = await http.post(url, headers: headers, body: body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('계정 없음');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  static Future<bool> signUpWithEmail(String email, String pw) async {
    print('signUpWithEmail');

    final url = Uri.parse('http://203.232.210.68:8080/api/user/signup/email');

    Map<String, dynamic> requestData = {"email": email, "password": pw};

    try {
      final response = await http.post(
        url,
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 201) {
        // 성공적인 응답 처리
        print('Response data: ${response.body}');
        var jsonResponse = jsonDecode(response.body);
        String newtoken = jsonResponse['token'];
        await UserController.setToken(newtoken);
        return true;
      } else {
        // 에러 응답 처리
        print('Error: ${response.statusCode}');
        print('Error message: ${response.body}');
        return false;
      }
    } catch (e) {
      // 예외 처리
      print('Error: $e');
      return false;
    }
  }

  static Future<String> signUpWithPhone(String token, String phoneNumber) async {
    print('getapitoken');
    final url = Uri.parse('http://203.232.210.68:8080/api/user/signup/phone');
    Map<String, dynamic> requestData = {"phoneNumber": phoneNumber};

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'accept': '*/*',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestData),
      );
      if (response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);
        String newtoken = jsonResponse['token'];
        await UserController.setToken(newtoken);
        return jsonResponse['token'];
      } else {
        print(response.statusCode);
        print('Failed to fetch token');
        return 'Null';
      }
    } catch (e) {
      print('Error: $e');
      return 'Null';
    }
  }

  // 토큰 생성
  static Future<String> getapiToken(String token) async {
    print('getapitoken');

    try {
      final response = await http.post(
        Uri.parse('http://203.232.210.68:8080/api/user/jwt'),
        headers: <String, String>{
          'accept': '*/*',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);
        String newtoken = jsonResponse['token'];

        await UserController.setToken(newtoken);
        return jsonResponse['token'];
      } else {
        print(response.statusCode);
        print('Failed to fetch token');
        return 'Null';
      }
    } catch (e) {
      print('Error: $e');
      return 'Null';
    }
  }

  // 토큰 저장
  static Future<void> setToken(String token) async {
    print('newtoken $token');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
  }

  // 토큰 가져오기
  static Future<String?> getsavedToken() async {
    print('getsavedtoken');
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_keyToken) == null) {
      return 'Null';
    } else {
      return prefs.getString(_keyToken);
    }
  }

  // 토큰 삭제
  static Future<String?> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
    print('removeToken');
    return null;
  }

  // 디바이스 저장
  static Future<void> savedevice(String device) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_device, device.toString());
  }

  static Future<void> savedevicename(String platformName) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_platformName, platformName.toString());
  }

  //디바이스 가져오기
  static Future<String?> getdevice() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_device) == null) {
      return null;
    } else {
      return prefs.getString(_device);
    }
  }

  static Future<String?> getdevicename() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_platformName) == null) {
      return null;
    } else {
      return prefs.getString(_platformName);
    }
  }

  // 디바이스 삭제
  static Future<String?> removedevice() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
    print('removeToken');
    return null;
  }

  static Future<String?> updateProfile(String birthdaty, String displayName, String gender, double height, double weight, String optionRegion) async {
    final url = Uri.parse('http://203.232.210.68:8080/api/user/signup/completeRegistrationProcess');
    String? token = await getsavedToken();
    print("now $token");
    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final body = jsonEncode(
        {"birthday": birthdaty, "displayName": displayName, "gender": gender, "height": height, "weight": weight, "optionRegion": optionRegion});
    print(body);

    try {
      final response = await http.post(url, headers: headers, body: body);
      String responseBody = utf8.decode(response.bodyBytes);
      print(responseBody);
      if (response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse['message']);
        String newtoken = await UserController.getapiToken(token!);
        return newtoken;
      } else {
        print('Failed to update profile: ${response.statusCode}');
        return "Null";
      }
    } catch (e) {
      print('Error occurred: $e');
      return "Null";
    }
  }

  static Future<void> getprofile() async {
    final url = Uri.parse('http://203.232.210.68:8080/api/user/profile');

    String? token = await getsavedToken();
    try {
      final response = await http.get(
        url,
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('Response data: ${response.body}');
      } else {
        print('Error: ${response.statusCode}');
        print('Error message: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
