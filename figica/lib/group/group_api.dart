import 'dart:convert';
import 'package:figica/login/token.dart';
import 'package:http/http.dart' as http;

class GroupApi {
  //그룹 생성
  static Future<String> createGroup(String groupName) async {
    print('createGroup');
    String? token = await AuthStorage.getsavedToken();
    print(token);

    try {
      final url = Uri.parse("http://203.232.210.68:8080/api/groups/createGroup");
      final headers = {"accept": "*/*", "Authorization": "Bearer $token", "Content-Type": "application/json"};
      final body = jsonEncode({"groupName": groupName});
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        final groupInvitationCode = responseData['data']['groupInvitationCode'];
        AuthStorage.setToken(token);
        return groupInvitationCode;
      } else {
        print('Failed to create group: ${response.statusCode}');
        return 'none';
      }
    } catch (e) {
      print('Error occurred: $e');
      return 'none';
    }
  }
}
