// import 'package:flutter/material.dart';
// import 'package:web_rtc/service/webrtc_socket.dart';

// class ChatController extends WebRTCSocket {
//   String? to;
//   String? _from;
//   ValueNotifier<List<Map<String, dynamic>>> messagesNotifier =
//       ValueNotifier<List<Map<String, dynamic>>>([]);

//   Future<void> initController() async {
//     await _initSocket();
//   }

//   Future<void> sendMessage(String message) async {
//     if (to != null) {
//       super.socketEmit('message', {
//         'to': to,
//         'message': message,
//       });
//       messagesNotifier.value = List.from(messagesNotifier.value)
//         ..add({'message': message, 'isOwn': true});
//     }
//   }

//   void _receiveMessage(data) {
//     String message = data['message'];
//     messagesNotifier.value = List.from(messagesNotifier.value)
//       ..add({'message': message, 'isOwn': false});
//   }

//   void dispose() {
//     messagesNotifier.dispose();
//   }

  

  
//   /// [backend] ///
//   Future<void> _initSocket() async {
//     _from = await super.getUserId();
//     if (_from != null) {
//       super.socketOn('message', _receiveMessage);
//     }
//   }

// }
