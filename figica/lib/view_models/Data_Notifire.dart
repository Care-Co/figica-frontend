import 'package:fisica/index.dart';
import 'package:fisica/main.dart';
import 'package:fisica/models/FootData.dart';
import 'package:fisica/models/GroupData.dart';
import 'package:fisica/models/GroupHistory.dart';
import 'package:fisica/models/GroupInvitation.dart';
import 'package:fisica/models/Schedule.dart';
import 'package:fisica/models/UserData.dart';
import 'package:fisica/models/WeightData.dart';
import 'package:fisica/service/plan_service.dart';
import 'package:fisica/views/home/scan/Foot_Controller.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();
  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();
  bool showSplashImage = true;
  String? _token;
  UserData? _userdata;
  List<FootData>? _footdata;
  List<WeightData>? _WeightData;
  List<GroupHistory>? _groupHistory;
  List<Invitation>? _GroupInvitation;

  Map<String, dynamic>? _Scandata;
  Map<String, dynamic>? _Smsdata;

  List<GroupData>? _groupData;
  List<ScheduleData>? _scheduleData;
  List<DateTime>? _targetdata;

  String _test = 'Default';

  //-------------//
  String get test => _test;
  String? get apiToken => _token;
  UserData? get userdata => _userdata;
  List<FootData>? get footdata => _footdata;
  List<WeightData>? get weightData => _WeightData;
  List<GroupData>? get groupData => _groupData;
  List<GroupHistory>? get groupHistroy => _groupHistory;
  List<Invitation>? get groupInvitation => _GroupInvitation;
  List<ScheduleData>? get scheduleData => _scheduleData;
  List<DateTime>? get targetdata => _targetdata;

  Map<String, dynamic>? get scandata => _Scandata;
  Map<String, dynamic>? get Smsdata => _Smsdata;

  bool get loggedIn => _token != null;
  bool get isGroup => _groupData != null;
  bool get iswait => _GroupInvitation != null;

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

  // 현재 날짜를 구합니다.

  //-------------------Shared Preferences Helper------------------//
  Future<void> apicall() async {
    DateTime now = DateTime.now();
    String toDate = DateFormat('yyyy/MM/dd').format(now);
    String toDate2 = DateFormat('yyyy-MM-dd').format(now);

    DateTime monthsBefore = DateTime(now.year, now.month - 3, now.day);
    String fromDate = DateFormat('yyyy/MM/dd').format(monthsBefore);
    String fromDate2 = DateFormat('yyyy-MM-dd').format(monthsBefore);

    printprov('-------------------------------------get all api--------------------------------------');
    printprov('------------------------------------유저 프로파일 api--------------------------------------');
    await UserController.getprofile(_token!);
    printprov('-------------------------------------족저압 히스토리 api--------------------------------------');
    await FootprintApi.getfoothistory('${fromDate}', '${toDate}');
    printprov('-------------------------------------체중 히스토리 api--------------------------------------');
    await FootprintApi.getweighthistory('${fromDate}', '${toDate}');
    printprov('-------------------------------------그룹 유무 api--------------------------------------');
    await GroupApi.findGroup();
    printprov('-------------------------------------그룹 대기 api--------------------------------------');
    await GroupApi.getGroupInvitationByUser();
    printprov('-------------------------------------그룹 히스토리 api--------------------------------------');
    await GroupApi.GroupHistoryData();
    printprov('-------------------------------------일정 api--------------------------------------');
    await ScheduleService.getScheduleData('${fromDate2}', '${toDate2}');
    printprov('-------------------------------------end api--------------------------------------');
  }

  Future<void> historyapi() async {
    DateTime now = DateTime.now();
    String toDate = DateFormat('yyyy/MM/dd').format(now);

    DateTime monthsBefore = DateTime(now.year, now.month - 3, now.day);
    String fromDate = DateFormat('yyyy/MM/dd').format(monthsBefore);
    printprov('-------------------------------------get historyapi api--------------------------------------');
    printprov('-------------------------------------족저압 히스토리 api--------------------------------------');
    await FootprintApi.getfoothistory('${fromDate}', '${toDate}');
    printprov('-------------------------------------체중 히스토리 api--------------------------------------');
    await FootprintApi.getweighthistory('${fromDate}', '${toDate}');
  }

  Future<bool> loadSaveUserData() async {
    print('------------------------------------------load Saved User Data-----------------------------');
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      print('Token is empty.');
      return false; // 토큰이 비어있으므로 false 반환
    }

    String? userdata = prefs.getString('userdata');
    _token = token; // 비어 있지 않을 경우에만 설정

    if (userdata != null) {
      _userdata = UserData.fromJsonString(userdata);
      print(token);
      loggerNoStack.d(_userdata);

      notifyListeners();
      return true; // 데이터 로드 성공
    } else {
      return false; // 유저 데이터가 없으므로 false 반환
    }
  }

  Future<void> UpToken(String token, bool update) async {
    try {
      loggerNoStack.t({
        'Name': 'UpToken',
        'token': token,
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      if (update) {
        _token = token;
        await AppStateNotifier.instance.apicall();
        notifyListeners();
      }
    } on Exception catch (e) {
      loggerNoStack.e(e);
    }
    ;
  }

  Future<void> UpToken2(String token, bool update) async {
    print('uptoken2');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken2() async {
    final prefs = await SharedPreferences.getInstance();
    String? test = prefs.getString('token');
    return test;
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
    await prefs.setString('footdata', jsonEncode(data));
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

  Future<void> UpGroupInvited(List<Invitation> data) async {
    _GroupInvitation = data;
    loggerNoStack.i('Provider----------------------UpGroupInvited');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('GroupInvitation', jsonEncode(data));
    notifyListeners();
  }

  Future<void> UpGroupHistory(List<GroupHistory> data) async {
    _groupHistory = data;
    loggerNoStack.i('Provider----------------------UpGroupHistory');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('groupHistory', jsonEncode(data));
    notifyListeners();
  }

  Future<void> verificationId(Map<String, dynamic> data) async {
    print(data);
    _Smsdata = data;
    loggerNoStack.i('Provider----------------------verificationId');
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('verificationId', jsonEncode(data));
    notifyListeners();
  }

  Future<void> UpSchadule(List<ScheduleData> data) async {
    _scheduleData = data;
    loggerNoStack.i('Provider----------------------UpSchadule');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ScheduleData', jsonEncode(data));

    _targetdata = data.map((item) => item.targetDate).toList();

    notifyListeners();
  }

  Future<void> logout() async {
    print('logout');
    final prefs = await SharedPreferences.getInstance();

    _token = null;
    await prefs.remove('token');
    _userdata = null;
    await prefs.remove('userdata');
    _footdata = null;
    await prefs.remove('footdata');
    _WeightData = null;
    await prefs.remove('weightdata');
    _groupHistory = null;
    await prefs.remove('groupHistory');
    _Scandata = null;
    await prefs.remove('scandata');
    _groupData = null;
    await prefs.remove('groupdata');
    _GroupInvitation = null;
    await prefs.remove('GroupInvitation');

    if (_token == null &&
        _userdata == null &&
        _footdata == null &&
        _WeightData == null &&
        _groupHistory == null &&
        _Scandata == null &&
        _groupData == null) {
      debugPrint('Logout and data reset successful.');
    } else {
      debugPrint('Data reset failed. Some fields are not null.');
    }
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
