import 'package:fisica/models/webrtc/drawing_point.dart';
import 'package:fisica/utils/service/webrtc/webrtc_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'dart:ui' as ui;

class VideoCallView extends StatefulWidget {
  const VideoCallView({Key? key, this.controller}) : super(key: key);

  final WebRTCController? controller;

  @override
  State<VideoCallView> createState() => _VideoCallViewState();
}

class _VideoCallViewState extends State<VideoCallView> {
  late final WebRTCController _controller;
  final ValueNotifier<bool> _btnNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _colorPickerNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<Color?> _selectedColorNotifier = ValueNotifier<Color?>(null);

  List<DrawingPoint> points = [];

  @override
  void initState() {
    super.initState();
    _controller = widget.controller!;
    _controller.drawingGroupsNotifier.addListener(_updateDrawing);
    // _controller.setDrawingColor(_selectedColorNotifier.value); // 초기 색상 설정
  }

  @override
  void dispose() {
    _controller.drawingGroupsNotifier.removeListener(_updateDrawing);
    _btnNotifier.dispose();
    _colorPickerNotifier.dispose();
    _selectedColorNotifier.dispose();
    super.dispose();
  }

  void _updateDrawing() {
    setState(() {
      points = _controller.drawingGroupsNotifier.value.expand((group) => group.points).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller.webRTCVideoViewContext = context;

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              GestureDetector(
                onPanUpdate: (details) async {
                  if (_controller.currentColor != null) {
                    points.add(DrawingPoint(details.localPosition));
                    await _controller.sendDrawing(details.localPosition); // point만 전송
                  }
                },
                onPanEnd: (details) async {
                  if (_controller.currentColor != null) {
                    points.add(DrawingPoint(null));
                    await _controller.sendDrawingEnd();
                  }
                },
                child: CustomPaint(
                  painter: LinePainter(_controller.drawingGroupsNotifier.value),
                  child: Container(),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.only(top: 20, right: 20),
                  height: 160,
                  width: 120,
                  child: _videoWidget(_controller.remoteVideoNotifier, _controller.remoteRenderer!),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(top: 20, left: 20),
                  height: 160,
                  width: 120,
                  child: _videoWidget(_controller.localVideoNotifier, _controller.localRenderer!),
                ),
              ),
              _controlButtons(),
              _colorPickerWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _videoWidget(ValueNotifier<bool> listener, RTCVideoRenderer renderer) {
    return ValueListenableBuilder<bool>(
      valueListenable: listener,
      builder: (_, value, __) {
        return value
            ? RTCVideoView(
                renderer,
                objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
              )
            : const Center(
                child: Icon(Icons.person_off),
              );
      },
    );
  }

  Widget _controlButtons() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () async {
                setState(() {
                  if (_controller.localStream != null) {
                    _controller.toggleMuteV();
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
                if (_controller.checkStream()) {
                  setState(() {
                    _controller.toggleVideo();
                  });
                }
              },
              child: CircleAvatar(
                backgroundColor: _controller.isVideoOn ? Colors.green : Colors.red,
                foregroundColor: Colors.white,
                child: Icon(
                  _controller.isVideoOn ? Icons.videocam : Icons.videocam_off,
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                await _controller.closeVideoCall(null);
              },
              child: const CircleAvatar(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                child: Icon(Icons.call_end),
              ),
            ),
            InkWell(
              onTap: () {
                _colorPickerNotifier.value = !_colorPickerNotifier.value;
              },
              child: const CircleAvatar(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                child: Icon(Icons.create),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _colorPickerWidget() {
    return ValueListenableBuilder<bool>(
      valueListenable: _colorPickerNotifier,
      builder: (_, visible, __) => visible
          ? Positioned(
              bottom: 120,
              left: MediaQuery.of(context).size.width / 2 - 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _undoButton(),
                  _resetButton(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _colorButton(Colors.red),
                      const SizedBox(width: 10),
                      _colorButton(Colors.white),
                      const SizedBox(width: 10),
                      _colorButton(Colors.black),
                      const SizedBox(width: 10),
                      _colorButton(const Color(0xFFB4BED9)),
                    ],
                  ),
                ],
              ),
            )
          : const SizedBox(),
    );
  }

  Widget _undoButton() {
    return InkWell(
      onTap: () async {
        await _controller.undoLastDrawing();
      },
      child: const CircleAvatar(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        child: Icon(Icons.undo),
      ),
    );
  }

  Widget _resetButton() {
    return InkWell(
      onTap: () {
        setState(() {
          points.clear();
          _controller.drawingGroupsNotifier.value = [];
        });
        _controller.sendClearDrawing();
      },
      child: const CircleAvatar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget _colorButton(Color color) {
    return ValueListenableBuilder<Color?>(
      valueListenable: _selectedColorNotifier,
      builder: (_, selectedColor, __) {
        return InkWell(
          onTap: () {
            _selectedColorNotifier.value = color;
            _controller.setDrawingColor(color); // 서버에 색상 전송
          },
          child: CircleAvatar(
            backgroundColor: color,
            radius: 20,
            child: selectedColor == color
                ? Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class LinePainter extends CustomPainter {
  final List<DrawingGroup> groups;

  LinePainter(this.groups);

  @override
  void paint(Canvas canvas, Size size) {
    for (var group in groups) {
      final paint = Paint()
        ..color = group.color
        ..strokeWidth = 4.0
        ..style = PaintingStyle.stroke;

      for (int i = 0; i < group.points.length - 1; i++) {
        if (group.points[i].point != null && group.points[i + 1].point != null) {
          canvas.drawLine(group.points[i].point!, group.points[i + 1].point!, paint);
        } else if (group.points[i].point != null && group.points[i + 1].point == null) {
          canvas.drawPoints(ui.PointMode.points, [group.points[i].point!], paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
