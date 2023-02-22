

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BlueState with ChangeNotifier {
  BluetoothDeviceState deviceState = BluetoothDeviceState.disconnected;
  StreamSubscription<BluetoothDeviceState>? _stateListener;

  Color _stateText = Color(0xffF45B5A);
  Color get state => _stateText;

  Color Disconnect = Color(0xffF45B5A);
  Color Connect = Color(0xFF27FF42);

  void changeColor(String state) {
    print("change---------------------------------\n");
    if (state == 'Disconnect'){
      _stateText = Disconnect;
    }
    else{
      _stateText = Connect;
    }
    notifyListeners();
  }
}

