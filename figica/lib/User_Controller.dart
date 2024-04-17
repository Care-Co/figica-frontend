import 'dart:convert';
import 'package:fisica/scan/Foot_Controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:fisica/index.dart';

class UserController {
  static const _keyToken = 'jwtToken';
  static const _uid = 'uid';
  static const _userdata = 'userdata';
  static const _testuserdata = 'testuserdata';
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

  static Future<void> deleteUser() async {
    print('deleteUser');
    final String? token = await UserController.getsavedToken();
    await UserController.getuserinfo().then((temdata) async {
      String? uid = temdata['uid'];
      print(uid);

      var url = Uri.parse('http://203.232.210.68:8080/api/v1/users/$uid');
      var headers = {'accept': '*/*', 'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

      var response = await http.delete(url, headers: headers);
      print(response.body);
      UserController.removeToken();
    });
  }

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
      if (update) {
        AppStateNotifier.instance.update(token);
      }
    } else {
      print('Token is empty, not updating.');
    }
  }

  // 토큰 가져오기
  static Future<String?> getsavedToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_keyToken) == null) {
      return null;
    } else {
      return prefs.getString(_keyToken);
    }
  }

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
    print('Start -------- updateProfile');
    final url = Uri.parse('http://203.232.210.68:8080/api/v1/profileUpdate');
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
      "region": optionRegion
    });

    try {
      final response = await http.put(url, headers: headers, body: body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        String decodedBody = utf8.decode(response.bodyBytes);
        print('Response data: $decodedBody');
        var jsonResponse = jsonDecode(decodedBody);
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

  static Future<bool> saveuserinfo(Map<String, dynamic> data) async {
    print('saveuserinfo');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userdata, jsonEncode(data));
    AppStateNotifier.instance.notifyListeners();
    return true;
  }

  static Future<Map<String, dynamic>> getuserinfo() async {
    print('유저 정보 가져가기  시작');
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_userdata) == null) {
      return {};
    } else {
      String? jsonData = prefs.getString(_userdata);
      print('유저 정보 가져가기  성공');

      return jsonDecode(jsonData!);
    }
  }

  static Future<String?> remove_userdata() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userdata);
    print('remove_userdata');
    return null;
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

  static Future<bool> save_apiData(Map<String, dynamic> data) async {
    print('save_apiData->');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_apiData, jsonEncode(data));
    AppStateNotifier.instance.notifyListeners();
    return true;
  }

  static Future<Map<String, dynamic>> get_apiData() async {
    print('get_apiData->');
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_apiData) == null) {
      return {
        'status': null,
        'message': null,
        'data': {'accuracy': 0, 'battery': 0, 'classType': 10, 'url': null, 'weight': 0}
      };
    } else {
      String? jsonData = prefs.getString(_apiData);

      return jsonDecode(jsonData!);
    }
  }

  static Future<void> removedate() async {
    print('Removing data');
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_apiData);
      await prefs.remove(_weighthistory);
      await prefs.remove(_foothistory);

      print('Data removal completed successfully.');
    } catch (e) {
      print('Error removing data: $e');
      throw 'Failed to remove data';
    }
  }

  static Future<bool> savefoothistory(dynamic data) async {
    print('발 저장 시작');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_foothistory, jsonEncode(data));
    AppStateNotifier.instance.notifyListeners();
    print('발 저장 완료');
    return true;
  }

  static Future<List<footDataClass>> getfoothistory() async {
    print('발 가져오기 시작');
    final prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString(_foothistory);
    if (jsonData == null) return [];
    List<dynamic> jsonList = jsonDecode(jsonData);
    List<footDataClass> footList = jsonList.map((json) => footDataClass.fromJson(json)).toList();
    print('발 가져오기 완료');
    return footList;
  }

  static Future<bool> saveweighthistory(dynamic data) async {
    print('체중 저장 시작');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_weighthistory, jsonEncode(data));
    AppStateNotifier.instance.notifyListeners();
    print('체중 저장 완료');

    return true;
  }

  static Future<List<WeightDataClass>> getWeightHistory() async {
    print('체중 가져오기 시작');
    final prefs = await SharedPreferences.getInstance();
    final String? jsonData = prefs.getString(_weighthistory);
    if (jsonData == null) return [];
    List<dynamic> jsonList = jsonDecode(jsonData);
    List<WeightDataClass> weightList = jsonList.map((json) => WeightDataClass.fromJson(json)).toList();

    weightList.sort((a, b) => a.measuredTime.compareTo(b.measuredTime));

    for (int i = 1; i < weightList.length; i++) {
      weightList[i].weightChange = weightList[i].weight - weightList[i - 1].weight;
      print(weightList[i].weightChange);
    }

    weightList.first.weightChange = 0.0;

    print('체중 가저오기 완료');

    return weightList;
  }

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
