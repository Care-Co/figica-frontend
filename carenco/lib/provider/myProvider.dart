

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BlueState with ChangeNotifier {
  String _connecttext = "연결하기";
  String get connecttext => _connecttext;

  String notconnetc = "연결하기";
  String ingconnetc = "연결중";
  String disingconnetc = "연결해제중";

  BluetoothDeviceState deviceState = BluetoothDeviceState.disconnected;

  Color _statecolor = Color(0xffF45B5A);
  Color get color => _statecolor;
  Color Disconnect = Color(0xffF45B5A);
  Color Connect = Color(0xFF27FF42);
  late ScanResult _scanresult;
  ScanResult get scanresult => _scanresult;
  StreamSubscription<BluetoothDeviceState>? _stateListener;

  setBleConnectionState(BluetoothDeviceState event) {
    //이전 상태 이벤트 저장
    deviceState = event;
    print('$event');
  }

  void connectstate(ScanResult scan) {
    _stateListener = scan.device.state.listen((event) {
      print('event :  $event');
      if (deviceState == event) {
        return;
      }
      changeState(event);
      setBleConnectionState(event);
      print('state=======================');
    });
    notifyListeners();
  }

  void changeState(BluetoothDeviceState state) {
    print("change---------------------------------\n");
    switch (state) {
      case BluetoothDeviceState.disconnected:
        _connecttext = notconnetc;
        _statecolor = Disconnect;
        break;
      case BluetoothDeviceState.disconnecting:
        _connecttext = disingconnetc;
        break;
      case BluetoothDeviceState.connected:
        _connecttext = _connecttext;
        _statecolor = Connect;
        break;
      case BluetoothDeviceState.connecting:
        _connecttext = ingconnetc;
        break;
    }
    print ("state----------------------");
    print('$state');
    notifyListeners();
  }

  void getscan(ScanResult scan) {
    _scanresult = scan;
    _connecttext = scan.device.name;
    notifyListeners();
  }

}

