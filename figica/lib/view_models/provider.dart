import 'package:fisica/index.dart';
import 'package:fisica/main.dart';
import 'package:fisica/models/FootData.dart';
import 'package:fisica/models/GroupData.dart';
import 'package:fisica/models/GroupHistory.dart';
import 'package:fisica/models/UserData.dart';
import 'package:fisica/models/WeightData.dart';
import 'package:fisica/scan/Foot_Controller.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();
  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();
  BaseAuthUser? initialUser;
  bool showSplashImage = true;
  String? _token;
  UserData? _userdata;
  List<FootData>? _footdata;
  List<WeightData>? _WeightData;
  List<GroupHistory>? _groupHistory;

  Map<String, dynamic>? _Scandata;
  List<GroupData>? _groupData;
  String _test = 'Default';

  //-------------//
  String get test => _test;
  String? get apiToken => _token;
  UserData? get userdata => _userdata;
  List<FootData>? get footdata => _footdata;
  List<WeightData>? get weightData => _WeightData;
  List<GroupData>? get groupData => _groupData;
  List<GroupHistory>? get groupHistroy => _groupHistory;

  Map<String, dynamic>? get scandata => _Scandata;
  bool get loggedIn => _token != null;
  bool get isGroup => _groupData != null;
  List<Member>? get member => _groupData?.first.members;

  static get http => null;
  bool isLoading = false;

  //-------------------Shared Preferences Helper------------------//

  String groupStatus = '';
  void printprov(String text) {
    print('\x1B[33m$text\x1B[0m');
  }

  Future<void> uptest() async {
    _test = 'up';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('_test', 'up2');
    notifyListeners();
  }

  Future<void> downtest() async {
    _test = 'down';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('_test', 'down1');
    notifyListeners();
  }

  //-------------------Shared Preferences Helper------------------//
  Future<void> api() async {
    printprov('-------------------------------------get all api--------------------------------------');
    final now = DateTime.now();
    printprov('-------------------------------------족저압 히스토리 api--------------------------------------');
    await FootprintApi.getfoothistory('${now.year}', '${4}');
    printprov('-------------------------------------체중 히스토리 api--------------------------------------');
    await FootprintApi.getweighthistory('${now.year}', '${4}');
    printprov('------------------------------------유저 프로파일 api--------------------------------------');
    await UserController.getprofile(_token!);
    printprov('-------------------------------------그룹 유무 api--------------------------------------');
    await GroupApi.findGroup();
    printprov('-------------------------------------그룹 히스토리 api--------------------------------------');
    await GroupApi.GroupHistoryData();
    printprov('-------------------------------------end api--------------------------------------');
  }

  Future<void> loadSaveUserData() async {
    printprov('------------------------------------------load Saved User Data-------------------------------------------');
    final prefs = await SharedPreferences.getInstance();
    String? test = prefs.getString('test');
    String? token = prefs.getString('token');
    String? userdata = prefs.getString('userdata');

    _test = test ?? 'Default2';
    _token = token ?? null;
    _userdata = UserData.fromJsonString(userdata!);
    loggerNoStack.t({'Text': _test.isNotEmpty, 'Token': _token, 'UserDat': _userdata!.uid});
    notifyListeners();
  }

  Future<void> UpToken(String token, bool update) async {
    print('uptoken');
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    (update) {
      notifyListeners();
    };
  }

  Future<void> UpUserInfo(UserData data) async {
    loggerNoStack.i('Provider----------------------UpUserInfo');
    _userdata = data;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userdata', data.toJsonString());

    notifyListeners();
  }

  Future<void> Upfoothistory(List<FootData> data) async {
    loggerNoStack.i('Provider----------------------Upfoothistory');
    _footdata = data;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('foothistory', jsonEncode(data));
    notifyListeners();
  }

  Future<void> UpWeightHistory(List<WeightData> data) async {
    loggerNoStack.i('Provider----------------------Upfoothistory');

    _WeightData = data;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('weightdata', jsonEncode(data));
    notifyListeners();
  }

  Future<void> UpScanData(Map<String, dynamic> data) async {
    _Scandata = data;
    loggerNoStack.i('Provider----------------------UpScanData');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('scandata', jsonEncode(data));
    notifyListeners();
  }

  Future<void> UpGroupData(List<GroupData> data) async {
    _groupData = data;
    loggerNoStack.i('Provider----------------------UpGroupData');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('groupdata', jsonEncode(data));
    notifyListeners();
  }

  Future<void> UpGroupHistory(List<GroupHistory> data) async {
    _groupHistory = data;
    loggerNoStack.i('Provider----------------------UpGroupHistory');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('groupHistory', jsonEncode(data));
    notifyListeners();
  }

  Future<void> logout() async {
    print('logout');
    _token = null;
    _userdata = null;
    _footdata = null;
    _WeightData = null;
    _groupHistory = null;
    _Scandata = null;
    _groupData = null;
    notifyListeners();
  }

  Future<void> deletegroup() async {
    print('deletegroup');
    _groupHistory = null;
    _groupData = null;
    notifyListeners();
  }

  Future<void> GetAllData() async {}

  void update(String? newToken) {
    print('notifyListeners');
    if (_token != newToken) {
      _token = newToken;
      print('update $_token');
      notifyListeners();
    }
  }

  void delete() {
    print('delete');
    _token = null;
    notifyListeners();
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}
