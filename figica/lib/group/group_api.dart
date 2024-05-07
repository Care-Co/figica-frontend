import 'dart:convert';
import 'package:fisica/main.dart';
import 'package:fisica/view_models/provider.dart';

import 'package:fisica/models/GroupData.dart';
import 'package:fisica/models/GroupHistory.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GroupCheckList {
  final String id;
  final String groupId;
  final String userUid;
  final bool humanHeight;
  final bool humanWeight;
  final bool humanFootprint;
  final bool schedule;

  GroupCheckList({
    required this.id,
    required this.groupId,
    required this.userUid,
    required this.humanHeight,
    required this.humanWeight,
    required this.humanFootprint,
    required this.schedule,
  });

  factory GroupCheckList.fromJson(Map<String, dynamic> json) {
    return GroupCheckList(
      id: json['id'] ?? '',
      groupId: json['groupId'] ?? '',
      userUid: json['userUid'] ?? '',
      humanHeight: json['humanHeight'] ?? false,
      humanWeight: json['humanWeight'] ?? false,
      humanFootprint: json['humanFootprint'] ?? false,
      schedule: json['schedule'] ?? false,
    );
  }
  static List<GroupCheckList> parseGroupCheckList(String responseBody) {
    final parsedJson = json.decode(utf8.decode(responseBody.runes.toList()));
    final groupCheckListJson = parsedJson['data']['groupCheckLists'] as List;
    return groupCheckListJson.map<GroupCheckList>((json) => GroupCheckList.fromJson(json)).toList();
  }
}

class GroupInvitation {
  final String insertTime;
  final String? updateTime;
  final String deleteYn;
  final String? deleteTime;
  final String id;
  final String groupInvitationCode;
  final String groupId;
  final String groupName;
  final String requestUid;
  final String requestUserName;
  final String status;

  GroupInvitation({
    required this.insertTime,
    this.updateTime,
    required this.deleteYn,
    this.deleteTime,
    required this.id,
    required this.groupInvitationCode,
    required this.groupId,
    required this.groupName,
    required this.requestUid,
    required this.requestUserName,
    required this.status,
  });

  factory GroupInvitation.fromJson(Map<String, dynamic> json) {
    return GroupInvitation(
      insertTime: json['insertTime'],
      updateTime: json['updateTime'],
      deleteYn: json['deleteYn'],
      deleteTime: json['deleteTime'],
      id: json['id'],
      groupInvitationCode: json['groupInvitationCode'],
      groupId: json['groupId'],
      groupName: json['groupName'],
      requestUid: json['requestUid'],
      requestUserName: json['requestUserName'],
      status: json['status'],
    );
  }
  static List<GroupInvitation> parseGroupInvitation(String responseBody) {
    final parsedJson = json.decode(utf8.decode(responseBody.runes.toList()));
    final groupInvitationJson = parsedJson['data'] as List;
    return groupInvitationJson.where((json) => json['status'] == 'PENDING').map<GroupInvitation>((json) => GroupInvitation.fromJson(json)).toList();
  }

  static List<GroupInvitation> allGroupInvitation(String responseBody) {
    final parsedJson = json.decode(utf8.decode(responseBody.runes.toList()));
    final groupInvitationallJson = parsedJson['data'] as List;
    return groupInvitationallJson.map<GroupInvitation>((json) => GroupInvitation.fromJson(json)).toList();
  }
}

