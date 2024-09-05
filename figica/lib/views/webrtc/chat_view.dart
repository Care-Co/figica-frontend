import 'package:fisica/utils/service/webrtc/webrtc_controller.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  final WebRTCController controller;

  const ChatView({Key? key, required this.controller}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.controller.messagesNotifier.addListener(_updateChat);
  }

  @override
  void dispose() {
    widget.controller.messagesNotifier.removeListener(_updateChat);
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _updateChat() {
    setState(() {});
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      widget.controller.sendMessage(message);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: widget.controller.messagesNotifier.value.length,
              itemBuilder: (context, index) {
                final message = widget.controller.messagesNotifier.value[index];
                final isOwnMessage = message['isOwn'] ?? false;
                return Align(
                  alignment: isOwnMessage ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: isOwnMessage ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      message['message'],
                      style: TextStyle(color: isOwnMessage ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your message',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:web_rtc/service/webrtc_controller.dart';


// class ChatView extends StatefulWidget {
//   final WebRTCController? controller;

//   const ChatView({Key? key, required this.controller}) : super(key: key);

//   @override
//   State<ChatView> createState() => _ChatViewState();
// }

// class _ChatViewState extends State<ChatView> {
//   late final WebRTCController _controller;
//   final TextEditingController _messageController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     _controller = widget.controller!;
//     _controller.messagesNotifier.addListener(_updateChat);
//   }

//   @override
//   void dispose() {
//     _controller.messagesNotifier.removeListener(_updateChat);
//     _messageController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _updateChat() {
//     setState(() {});
//     _scrollController.animateTo(
//       _scrollController.position.maxScrollExtent,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeOut,
//     );
//   }

//   void _sendMessage() {
//     final message = _messageController.text.trim();
//     if (message.isNotEmpty) {
//       _controller.sendMessage(message);
//       _messageController.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Chat'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               controller: _scrollController,
//               itemCount: _controller.messagesNotifier.value.length,
//               itemBuilder: (context, index) {
//                 final message = _controller.messagesNotifier.value[index];
//                 final isOwnMessage = message['isOwn'] ?? false;
//                 return Align(
//                   alignment: isOwnMessage ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
//                     padding: const EdgeInsets.all(10.0),
//                     decoration: BoxDecoration(
//                       color: isOwnMessage ? Colors.blue : Colors.grey[300],
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child: Text(
//                       message['message'],
//                       style: TextStyle(color: isOwnMessage ? Colors.white : Colors.black),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: const InputDecoration(
//                       hintText: 'Enter your message',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
