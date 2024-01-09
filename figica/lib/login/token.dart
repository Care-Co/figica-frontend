import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthStorage {
  static const _keyToken = 'jwtToken';

  // 토큰 저장
  static Future<void> setToken(String token) async {
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
  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
    print('removeToken');
  }

  // 토큰 생성
  static Future<String> getapiToken(String token) async {
    print('getapitoken');

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
      print('newtoken $newtoken');
      await AuthStorage.setToken(newtoken);
      return jsonResponse['token'];
    } else {
      print(response.statusCode);
      print('Failed to fetch token');
      return 'Null';
    }
  }

  static Future<void> updateProfile(String birthdaty, String displayName, String gender, double height, double weight) async {
    final url = Uri.parse('http://203.232.210.68:8080/api/user/profileUpdate');
    String? token = await getsavedToken();
    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({"birthday": birthdaty, "displayName": displayName, "gender": gender, "height": height, "weight": weight});
    print(body);

    try {
      final response = await http.put(url, headers: headers, body: body);
      String responseBody = utf8.decode(response.bodyBytes);
      print(responseBody);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse['message']);
        await AuthStorage.getapiToken(token!);
      } else {
        print('Failed to update profile: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
