import 'dart:convert';

import 'package:fisica/index.dart';
import 'package:fisica/main.dart';
import 'package:fisica/models/FootData.dart';
import 'package:fisica/models/WeightData.dart';
import 'package:http/http.dart' as http;

class FootprintApi {
  static String linkurl = mainurl;

  static String printUTCTime() {
    DateTime nowUTC = DateTime.now().toLocal();
    print(nowUTC);
    String utcString = nowUTC.toIso8601String();
    print(utcString);

    String result = utcString.substring(0, utcString.length - 1) + '+00:00';
    //String result = '2024-03-13T02:23:04.909893+00:00';
    return result;
  }

  static Future<bool?> footScan(String rawdata) async {
    String date = printUTCTime();
    bool va = false;
    String? token = AppStateNotifier.instance.apiToken;
    String? uid = AppStateNotifier.instance.userdata?.uid;

    var url = Uri.parse('$linkurl/users/$uid/footprints');
    var headers = {'accept': '*/*', 'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};

    var body = jsonEncode({'hexData': rawdata, 'mesured_time': date});
    loggerNoStack.t({'Name': 'footScan', 'mesured_time': date, 'data': rawdata.length.toString()});

    try {
      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        String decodedBody = utf8.decode(response.bodyBytes);
        var jsonResponse = jsonDecode(decodedBody);
        loggerNoStack.i(jsonResponse);

        await AppStateNotifier.instance.UpScanData(jsonResponse['data']).then((value) {
          va = true;
        });
        AppStateNotifier.instance.historyapi();
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        va = false;
      }
    } on Exception catch (e) {
      loggerNoStack.e(e);
    }
    return va;
  }

  static Future<bool?> testfootScan(List datalist) async {
    String date = printUTCTime();
    bool va = false;
    String? token = AppStateNotifier.instance.apiToken;
    String? uid = AppStateNotifier.instance.userdata?.uid;

    // var url = Uri.parse('$linkurl/users/$uid/footprints');
    // var headers = {'accept': '*/*', 'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};

    // var body = jsonEncode({'hexData': rawdata, 'mesured_time': date});
    // loggerNoStack.t({'Name': 'footScan', 'mesured_time': date, 'data': rawdata.length.toString()});

    // try {
    //   var response = await http.post(url, headers: headers, body: body);

    //   if (response.statusCode == 201) {
    //     String decodedBody = utf8.decode(response.bodyBytes);
    //     var jsonResponse = jsonDecode(decodedBody);
    //     loggerNoStack.i(jsonResponse);

    //     await AppStateNotifier.instance.UpScanData(jsonResponse['data']).then((value) {
    //       va = true;
    //     });
    //     AppStateNotifier.instance.historyapi();
    //   } else {
    //     print('Request failed with status: ${response.statusCode}');
    //     print('Response body: ${response.body}');
    //     va = false;
    //   }
    // } on Exception catch (e) {
    //   loggerNoStack.e(e);
    // }
    return va;
  }

  static Future<void> getfoothistory(String from, String to) async {
    String? token = AppStateNotifier.instance.apiToken;
    String? uid = AppStateNotifier.instance.userdata?.uid;
    if (token == null || uid == null) {
      loggerNoStack.e('토큰이나 UID가 null입니다.');
      return;
    }

    var url = Uri.parse('$linkurl/users/$uid/footprints?from=$from&to=$to');
    var headers = {'accept': '*/*', 'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    loggerNoStack.t({'Name': 'getfoothistory', 'url': url});

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // 응답 데이터 디코딩 및 null 체크
      List<dynamic> responseData = jsonDecode(response.body)['data'] ?? [];
      loggerNoStack.i(responseData);

      // 응답 데이터가 null이 아니고 비어있지 않은지 확인
      if (responseData.isNotEmpty) {
        List<FootData> footHistory = responseData.map((data) => FootData.fromJson(data)).toList();
        await AppStateNotifier.instance.Upfoothistory(footHistory);
        await AppStateNotifier.instance.sortfootdata('new');
      } else {
        // 응답 데이터가 비어있는 경우 처리
        loggerNoStack.i('응답 데이터가 비어있습니다.');
      }
    } else {
      loggerNoStack.e(response.body);
    }
  }