//-----------------------------------------GroupApi-----------------------------------------//
class GroupApi {
  static Future<void> findGroup() async {
    String? token = AppStateNotifier.instance.apiToken;

    String? uid = AppStateNotifier.instance.userdata?.uid;
    final url = Uri.parse('http://203.232.210.68:8080/api/v1/users/$uid/groups');
    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    loggerNoStack.t({'Name': 'findGroup', 'url': url});
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final jsonBody = json.decode(responseBody);
      loggerNoStack.i(jsonBody);

      if (jsonBody['data'] != null && jsonBody['data'].isNotEmpty) {
        List<GroupData> data = (jsonBody['data'] as List).map((m) => GroupData.fromJson(m)).toList();
        AppStateNotifier.instance.UpGroupData(data);
      } else {
        loggerNoStack.w('No group');
      }
    } else {
      loggerNoStack.e(response.body);
    }
  }

  static Future<void> GroupHistoryData() async {
    String? token = AppStateNotifier.instance.apiToken;
    String? uid = AppStateNotifier.instance.userdata?.uid;
    String? groupId = AppStateNotifier.instance.groupData?.first.groupId;

    final url = Uri.parse('http://203.232.210.68:8080/api/v1/users/$uid/history/$groupId');
    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final response = await http.get(url, headers: headers);
    loggerNoStack.t({'Name': 'GroupHistoryData', 'url': url});

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final jsonBody = json.decode(responseBody);
      loggerNoStack.i(jsonBody);
      List<GroupHistory> data = (jsonBody as List).map((m) => GroupHistory.fromJson(m)).toList();

      await AppStateNotifier.instance.UpGroupHistory(data);
    } else {
      loggerNoStack.e(response.body);
    }
  }

  //그룹 생성
  static Future<bool> createGroup(String groupName) async {
    String? token = AppStateNotifier.instance.apiToken;
    String? uid = AppStateNotifier.instance.userdata?.uid;

    final url = Uri.parse("http://203.232.210.68:8080/api/v1/users/$uid/groups");
    final headers = {"accept": "*/*", "Authorization": "Bearer $token", "Content-Type": "application/json"};
    final body = jsonEncode({"groupName": groupName});
    final response = await http.post(url, headers: headers, body: body);
    loggerNoStack.t({'Name': 'createGroup', 'url': url});

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      loggerNoStack.i(responseData);
      await findGroup();
      await GroupHistoryData();
      return true;
    } else {
      loggerNoStack.e(response.body);

      return false;
    }
  }

  static Future<void> deleteGroup() async {
    print('RemoveGroup');
    String? token = AppStateNotifier.instance.apiToken;
    String? uid = AppStateNotifier.instance.userdata?.uid;
    String? groupId = AppStateNotifier.instance.groupData?.first.groupId;
    print(groupId);

    final url = Uri.parse('http://203.232.210.68:8080/api/v1/users/$uid/groups/$groupId');
    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    loggerNoStack.t({'Name': 'GroupHistoryData', 'url': url});

    final response = await http.delete(url, headers: headers);
    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final jsonBody = json.decode(responseBody);
      loggerNoStack.i(jsonBody);
    } else {
      final responseBody = utf8.decode(response.bodyBytes);
      final jsonBody = json.decode(responseBody);
      loggerNoStack.e(jsonBody);
    }
  }

  // static Future<void> removeMemberByGroupmember() async {
  //   print('RemoveGroup');
  //   String? token = await UserController.getsavedToken();
  //   String? uid = await DataController.getuseruid();
  //   String? groupId = await GroupStorageManager.loadGroupId();
  //   print(token);
  //   try {
  //     final url = Uri.parse('http://203.232.210.68:8080/api/v1/users/$uid/groups/$groupId');
  //     final headers = {
  //       'accept': '*/*',
  //       'Authorization': 'Bearer $token',
  //       'Content-Type': 'application/json',
  //     };
  //     final response = await http.delete(url, headers: headers);
  //     if (response.statusCode == 201) {
  //       final responseData = jsonDecode(response.body);
  //       print('RemoveGroup response${responseData}');
  //     } else {
  //       print('Error: ${response.statusCode}');
  //       print('Error message: ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Error occurred: $e');
  //   }
  // }

  static Future<void> updateGroupInvitationByGroupLeader(String type, String userUid) async {
    String? token = AppStateNotifier.instance.apiToken;
    final apiUrl = Uri.parse('http://203.232.210.68:8080/api/groups/updateGroupInvitationByGroupLeader');
    final headers = {"accept": "*/*", "Authorization": "Bearer $token", "Content-Type": "application/json"};
    final body = jsonEncode({"status": type, "userUid": userUid});

    final response = await http.post(apiUrl, headers: headers, body: body);

    print(body);

    if (response.statusCode == 200) {
      print('Request successful');
      print('Response body: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  static Future<String> createInvitationCode() async {
    print('createInvitationCode');
    String? token = AppStateNotifier.instance.apiToken;
    String? uid = AppStateNotifier.instance.userdata?.uid;
    String? groupId = AppStateNotifier.instance.groupData?.first.groupId;
    try {
      final url = Uri.parse("http://203.232.210.68:8080/api/v1/users/$uid/groups/$groupId/invitation-codes");
      final headers = {"accept": "*/*", "Authorization": "Bearer $token", "Content-Type": "application/json"};
      final response = await http.post(url, headers: headers);
      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final groupInvitationCode = responseData['data']['code'];
        print('createInvitationCode${response.body}');
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

//초대했는지 여부 확인
  static Future<String> getGroupInvitationByUser() async {
    String? token = AppStateNotifier.instance.apiToken;
    print('getGroupInvitationByUser');
    final url = Uri.parse('http://203.232.210.68:8080/api/groups/getGroupInvitationByUser');
    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
    };

    final response = await http.post(
      url,
      headers: headers,
      body: '',
    );
    if (response.statusCode == 200) {
      return 'waiting';
    } else {
      print(response.body);
      return 'fail';
    }
  }

  static Future<String> fetchGroupByInvitationCode(String invitationCode) async {
    String? token = AppStateNotifier.instance.apiToken;
    final response = await http.get(
      Uri.parse('http://203.232.210.68:8080/api/groups/getGroupByInvitationCode?invitationCode=$invitationCode'),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var groupData = utf8.decode(response.bodyBytes);

      return groupData;
    } else {
      print(response.body);
      throw Exception('Failed to fetch group by invitation code');
    }
  }

//초대 생성
  static Future<void> createGroupInvitation(String invitationCode) async {
    String? token = AppStateNotifier.instance.apiToken;

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
  static Future<String> getGroupInvitations() async {
    String? token = AppStateNotifier.instance.apiToken;
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
      return response.body;
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
      print('HTTP POST 요청이 성공하였습니다.');
    } else {
      print('HTTP POST 요청이 실패하였습니다. 상태 코드: ${response.statusCode}');
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

  static Future<void> updateGroupInvitationByUser(int status) async {
    String? token = AppStateNotifier.instance.apiToken;

    final url = Uri.parse('http://203.232.210.68:8080/api/groups/updateGroupInvitationByUser');
    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final data = {
      'status': status,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      print(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      print('초대 삭제 실패하였습니다. 상태 코드: ${response.statusCode}');
    }
  }

  static Future<void> removeMemberByGroupleader(String memberUid) async {
    String? token = AppStateNotifier.instance.apiToken;
    print(memberUid);

    String apiUrl = 'http://203.232.210.68:8080/api/groups/removeMemberByGroupleader?memberUid=$memberUid';

    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('Request successful');
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  static Future<void> updateGroupLeader(String memberUid) async {
    String? token = AppStateNotifier.instance.apiToken;
    print(memberUid);

    final url = Uri.parse('http://203.232.210.68:8080/api/groups/updateGroup');
    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final data = {
      'newGroupLeaderUid': memberUid,
    };

    final response = await http.put(
      url,
      headers: headers,
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      print(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      print('updateGroupLeader 실패하였습니다. 상태 코드: ${response.statusCode}');
    }
  }

  static Future<void> updateGroupName(String name) async {
    String? token = AppStateNotifier.instance.apiToken;

    final url = Uri.parse('http://203.232.210.68:8080/api/groups/updateGroup');
    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final data = {
      'newGroupName': name,
    };

    final response = await http.put(
      url,
      headers: headers,
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      print(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      print('updateGroupName 실패하였습니다. 상태 코드: ${response.statusCode}');
    }
  }
}
