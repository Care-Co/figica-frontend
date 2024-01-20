import 'dart:convert';
import 'package:figica/User_Controller.dart';
import 'package:http/http.dart' as http;

class History {
  final String id;
  final String groupId;
  final String category;
  final String userUid;
  final String name;
  final String shortDescription;
  final String longDescription;
  final String date;

  History({
    required this.id,
    required this.groupId,
    required this.category,
    required this.userUid,
    required this.name,
    required this.shortDescription,
    required this.longDescription,
    required this.date,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      id: json['id'],
      groupId: json['groupId'],
      category: json['category'],
      userUid: json['userUid'],
      name: json['name'],
      shortDescription: json['shortDescription'],
      longDescription: json['longDescription'],
      date: json['date'],
    );
  }
}

class GroupApi {
  //그룹 생성
  static Future<bool> createGroup(String groupName) async {
    print('createGroup');
    String? token = await UserController.getsavedToken();

    try {
      final url = Uri.parse("http://203.232.210.68:8080/api/groups/createGroup");
      final headers = {"accept": "*/*", "Authorization": "Bearer $token", "Content-Type": "application/json"};
      final body = jsonEncode({"groupName": groupName});
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final newtoken = responseData['token'];
        print(newtoken);
        await UserController.setToken(newtoken);
        print('createGroup${response.body}');
        return true;
      } else {
        print('Failed to create group');
        print('Error: ${response.statusCode}');
        print('Error message: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error occurred: $e');
      return false;
    }
  }

  static List<History> parseHistories(String responseBody) {
    final parsedJson = json.decode(utf8.decode(responseBody.runes.toList()));
    final historiesJson = parsedJson['data']['histories'] as List;
    return historiesJson.map<History>((json) => History.fromJson(json)).toList();
  }

  static Future<String> createInvitationCode() async {
    print('getGroupInvitations');
    String? token = await UserController.getsavedToken();

    try {
      final url = Uri.parse("http://203.232.210.68:8080/api/groups/createInvitationCode");
      final headers = {"accept": "*/*", "Authorization": "Bearer $token", "Content-Type": "application/json"};
      final response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final groupInvitationCode = responseData['data']['invitationCode'];
        print('getGroupInvitations${response.body}');
        return groupInvitationCode;
      } else {
        print(response.body);
        return 'none';
      }
    } catch (e) {
      print('Error occurred: $e');
      return 'none';
    }
  }

  static Future<void> deleteGroup() async {
    String? token = await UserController.getsavedToken();
    final url = Uri.parse('http://203.232.210.68:8080/api/groups/deleteGroup');

    try {
      final response = await http.delete(
        url,
        headers: {'accept': '*/*', 'Authorization': "Bearer $token"},
      );

      if (response.statusCode == 200) {
        // 성공적인 응답 처리
        print('Group deleted successfully');
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        UserController.setToken(token);
      } else {
        // 에러 응답 처리
        print('Error: ${response.statusCode}');
        print('Error message: ${response.body}');
      }
    } catch (e) {
      // 예외 처리
      print('Error: $e');
    }
  }

//그룹 찾기(리더)
  static Future<String> findGroup() async {
    print('findGroup');
    String? token = await UserController.getsavedToken();
    final url = Uri.parse('http://203.232.210.68:8080/api/groups/findGroup');

    try {
      final response = await http.get(
        url,
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // 성공적인 응답 처리
        print('Group found successfully');
        print('Response: ${response.body}');
        return response.body;
      } else {
        // 에러 응답 처리
        print('Error: ${response.statusCode}');
        print('Error message: ${response.body}');
        return 'fail';
      }
    } catch (e) {
      // 예외 처리
      print('Error: $e');
      return 'fail';
    }
  }

//그룹찾기(게스트)
  static Future<Map<String, dynamic>> fetchGroupByInvitationCode(String invitationCode) async {
    String? token = await UserController.getsavedToken();
    final response = await http.get(
      Uri.parse('http://203.232.210.68:8080/api/groups/getGroupByInvitationCode?invitationCode=$invitationCode'),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      print(response.body);
      throw Exception('Failed to fetch group by invitation code');
    }
  }

//초대 생성
  static Future<void> createGroupInvitation(String invitationCode) async {
    String? token = await UserController.getsavedToken();

    final url = Uri.parse('http://203.232.210.68:8080/api/groups/createGroupInvitation');
    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final data = {
      'invitationCode': invitationCode,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(data),
    );

    if (response.statusCode == 201) {
      print('초대 요청이 성공하였습니다.');
      print(response.body);
    } else {
      print('초대 요청이 실패하였습니다. 상태 코드: ${response.statusCode}');
      throw Exception('Failed to join group');
    }
  }
//초대 내역 확인

  static Future<Map<String, dynamic>> getGroupInvitations() async {
    String? token = await UserController.getsavedToken();
    final url = Uri.parse('http://203.232.210.68:8080/api/groups/getGroupInvitationsByGroupLeader');
    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
    };

    final response = await http.post(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      print(response.body);
      throw Exception('Failed to getGroupInvitations ');
    }
  }

//초대 수락
  Future<void> updateGroupInvitation(String token, String status, String userUid) async {
    final url = Uri.parse('http://203.232.210.68:8080/api/groups/updateGroupInvitationByGroupLeader');
    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final data = {
      'status': status,
      'userUid': userUid,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      // 성공적으로 요청을 보냈습니다. 여기에서 추가적인 작업을 수행할 수 있습니다.
      print('HTTP POST 요청이 성공하였습니다.');
    } else {
      // 요청이 실패했을 때의 처리ㅇ
      print('HTTP POST 요청이 실패하였습니다. 상태 코드: ${response.statusCode}');
    }
  }

  //초대 보냈는지 확인
  static Future<Map<String, dynamic>> getGroupInvitationByUser() async {
    String? token = await UserController.getsavedToken();

    final url = Uri.parse('http://203.232.210.68:8080/api/groups/getGroupInvitationByUser');
    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
    };

    final response = await http.post(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      return responseBody;
    } else {
      throw Exception('HTTP POST 요청이 실패하였습니다. 상태 코드: ${response.statusCode}');
    }
  }

  //
  static String historytext(String text) {
    if (text == 'The group has been created.') {
      return '그룹 생성';
    } else if (text == 'A member has been added to the group.') {
      return '인원 추가';
    } else {
      return 'null';
    }
  }
}
