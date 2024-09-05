import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:provider/provider.dart';
import 'package:fisica/index.dart';

class UnityWidgetWrapper extends StatefulWidget {
  final double height;
  const UnityWidgetWrapper({Key? key, required this.height}) : super(key: key);

  @override
  _UnityWidgetWrapperState createState() => _UnityWidgetWrapperState();
}

class _UnityWidgetWrapperState extends State<UnityWidgetWrapper> {
  UnityWidgetController? _unityWidgetController;
  double _currentValue = 1;
  Offset _startPosition = Offset.zero;
  Offset _currentPosition = Offset.zero;
  double _rotationValue = 0.0;

  @override
  void initState() {
    super.initState();
  }

  void onUnityCreated(controller) async {
    print("=================onUnityCreated");
    _unityWidgetController = controller;

    //await Future.delayed(Duration(seconds: 5));

    if (_unityWidgetController != null) {
      int currentClassType = AppStateNotifier.instance.footdata!.first.classType;

      await sendObjectType(currentClassType);
    } else {
      print("Unity controller is null after initialization delay.");
    }
  }

  void onUnityMessage(message) {
    print('Received message from Unity: $message');
    if (message.toString() == 'UnityInitialized') {}
  }

  Future<void> sendObjectType(int type) async {
    if (_unityWidgetController != null) {
      _unityWidgetController!.postMessage(
        'GameObject',
        'OnMessage',
        '{"action": "type", "intValue": $type}',
      );
      print('ObjectManager' + 'OnMessage' + '{"action": "type", "intValue": $type}');
    } else {
      print("sendObjectType: Unity controller is null, message not sent.");
    }
  }

  void sendTransparency(double alpha) {
    if (_unityWidgetController != null) {
      _unityWidgetController!.postMessage(
        'GameObject',
        'OnMessage',
        '{"action": "setTransparency", "floatvalue": $alpha}',
      );
    } else {
      print("sendTransparency: Unity controller is null, message not sent.");
    }
  }

  void setRotationValue(double angle) {
    if (_unityWidgetController != null) {
      _unityWidgetController!.postMessage(
        'GameObject',
        'OnMessage',
        '{"action": "angle", "floatvalue": $angle}',
      );
    } else {
      print("setRotationValue: Unity controller is null, message not sent.");
    }
  }

  void onUnitySceneLoaded(SceneLoaded? sceneInfo) {
    if (sceneInfo != null) {
      print('Received scene loaded from unity: ${sceneInfo.name}');
      print('Received scene loaded from unity buildIndex: ${sceneInfo.buildIndex}');
    }
  }

  @override
  void dispose() {
    _unityWidgetController?.dispose();
    _unityWidgetController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(
      builder: (context, appStateNotifier, child) {
        bool hasFootdata = appStateNotifier.footdata != null && appStateNotifier.footdata!.isNotEmpty;
        return Container(
          width: MediaQuery.of(context).size.width,
          height: widget.height,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              if (hasFootdata) ...[
                UnityWidget(
                  onUnityCreated: onUnityCreated,
                  onUnityMessage: onUnityMessage,
                  onUnitySceneLoaded: onUnitySceneLoaded,
                  fullscreen: false,
                  runImmediately: false,
                  unloadOnDispose: true,
                ),
                GestureDetector(
                  onHorizontalDragStart: (details) {
                    _startPosition = details.localPosition;
                  },
                  onHorizontalDragUpdate: (details) {
                    // 드래그한 만큼의 이동을 계산합니다.
                    double deltaX = details.delta.dx;

                    // 현재 회전 값에 이동 값을 누적합니다.
                    setState(() {
                      _rotationValue = (_rotationValue - deltaX) % 360;
                      if (_rotationValue < 0) {
                        _rotationValue += 360;
                      }
                    });

                    setRotationValue(_rotationValue);
                  },
                  onHorizontalDragEnd: (details) {
                    // 드래그가 끝났을 때의 위치로 업데이트합니다.
                    _startPosition = Offset.zero; // 초기화
                  },
                  child: UnityWidget(
                    onUnityCreated: onUnityCreated,
                    onUnityMessage: onUnityMessage,
                    onUnitySceneLoaded: onUnitySceneLoaded,
                    fullscreen: false,
                    runImmediately: false,
                    unloadOnDispose: true,
                  ),
                ),
                // Positioned(
                //   right: 70,
                //   top: 20,
                //   bottom: 20,
                //   child: RotatedBox(
                //     quarterTurns: -1,
                //     child: Slider(
                //       value: _currentValue,
                //       min: 0,
                //       max: 1,
                //       divisions: 100,
                //       label: _currentValue.toStringAsFixed(2),
                //       onChanged: (double value) {
                //         sendTransparency(value);
                //       },
                //     ),
                //   ),
                // ),
              ],
              if (!hasFootdata) ...[
                Positioned(
                  child: Container(
                    height: widget.height,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      'assets/images/footsheet.png',
                    ),
                  ),
                ),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Container(
                      height: 460,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        'assets/images/noavt.png',
                      ),
                    ),
                  ),
                ),
              ]
            ],
          ),
        );
      },
    );
  }
}