  static Future<void> deleteSomePrint(String id) async {
    DateTime now = DateTime.now();
    String toDate = DateFormat('yyyy/MM/dd').format(now);
    DateTime monthsBefore = DateTime(now.year, now.month - 3, now.day);
    String fromDate = DateFormat('yyyy/MM/dd').format(monthsBefore);
    String? token = AppStateNotifier.instance.apiToken;
    String? uid = AppStateNotifier.instance.userdata?.uid;
    if (token == null || uid == null) {
      loggerNoStack.e('토큰이나 UID가 null입니다.');
      return;
    }

    var url = Uri.parse('$linkurl/users/$uid/footprints?id=$id');
    var headers = {'accept': '*/*', 'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    loggerNoStack.t({'Name': 'deleteSomePrint', 'url': url});

    var response = await http.delete(url, headers: headers);
    print(response.statusCode);

    if (response.statusCode == 200) {
      // 응답 데이터 디코딩 및 null 체크
      List<dynamic> responseData = jsonDecode(response.body)['data'] ?? [];
      loggerNoStack.i(responseData);
      await getfoothistory('${fromDate}', '${toDate}');
    } else {
      loggerNoStack.e(response.body);
    }
  }

  static Future<void> deleteSomeWegith(String? id) async {
    DateTime now = DateTime.now();
    String toDate = DateFormat('yyyy/MM/dd').format(now);
    DateTime monthsBefore = DateTime(now.year, now.month - 3, now.day);
    String fromDate = DateFormat('yyyy/MM/dd').format(monthsBefore);
    String? token = AppStateNotifier.instance.apiToken;
    String? uid = AppStateNotifier.instance.userdata?.uid;
    if (token == null || uid == null) {
      loggerNoStack.e('토큰이나 UID가 null입니다.');
      return;
    }

    var url = Uri.parse('$linkurl/users/$uid/weights?id=$id');
    var headers = {'accept': '*/*', 'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    loggerNoStack.t({'Name': 'deleteSomePrint', 'url': url});

    var response = await http.delete(url, headers: headers);
    print(response.statusCode);

    if (response.statusCode == 200) {
      // 응답 데이터 디코딩 및 null 체크
      List<dynamic> responseData = jsonDecode(response.body)['data'] ?? [];
      loggerNoStack.i(responseData);
      await getweighthistory('${fromDate}', '${toDate}');
    } else {
      loggerNoStack.e(response.body);
    }
  }

  static Future<void> deleteAllWegith() async {
    DateTime now = DateTime.now();
    String toDate = DateFormat('yyyy/MM/dd').format(now);
    DateTime monthsBefore = DateTime(now.year, now.month - 3, now.day);
    String fromDate = DateFormat('yyyy/MM/dd').format(monthsBefore);
    String? token = AppStateNotifier.instance.apiToken;
    String? uid = AppStateNotifier.instance.userdata?.uid;
    if (token == null || uid == null) {
      loggerNoStack.e('토큰이나 UID가 null입니다.');
      return;
    }

    var url = Uri.parse('$linkurl/users/$uid/weights?from=$fromDate&to=$toDate');
    var headers = {'accept': '*/*', 'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    loggerNoStack.t({'Name': 'deleteSomePrint', 'url': url});

    var response = await http.delete(url, headers: headers);
    print(response.statusCode);

    if (response.statusCode == 200) {
      // 응답 데이터 디코딩 및 null 체크
      List<dynamic> responseData = jsonDecode(response.body)['data'] ?? [];
      loggerNoStack.i(responseData);
      await getweighthistory('${fromDate}', '${toDate}');
    } else {
      loggerNoStack.e(response.body);
    }
  }

  static Future<void> getweighthistory(String from, String to) async {
    String? token = AppStateNotifier.instance.apiToken;
    String? uid = AppStateNotifier.instance.userdata?.uid;
    if (token == null || uid == null) {
      loggerNoStack.e('토큰이나 UID가 null입니다.');
      return;
    }
    var url = Uri.parse('$linkurl/users/$uid/weights?from=$from&to=$to');
    var headers = {'accept': '*/*', 'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);
    loggerNoStack.t({'Name': 'getweighthistory', 'url': url});
    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body)['data'];
      loggerNoStack.i(responseData);
      List<WeightData> WeightHistory = responseData.map((data) => WeightData.fromJson(data)).toList();
      calculateWeightChanges(WeightHistory);
      await AppStateNotifier.instance.UpWeightHistory(WeightHistory);
      await AppStateNotifier.instance.sortweightdata('old');
    } else {
      loggerNoStack.e(response.body);
    }
  }

  static void calculateWeightChanges(List<WeightData> weightDataList) {
    // 날짜 순서대로 정렬
    weightDataList.sort((a, b) => a.measuredTime.compareTo(b.measuredTime));

    for (int i = 1; i < weightDataList.length; i++) {
      weightDataList[i].weightChange = weightDataList[i].weight - weightDataList[i - 1].weight;
    }
  }
}
