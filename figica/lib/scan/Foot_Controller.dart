import 'dart:convert';
import 'package:fisica/index.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FootprintData {
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
    print('footScan');
    bool va = false;
    final String? token = await UserController.getsavedToken();
    print(token);
    await UserController.getuserinfo().then((temdata) async {
      String? uid = temdata['uid'];
      print(uid);

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
        await DataController.save_apiData(responseData['data']).then((value) {
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

  static Future<bool?> testfootScan(List datalist) async {
    print('footScan');
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
          await DataController.save_apiData(responseData['data']);
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
    print(DataController.get_apiData);

    print('va = $va');
    return va;
  }

// 족저압 히스토리

  //체중 히스토리
}

class footDataClass {
  DateTime measuredDate;
  DateTime measuredTime;
  int classType;
  int accuracy;
  String imageUrl;
  double weight;

  footDataClass({
    required this.measuredDate,
    required this.measuredTime,
    required this.classType,
    required this.accuracy,
    required this.imageUrl,
    required this.weight,
  });
  static void sortData(List<footDataClass> data) {
    try {
      data.sort((a, b) => a.measuredTime.compareTo(b.measuredTime));
    } on Exception catch (e) {
      print(e);
    }
  }

  String toString() {
    return 'footData(measuredDate: $measuredDate, measuredTime: $measuredTime, classType: $classType, accuracy: $accuracy, imageUrl: $imageUrl, weight: $weight)';
  }

  // Method to parse from JSON
  factory footDataClass.fromJson(Map<String, dynamic> json) {
    return footDataClass(
      measuredDate: DateTime.parse(json['measuredDate']),
      measuredTime: DateTime.parse("${json['measuredDate']} ${json['measuredTime']}"),
      classType: json['classType'],
      accuracy: json['accuracy'],
      imageUrl: json['imageUrl'],
      weight: json['weight'].toDouble(),
    );
  }

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'measuredDate': measuredDate.toIso8601String().split('T')[0],
      'measuredTime': measuredTime.toIso8601String().split('T')[1],
      'classType': classType,
      'accuracy': accuracy,
      'imageUrl': imageUrl,
      'weight': weight,
    };
  }

  static Future<bool?> getfoothistory(String year, String month) async {
    print('getfoothistoryAPI');
    bool va = false;
    final String? token = await UserController.getsavedToken();
    await UserController.getuserinfo().then((temdata) async {
      String? uid = temdata['uid'];
      var url = Uri.parse('http://203.232.210.68:8080/api/v1/users/$uid/footprints?year=$year&month=$month');
      var headers = {'accept': '*/*', 'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        await DataController.savefoothistory(responseData['data']).then((value) {
          print('savefoothistory ' + value.toString());
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
}

class WeightDataClass {
  DateTime measuredDate;
  DateTime measuredTime;
  double weight;
  double weightChange;
  String weightType;

  WeightDataClass({
    required this.measuredDate,
    required this.measuredTime,
    required this.weight,
    required this.weightChange,
    required this.weightType,
  });

  static void sortData(List<WeightDataClass> data) {
    try {
      data.sort((a, b) => a.measuredTime.compareTo(b.measuredTime));
    } on Exception catch (e) {
      print(e);
    }
  }

  static void sortData2(List<WeightDataClass> data) {
    try {
      data.sort((a, b) => b.measuredTime.compareTo(a.measuredTime));
    } on Exception catch (e) {
      print(e);
    }
  }

  String toString() {
    return '{measuredDate: $measuredDate, measuredTime: $measuredTime, weight: $weight, weightType: $weightType,weightChange: $weightChange}';
  }

  factory WeightDataClass.fromJson(Map<String, dynamic> json) {
    return WeightDataClass(
      measuredDate: DateTime.parse(json['measuredDate']),
      measuredTime: DateTime.parse("${json['measuredDate']} ${json['measuredTime']}"),
      weight: json['weight'].toDouble(),
      weightChange: json['weightChange']?.toDouble() ?? 1.0,
      weightType: json['weightType'],
    );
  }

  static Future<bool?> getweighthistory(String year, String month) async {
    List<WeightDataClass> weights = [];

    print('체중히스토리 api 시작 ');
    bool va = false;
    final String? token = await UserController.getsavedToken();
    await UserController.getuserinfo().then((temdata) async {
      String? uid = temdata['uid'];
      var url = Uri.parse('http://203.232.210.68:8080/api/v1/users/$uid/weights?year=$year&month=$month');
      var headers = {'accept': '*/*', 'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        print(responseData.toString());
        await DataController.saveweighthistory(responseData['data']).then((value) {
          print('savefoothistory ' + value.toString());
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
}
