import 'dart:convert';
import 'package:figica/User_Controller.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
  static List<History> parseHistories(String responseBody) {
    final parsedJson = json.decode(utf8.decode(responseBody.runes.toList()));
    final historiesJson = parsedJson['data']['groupHistories'] as List;
    return historiesJson.map<History>((json) => History.fromJson(json)).toList();
  }
}

class GroupMember {
  final String insertTime;
  final String? updateTime;
  final String deleteYn;
  final String? deleteTime;
  final String id;
  final String groupId;
  final String userUid;
  final String authority;
  final String name;
  final String? photoUrl;

  GroupMember({
    required this.insertTime,
    this.updateTime,
    required this.deleteYn,
    this.deleteTime,
    required this.id,
    required this.groupId,
    required this.userUid,
    required this.authority,
    required this.name,
    this.photoUrl,
  });

  factory GroupMember.fromJson(Map<String, dynamic> json) {
    return GroupMember(
      insertTime: json['insertTime'],
      updateTime: json['updateTime'],
      deleteYn: json['deleteYn'],
      deleteTime: json['deleteTime'],
      id: json['id'],
      groupId: json['groupId'],
      userUid: json['userUid'],
      authority: json['authority'],
      name: json['name'],
      photoUrl: json['photoUrl'],
    );
  }

  static List<GroupMember> parseGroupMember(String responseBody) {
    final parsedJson = json.decode(utf8.decode(responseBody.runes.toList()));
    final groupMemberJson = parsedJson['data']['groupMembers'] as List;
    return groupMemberJson.map<GroupMember>((json) => GroupMember.fromJson(json)).toList();
  }

  static List<GroupMember> parseGroupInvitation(String responseBody) {
    final parsedJson = json.decode(utf8.decode(responseBody.runes.toList()));
    final groupMemberJson = parsedJson['data']['groupMembers'] as List;
    return groupMemberJson.where((json) => json['authority'] != 'LEADER').map<GroupMember>((json) => GroupMember.fromJson(json)).toList();
  }
}

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

class GroupApi {
  static const _data = 'data';
  static Future<void> saveGroup(String data) async {
    print('save group');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_data, data);
  }

  static Future<String?> getGroup() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_data) == null) {
      return 'Null';
    } else {
      return prefs.getString(_data);
    }
  }

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

  static Future<void> updateGroupInvitationByGroupLeader(String type, String userUid) async {
    String? token = await UserController.getsavedToken();
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
    String? token = await UserController.getsavedToken();

    try {
      final url = Uri.parse("http://203.232.210.68:8080/api/groups/createInvitationCode");
      final headers = {"accept": "*/*", "Authorization": "Bearer $token", "Content-Type": "application/json"};
      final response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final groupInvitationCode = responseData['data']['invitationCode'];
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

//그룹 찾기
  static Future<String> findGroup() async {
    print('findGroup');
    String? token = await UserController.getsavedToken();
    final url = Uri.parse('http://203.232.210.68:8080/api/groups/findGroupTest');

    final response = await http.get(
      url,
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.body);
      return await getGroupInvitationByUser();
    }
  }

//초대했는지 여부 확인
  static Future<String> getGroupInvitationByUser() async {
    String? token = await UserController.getsavedToken();

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
    String? token = await UserController.getsavedToken();
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
  static Future<String> getGroupInvitations() async {
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
    String? token = await UserController.getsavedToken();

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

  static Future<void> removeMemberByGroupmember() async {
    String? token = await UserController.getsavedToken();

    String apiUrl = 'http://203.232.210.68:8080/api/groups/removeMemberByGroupmember';

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

  static Future<void> removeMemberByGroupleader(String memberUid) async {
    String? token = await UserController.getsavedToken();
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
    String? token = await UserController.getsavedToken();
    print(memberUid);

    final url = Uri.parse('http://203.232.210.68:8080/api/groups/updateGroup');
    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final data = {
      'newGroupName': memberUid,
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
    String? token = await UserController.getsavedToken();

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
