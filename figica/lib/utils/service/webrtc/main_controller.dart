// import 'package:flutter/material.dart';
// import 'package:web_rtc/service/webrtc_socket.dart';

// class MainController extends WebRTCSocket {
//   String? role;
//   String? _from;

//   /// 유저 리스트 처리용
//   ValueNotifier<List<Map<String, dynamic>>> userListNotifier =
//       ValueNotifier<List<Map<String, dynamic>>>([]);

//   /// [_initSocket] 소켓 초기화
//   Future<void> initController() async {
//     _from = await super.getUserId();
//     if (_from != null) {
//       super.socketOn('updateUserlist', _updateUserList);
//       super.socketEmit('requestUserlist', null);
//     }
//   }

//   /// 역할 설정 함수
//   void setRole(String newRole) {
//     role = newRole;
//     if (_from != null) {
//       super.socketEmit('setRole', {'role': role});
//     }
//   }

//   /// [소켓] 유저가 로그인/로그아웃 일때마다 업데이트
//   void _updateUserList(data) {
//     debugPrint('[socket] userList update $data');
//     Map<String, dynamic> map = Map.castFrom(data);
//     List<Map<String, dynamic>> list = List<Map<String, dynamic>>.from(map['userList']);
//     list.removeWhere((element) => element['userId'] == super.user);
//     userListNotifier.value = list;
//   }

//   void dispose() {
//     userListNotifier.dispose();
//   }
// }
