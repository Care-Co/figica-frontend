import 'package:flutter/material.dart';

class isconnectstate with ChangeNotifier{
  bool _isconnect = false;
  bool get isconnect => _isconnect;

  void changebool(bool isconnect){
    _isconnect = isconnect;
    notifyListeners();
  }
}