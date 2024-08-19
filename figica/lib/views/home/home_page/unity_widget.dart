import 'package:fisica/utils/Data_Notifire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:provider/provider.dart';
import 'package:fisica/index.dart';
import 'package:fisica/models/FootData.dart';
import 'package:fisica/utils/TypeManager.dart';

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
    await Future.delayed(Duration(seconds: 5));
    print('=============11111111111==============');
    int currentClassType = AppStateNotifier.instance.footdata!.first.classType;
    await Future.delayed(Duration(seconds: 5));
    print('=============222222222==============');

    await sendObjectType(currentClassType);
  }

  void onUnityMessage(message) {
    print('Received message from Unity: $message');
    if (message.toString() == 'UnityInitialized') {}
  }

  void sendTransparency(double alpha) {
    setState(() {
      _currentValue = alpha;
    });
    if (_unityWidgetController != null) {
      _unityWidgetController!.postMessage(
        'ObjectManager',
        'OnMessage',
        '{"action": "setTransparency", "floatvalue": $alpha}',
      );
    }
  }

  void setRotationValue(double angle) {
    setState(() {
      _rotationValue = angle;
    });
    if (_unityWidgetController != null) {
      _unityWidgetController!.postMessage(
        'ObjectManager',
        'OnMessage',
        '{"action": "angle", "floatvalue": $angle}',
      );
    }
  }

  Future<void> sendObjectType(int type) async {
    if (_unityWidgetController != null) {
      _unityWidgetController!.postMessage(
        'ObjectManager',
        'OnMessage',
        '{"action": "type", "intValue": $type}',
      );
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
              GestureDetector(
                onHorizontalDragStart: (details) {
                  _startPosition = details.localPosition;
                },
                onHorizontalDragUpdate: (details) {
                  _currentPosition = details.localPosition;
                  double deltaX = _startPosition.dx - _currentPosition.dx;
                  double newRotationValue = _rotationValue + deltaX;
                  if (newRotationValue < 0) {
                    newRotationValue += 360;
                  }
                  newRotationValue %= 360;
                  setRotationValue(newRotationValue);
                  _startPosition = _currentPosition;
                },
                onHorizontalDragEnd: (details) {},
                child: UnityWidget(
                  onUnityCreated: onUnityCreated,
                  onUnityMessage: onUnityMessage,
                  onUnitySceneLoaded: onUnitySceneLoaded,
                  fullscreen: false,
                  runImmediately: false,
                  unloadOnDispose: true,
                ),
              ),
              Positioned(
                right: 70,
                top: 20,
                bottom: 20,
                child: RotatedBox(
                  quarterTurns: -1,
                  child: Slider(
                    value: _currentValue,
                    min: 0,
                    max: 1,
                    divisions: 100,
                    label: _currentValue.toStringAsFixed(2),
                    onChanged: (double value) {
                      sendTransparency(value);
                    },
                  ),
                ),
              ),
              if (!hasFootdata)
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
            ],
          ),
        );
      },
    );
  }
}
