import 'package:fisica/utils/service/webrtc/webrtc_controller.dart';
import 'package:fisica/views/webrtc/audio_call_view.dart';
import 'package:fisica/views/webrtc/chat_view.dart';
import 'package:fisica/views/webrtc/video_call_view.dart';
import 'package:flutter/material.dart';

class WebRTCMainView extends StatefulWidget {
  final WebRTCController controller;

  const WebRTCMainView({Key? key, required this.controller}) : super(key: key);

  @override
  State<WebRTCMainView> createState() => _WebRTCMainViewState();
}

class _WebRTCMainViewState extends State<WebRTCMainView> {
  late final WebRTCController _controller;
  String? targetUserId;
  String targetRole = "Client";
  String targetStatus = "offline";
  bool showOptions = false;
  bool isTargetInChat = false;
  bool callRequestReceived = false; // 통화 요청 상태를 관리

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;

    _controller.userListNotifier.addListener(_updateUserStatus);
    _controller.screenNotifier.addListener(_handleCallRequest); // 통화 요청 처리

    _controller.initController().then((_) {
      _controller.initializeUserStatus(); // 상태 초기화
      _updateUserStatus(); // 상태 업데이트
    });
  }

  @override
  void dispose() {
    _controller.userListNotifier.removeListener(_updateUserStatus);
    _controller.screenNotifier.removeListener(_handleCallRequest);
    _controller.dispose();
    super.dispose();
  }

  void _handleCallRequest() {
    if (_controller.screenNotifier.value == ScreenState.receivedCalling) {
      setState(() {
        callRequestReceived = true;
      });
    }
  }

  void _updateUserStatus() {
    String oppositeRole = _controller.role == 'expert' ? 'client' : 'expert';
    bool isUserOnline = false;

    for (var user in _controller.userListNotifier.value) {
      if (user['role'] == oppositeRole) {
        targetUserId = user['userId']; // 상대방의 userId를 저장
        targetRole = oppositeRole;
        isUserOnline = true;
        isTargetInChat = user['inChat'] ?? false; // inChat 상태 확인
        break;
      }
    }

    setState(() {
      targetStatus = isUserOnline ? "online" : "offline";
    });
  }

  @override
  Widget build(BuildContext context) {
    final double buttonSize = MediaQuery.of(context).size.width * 0.15; // 버튼 크기 조정

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (callRequestReceived) _buildCallRequestWidget(), // 변경된 부분
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey, width: 1.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(
                    _controller.role == 'expert' ? 'Client' : 'Expert',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Status: $targetStatus',
                    style: TextStyle(color: targetStatus == 'online' ? Colors.green : Colors.red),
                  ),
                  onTap: _toggleOptions,
                ),
              ),
              if (showOptions) _buildOptions(context, buttonSize),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCallRequestWidget() {
    return _controller.audioOnly ? _buildAudioCallRequestWidget() : _buildVideoCallRequestWidget();
  }

  Widget _buildAudioCallRequestWidget() {
    return Container(
      color: Colors.yellow[100],
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [
          const Text(
            '음성 통화 요청이 왔습니다',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Text('수락하시겠습니까?'),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  _controller.sendAnswer();
                  _moveToAudioCallView(); // 오디오 통화 화면으로 이동
                  setState(() {
                    callRequestReceived = false;
                  });
                },
                icon: const Icon(Icons.check),
                label: const Text('수락'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
              const SizedBox(width: 20),
              ElevatedButton.icon(
                onPressed: () {
                  _controller.refuseAudioOffer();
                  setState(() {
                    callRequestReceived = false;
                  });
                },
                icon: const Icon(Icons.close),
                label: const Text('거절'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCallRequestWidget() {
    return Container(
      color: Colors.yellow[100],
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [
          const Text(
            '영상 통화 요청이 왔습니다',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Text('수락하시겠습니까?'),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  _controller.sendAnswer();
                  _moveToVideoView(); // 비디오 통화 화면으로 이동
                  setState(() {
                    callRequestReceived = false;
                  });
                },
                icon: const Icon(Icons.check),
                label: const Text('수락'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
              const SizedBox(width: 20),
              ElevatedButton.icon(
                onPressed: () {
                  _controller.refuseVideoOffer();
                  setState(() {
                    callRequestReceived = false;
                  });
                },
                icon: const Icon(Icons.close),
                label: const Text('거절'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _toggleOptions() {
    setState(() {
      showOptions = !showOptions;
    });
  }

  Widget _buildOptions(BuildContext context, double buttonSize) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildOptionButton(
              icon: Icons.phone,
              onPressed: () {
                if (targetUserId != null) {
                  _controller.to = targetUserId!;
                  _controller.sendAudioCallOffer();
                  _moveToAudioCallView();
                }
              },
              size: buttonSize,
            ),
            _buildOptionButton(
              icon: Icons.videocam,
              onPressed: () {
                if (targetUserId != null) {
                  _controller.to = targetUserId!;
                  _controller.sendVideoCallOffer();
                  _moveToVideoView();
                }
              },
              size: buttonSize,
            ),
            _buildOptionButton(
              icon: Icons.chat,
              onPressed: () {
                _enterChatRoom(context);
              },
              size: buttonSize,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOptionButton({required IconData icon, required VoidCallback onPressed, required double size}) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Icon(icon, size: size * 0.5),
      ),
    );
  }

  void _moveToVideoView() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VideoCallView(controller: _controller),
      ),
    ).whenComplete(() {
      _controller.screenNotifier.value = ScreenState.initDone;
    });
  }

  void _moveToAudioCallView() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AudioCallView(controller: _controller),
      ),
    ).whenComplete(() {
      _controller.screenNotifier.value = ScreenState.initDone;
    });
  }

  void _enterChatRoom(BuildContext context) {
    if (targetUserId != null) {
      _controller.to = targetUserId!; // 상대방의 userId를 to에 설정
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatView(controller: _controller),
      ),
    );
  }
}
