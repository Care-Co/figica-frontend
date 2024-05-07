import 'dart:convert';
import 'package:fisica/main.dart';
import 'package:fisica/models/UserData.dart';
import 'package:fisica/models/WeightData.dart';
import 'package:fisica/scan/Foot_Controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:fisica/index.dart';

class UserController {
  static const _keyToken = 'jwtToken';
  static const _uid = 'uid';
  static const _testuserdata = 'testuserdata';
  static final FirebaseAuth _auth = FirebaseAuth.instance;

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
      String? newToken = await userCredential.user?.getIdToken();
      print("Firebase Token: $newToken");

      if (newToken != null) {
        AppStateNotifier.instance.UpToken(newToken, false);
      }
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
      String? newToken = await userCredential.user?.getIdToken();
      print("Firebase Token: $newToken");
      if (newToken != null) {
        await CreateNewToken(newToken);
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
      final String? newToken = await getfiretoken.user?.getIdToken();
      print("firebase Token: $newToken");

      if (info) {
        if (newToken != null) {
          await CreateNewToken(newToken);
        }
        return true;
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

  static Future<void> deleteUser() async {
    print('deleteUser');
    // final String? token = await UserController.getsavedToken();
    String? token = AppStateNotifier.instance.apiToken;
    String? uid = AppStateNotifier.instance.userdata?.uid;

    var url = Uri.parse('http://203.232.210.68:8080/api/v1/users/$uid');
    var headers = {'accept': '*/*', 'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

    var response = await http.delete(url, headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      await DataController.removedata();
      await DataController.removedevice();
      await UserController.removeToken();
    } else {
      print(response.statusCode);
    }
  }

  // 토큰 생성
  static Future<void> CreateNewToken(String token) async {
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
        await AppStateNotifier.instance.UpToken(newtoken, true);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // // 토큰 가져오기
  // static Future<String?> getsavedToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   if (prefs.getString(_keyToken) == null) {
  //     return null;
  //   } else {
  //     return prefs.getString(_keyToken);
  //   }
  // }

  static Future<void> saveuid(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_uid, uid);
  }

  static Future<String?> getsaveduid() async {
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
    AppStateNotifier.instance.delete();
    print('removeToken');
    return null;
  }

  static Future<bool> singUpInputdata(
      String birthday, String firstName, String lastName, String gender, double height, double weight, String optionRegion) async {
    print('Start -------- updateProfile');
    final url = Uri.parse('http://203.232.210.68:8080/api/v1/signup/completeRegistrationProcess');
    final String? token = await AppStateNotifier.instance.apiToken;
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
      //"region": optionRegion
    });
    print(headers);
    print(body);

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        String decodedBody = utf8.decode(response.bodyBytes);
        print('Response data: $decodedBody');
        var jsonResponse = jsonDecode(decodedBody);
        AppStateNotifier.instance.UpToken(jsonResponse['token']['accessToken'], true);
        AppStateNotifier.instance.UpUserInfo(UserData.fromJsonString(jsonResponse['data']));
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

  static Future<bool> modiProfile(
      String birthday, String firstName, String lastName, String gender, double height, double weight, String optionRegion) async {
    print('Start -------- modiProfile');
    String? uid = AppStateNotifier.instance.userdata?.uid;
    final String? token = await AppStateNotifier.instance.apiToken;
    print(token);

    final url = Uri.parse('http://203.232.210.68:8080/api/v1/users/${uid}');
    print(url);

    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'firstName': firstName,
      "lastName": lastName,
      "gender": gender,
      "birthday": birthday,
      "region": optionRegion,
      "height": height,
      "weight": weight
    });
    print(body.toString());

    try {
      final response = await http.put(url, headers: headers, body: body);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        String decodedBody = utf8.decode(response.bodyBytes);
        print(decodedBody);

        print('Response data: $decodedBody');
        var jsonResponse = jsonDecode(decodedBody);
        AppStateNotifier.instance.UpUserInfo(UserData.fromJson(jsonResponse['data']));
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
    final url = Uri.parse('http://203.232.210.68:8080/api/v1/profile');

    final response = await http.get(
      url,
      headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
    );
    loggerNoStack.t({'Name': 'getprofile', 'url': url});

    if (response.statusCode == 200) {
      loggerNoStack.i(response.body);
      String decodedBody = utf8.decode(response.bodyBytes);
      var jsonResponse = jsonDecode(decodedBody);
      AppStateNotifier.instance.UpUserInfo(UserData.fromJson(jsonResponse['data']));
    } else {
      loggerNoStack.w(response.body);
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

//------------------------DataController-------------------------------//
class DataController {
  static const _apiData = 'apiData';
  static const _foothistory = 'foothistory';
  static const _weighthistory = 'weighthistory';
  static const _device = 'device';
  static const _platformName = 'platformName';
  static const _userdata = 'userdata';

  static Future<void> removedata() async {
    print('Removing data');
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_apiData);
      await prefs.remove(_weighthistory);
      await prefs.remove(_foothistory);
      await prefs.remove(_userdata).then((value) => print('Data removal completed successfully.'));
    } catch (e) {
      print('Error removing data: $e');
      throw 'Failed to remove data';
    }
  }

  // static Future<List<WeightData>> getWeightHistory() async {
  //   print('체중 가져오기 시작');
  //   final prefs = await SharedPreferences.getInstance();
  //   final String? jsonData = prefs.getString(_weighthistory);
  //   if (jsonData == null) return [];
  //   List<dynamic> jsonList = jsonDecode(jsonData);
  //   List<WeightData> weightList = jsonList.map((json) => WeightData.fromJson(json)).toList();

  //   weightList.sort((a, b) => a.measuredTime.compareTo(b.measuredTime));

  //   for (int i = 1; i < weightList.length; i++) {
  //     weightList[i].weightChange = weightList[i].weight - weightList[i - 1].weight;
  //     print(weightList[i].weightChange);
  //   }

  //   weightList.first.weightChange = 0.0;

  //   print('체중 가저오기 완료');

  //   return weightList;
  // }

  static Future<void> savedevice(String device) async {
    print('savedevice');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_device, device.toString());
  }

  static Future<void> savedevicename(String platformName) async {
    print('savedevicename');
    print(platformName);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_platformName, platformName.toString());
  }

  static Future<String?> getdevice() async {
    print('getdevice');
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_device) == null) {
      return null;
    } else {
      return prefs.getString(_device);
    }
  }

  static Future<String?> getdevicename() async {
    print('getdevicename');
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
    await prefs.remove(_device);
    await prefs.remove(_platformName);
    print('removeall');
    return null;
  }
}
