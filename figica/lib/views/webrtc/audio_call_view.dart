import 'package:fisica/utils/service/webrtc/webrtc_controller.dart';
import 'package:flutter/material.dart';

class AudioCallView extends StatefulWidget {
  final WebRTCController? controller;

  // const AudioCallView({Key? key, required this.controller}) : super(key: key);
  const AudioCallView({Key? key, this.controller}) : super(key: key);

  @override
  State<AudioCallView> createState() => _AudioCallViewState();
}

class _AudioCallViewState extends State<AudioCallView> {
  late final WebRTCController _controller;
  // bool isMuted = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller!;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.audioCallViewContext = context;
    String role = _controller.role == 'expert' ? 'Client' : 'Expert';
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                role,
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(height: 50),
              _controlButtons(), // 컨트롤 버튼 위젯 호출
            ],
          ),
        ),
      ),
    );
  }

  Widget _controlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () async {
            setState(() {
              if (_controller.localStream != null) {
                _controller.toggleMuteA();
              }
            });
          },
          child: CircleAvatar(
            backgroundColor: _controller.isAudioOn ? Colors.green : Colors.red,
            foregroundColor: Colors.white,
            child: Icon(
              _controller.isAudioOn ? Icons.mic : Icons.mic_off,
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            await _controller.closeAudioCall(null);
          },
          child: const CircleAvatar(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            child: Icon(Icons.call_end),
          ),
        ),
      ],
    );
  }
}
