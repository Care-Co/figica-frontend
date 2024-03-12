import 'dart:convert';
import 'package:figica/index.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FootprintData {
  static const _device = 'device';
  static const _platformName = 'platformName';
  static const _apiData = 'apiData';
  final String classType;
  final String url;
  final String accuracy;
  final String weight;
  final String battery;

  FootprintData({
    required this.classType,
    required this.url,
    required this.accuracy,
    required this.weight,
    required this.battery,
  });

  factory FootprintData.fromJson(Map<String, dynamic> json) {
    return FootprintData(
      classType: json['classType'],
      url: json['url'],
      accuracy: json['accuracy'],
      weight: json['weight'],
      battery: json['battery'],
    );
  }

  static Future<bool?> footScan(String rawdata) async {
    print('footScan');
    bool va = false;
    await UserController.getuserinfo().then((temdata) async {
      //String? uid = temdata['data']['uid'];
      String? uid = '4qi7GrEYyxM5YfqgxGHEcX8Sd242';
      print(uid);

      var url = Uri.parse('http://203.232.210.68:8080/api/v1/user/$uid/footprint');
      var headers = {'accept': '*/*', 'Content-Type': 'application/json'};
      var body = jsonEncode({'hexdata': rawdata});

      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        print('Request successful');
        print('Response body: ${response.body}');
        Map<String, dynamic> responseData = jsonDecode(response.body);
        await saveDataToSharedPreferences(responseData['data']).then((value) {
          print('footscansave ' + value.toString());
          va = true;
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        va = false;
      }
    });
    return va;
  }

  static Future<bool> saveDataToSharedPreferences(Map<String, dynamic> data) async {
    print('saveDataToSharedPreferences');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_apiData, jsonEncode(data));
    print(' ok saveDataToSharedPreferences');
    return true;
  }

  static Future<Map<String, dynamic>> getDataFromSharedPreferences() async {
    print('get');
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

  // 디바이스 저장
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
    await prefs.remove(_apiData);
    print('removeall');
    return null;
  }
}
