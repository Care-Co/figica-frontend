import 'dart:convert';
import 'package:fisica/index.dart';
import 'package:fisica/main.dart';
import 'package:fisica/models/FootData.dart';
import 'package:fisica/models/WeightData.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FootprintApi {
  static String printUTCTime() {
    DateTime nowUTC = DateTime.now().toUtc();
    String utcString = nowUTC.toIso8601String();
    String result = utcString.substring(0, utcString.length - 1) + '+00:00';
    //String result = '2024-03-13T02:23:04.909893+00:00';
    print("현재 UTC 시간: $result");
    return result;
  }

  static Future<bool?> footScan(String rawdata) async {
    String date = printUTCTime();
    bool va = false;
    String? token = AppStateNotifier.instance.apiToken;
    String? uid = AppStateNotifier.instance.userdata?.uid;

    var url = Uri.parse('http://203.232.210.68:8080/api/v1/users/$uid/footprints');
    var headers = {'accept': '*/*', 'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};

    var body = jsonEncode({'hexData': rawdata, 'mesured_time': date});
    print(rawdata.length);
    print(date);

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      print('Request successful');
      print('Response body: ${response.body}');
      Map<String, dynamic> responseData = jsonDecode(response.body);
      await AppStateNotifier.instance.UpScanData(responseData['data']).then((value) {
        va = true;
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
      va = false;
    }
    return va;
  }

  static Future<bool?> testfootScan(List datalist) async {
    bool va = false;
    UserController.gettester().then((value) async {
      for (var data in datalist) {
        var url = Uri.parse('http://203.232.210.68:8080/api/v1/test/footprints');
        var headers = {'accept': '*/*', 'Content-Type': 'application/json'};
        var body = jsonEncode({
          "firstName": value['firstName'],
          "lastName": value['lastName'],
          "gender": value['gender'],
          "birthday": value['birthday'],
          "weight": value['weight'],
          "height": value['height'],
          "hexData": data,
        });

        var response = await http.post(url, headers: headers, body: body);

        if (response.statusCode == 201) {
          Map<String, dynamic> responseData = jsonDecode(response.body);
          await AppStateNotifier.instance.UpScanData(responseData['data']);
        } else {
          print('Request failed with status: ${response.statusCode}');
          print('Response body: ${response.body}');
          va = false; // 하나라도 실패하면 va를 false로 설정
          break; // 실패 시, 더 이상의 반복을 중단
        }
      }
      va = true;
    });
    await Future.delayed(const Duration(milliseconds: 10000));

    return va;
  }

  static Future<void> getfoothistory(String year, String month) async {
    String? token = AppStateNotifier.instance.apiToken;
    String? uid = AppStateNotifier.instance.userdata?.uid;

    var url = Uri.parse('http://203.232.210.68:8080/api/v1/users/$uid/footprints?year=$year&month=$month');
    var headers = {'accept': '*/*', 'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    var response = await http.get(url, headers: headers);
    loggerNoStack.t({'Name': 'getfoothistory', 'url': url});
    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body)['data'];
      loggerNoStack.i(responseData);
      List<FootData> footHistory = responseData.map((data) => FootData.fromJson(data)).toList();
      AppStateNotifier.instance.Upfoothistory(footHistory);
    } else {
      loggerNoStack.e(response.body);
    }
  }

  static Future<void> getweighthistory(String year, String month) async {
    String? token = AppStateNotifier.instance.apiToken;
    String? uid = AppStateNotifier.instance.userdata?.uid;
    var url = Uri.parse('http://203.232.210.68:8080/api/v1/users/$uid/weights?year=$year&month=$month');
    var headers = {'accept': '*/*', 'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);
    loggerNoStack.t({'Name': 'getweighthistory', 'url': url});
    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body)['data'];
      loggerNoStack.i(responseData);

      List<WeightData> WeightHistory = responseData.map((data) => WeightData.fromJson(data)).toList();
      AppStateNotifier.instance.UpWeightHistory(WeightHistory);
    } else {
      loggerNoStack.e(response.body);
    }
  }
}
