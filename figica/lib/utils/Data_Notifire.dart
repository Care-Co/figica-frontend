import 'package:fisica/index.dart';
import 'package:fisica/main.dart';
import 'package:fisica/models/Code.dart';
import 'package:fisica/models/FootData.dart';
import 'package:fisica/models/GroupData.dart';
import 'package:fisica/models/GroupHistory.dart';
import 'package:fisica/models/GroupInvitation.dart';
import 'package:fisica/models/Schedule.dart';
import 'package:fisica/models/UserData.dart';
import 'package:fisica/models/WeightData.dart';
import 'package:fisica/utils/service/plan_service.dart';
import 'package:fisica/utils/service/Foot_Controller.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();
  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();
  bool showSplashImage = true;
  String? _token;
  String? _firebasetoken;
  String? _retoken;
  DateTime? _expiresIn;
  String? _testuid;
  String? _type;
  bool _testdivice2 = false;
  bool _cam = false;
  bool _vid = false;
  bool _datalod = true;

  UserData? _userdata;
  List<FootData>? _footdata;
  List<WeightData>? _WeightData;
  List<GroupHistory>? _groupHistory;
  List<Invitation>? _GroupInvitation;
  GroupTicket? _GroupTicket;

  String _device = '';
  Map<String, dynamic>? _Scandata;

  List<GroupData>? _groupData;
  String? _myAuthority;
  String? _mymemberId;
  List<ScheduleData>? _scheduleData;
  List<DateTime>? _targetdata;
  String? _verificationId;

  String _test = 'Default';

  //-------------//
  String get test => _test;
  String? get apiToken => _token;
  String? get firebaseToken => _firebasetoken;
  String? get reToken => _retoken;
  DateTime? get expiresIn => _expiresIn;
  String? get testuid => _testuid;
  String? get type => _type;
  bool get datalod => _datalod;
  bool get test2 => _testdivice2;
  bool get cam => _cam;
  bool get vid => _vid;
  bool get testerall => (_testdivice2 && _cam && _vid);

  UserData? get userdata => _userdata;
  List<FootData>? get footdata => _footdata;
  bool get isfootempty => _footdata == null;
  bool get isweightData => _WeightData == null || _WeightData!.isEmpty;

  List<WeightData>? get weightData => _WeightData;
  List<GroupData>? get groupData => _groupData;
  String? get myAuthority => _myAuthority;
  String? get mymemberId => _mymemberId;

  String? get device => _device;
  bool get isdevice => _device != '';

  List<GroupHistory>? get groupHistroy => _groupHistory;
  List<Invitation>? get groupInvitation => _GroupInvitation;
  List<ScheduleData>? get scheduleData => _scheduleData;
  List<DateTime>? get targetdata => _targetdata;
  GroupTicket? get groupTicket => _GroupTicket;

  Map<String, dynamic>? get scandata => _Scandata;

  bool get loggedIn => _token != null;
  bool get isGroup => _groupData != null;
  bool get iswait => _GroupInvitation != null;
  bool get iscode => _GroupTicket != null;
  String get Groupstate => _GroupInvitation!.first.status;

  List<Member>? get member => _groupData?.first.members;

  static get http => null;
  bool isLoading = false;

  bool _isSignUp = false;
  bool _isLogin = false;

  bool get isSignUp => _isSignUp;
  bool get isLogin => _isLogin;

  String? get verificationId => _verificationId;

  Future<void> testdivice2Up() async {
    _testdivice2 = true;
    notifyListeners();
  }

  Future<void> cam2Up() async {
    _cam = true;
    notifyListeners();
  }

  Future<void> vid2Up() async {
    _vid = true;
    notifyListeners();
  }

  Future<void> resetTestState() async {
    _vid = false;
    _cam = false;
    _testdivice2 = false;
    notifyListeners();
  }

  void updateSignUpState(bool isSignUp) {
    _isSignUp = isSignUp;
    notifyListeners();
  }

  void updateloginState(bool isLogin) {
    _isLogin = isLogin;
    notifyListeners();
  }

  Future<void> UpverificationId(String id) async {
    _verificationId = id;
    notifyListeners;
  }

  //-------------------Shared Preferences Helper------------------//

  String groupStatus = '';
  void printprov(String text) {
    print('\x1B[33m$text\x1B[0m');
  }

  Future<void> sortfootdata(String type) async {
    if (type == 'new') {
      _footdata!.sort((a, b) => b.measuredTime.compareTo(a.measuredTime));
    } else if (type == 'old') {
      _footdata!.sort((a, b) => a.measuredTime.compareTo(b.measuredTime));
    }
  }

  Future<void> sortweightdata(String type) async {
    if (type == 'new') {
      _WeightData!.sort((a, b) => b.measuredTime.compareTo(a.measuredTime));
    } else if (type == 'old') {
      _WeightData!.sort((a, b) => a.measuredTime.compareTo(b.measuredTime));
    }
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

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? expiresInStr = prefs.getString('expiresIn');
    print("expiresInStr = " + expiresInStr.toString());
    if (expiresInStr != null) {
      DateTime expiresIn = DateTime.parse(expiresInStr);
      if (DateTime.now().isAfter(expiresIn)) {
        await UserController.RefreshNewToken(_retoken!);
        return _token;
      } else {
        print('not refresh');
        return _token;
      }
    } else {
      await UserController.RefreshNewToken(_retoken!);
      return _token;
    }
  }

  //-------------------Shared Preferences Helper------------------//
  String truncateString(String input) {
    if (input.length > 10) {
      return '${input.substring(0, 10)}...';
    } else {
      return input;
    }
  }

  Future<bool> loadSaveUserData() async {
    print('------------------------------------------load Saved User Data-----------------------------');
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? retoken = prefs.getString('refreshToken');
    String? expiresInStr = prefs.getString('expiresIn');
    DateTime? expiresIn;
    if (expiresInStr != null) {
      expiresIn = DateTime.parse(expiresInStr);
    }
    if (token == null || token.isEmpty) {
      print('Token is empty.');
      return false; // 토큰이 비어있으므로 false 반환
    }

    String? userdata = prefs.getString('userdata');
    _token = token; // 비어 있지 않을 경우에만
    _retoken = retoken;
    _expiresIn = expiresIn;

    if (userdata != null) {
      _userdata = UserData.fromJsonString(userdata);
      String? device = prefs.getString('device');
      if (device != null && device.isNotEmpty) {
        _device = device;
      }

      loggerNoStack.d({
        'retoken': truncateString(retoken!),
        'token': truncateString(token),
        'expiresInStr': expiresInStr,
      });
      loggerNoStack.d(_userdata);
      notifyListeners();
      return true; // 데이터 로드 성공
    } else {
      return false; // 유저 데이터가 없으므로 false 반환
    }
  }

  Future<void> apicall() async {
    _datalod = true;
    DateTime now = DateTime.now();
    String toDate = DateFormat('yyyy/MM/dd').format(now);
    String toDate2 = DateFormat('yyyy-MM-dd').format(now);
    DateTime monthsBefore = DateTime(now.year, now.month - 3, now.day);
    String fromDate = DateFormat('yyyy/MM/dd').format(monthsBefore);
    String fromDate2 = DateFormat('yyyy-MM-dd').format(monthsBefore);
    //토큰 유효시간 검사
    String? calltoken = await getAccessToken();
    printprov('-------------------------------------get all api--------------------------------------');
    printprov('------------------------------------유저 프로파일 api--------------------------------------');
    await UserController.getprofile(calltoken!);
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
    //await ScheduleService.getScheduleData('${fromDate2}', '${toDate2}');
    printprov('-------------------------------------end api--------------------------------------');
    _datalod = false;
    notifyListeners();
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

  Future<void> UpToken(String token, bool update) async {
    DateTime expiryTime = DateTime.now().add(Duration(minutes: 15));
    try {
      loggerNoStack.t({
        'Name': 'UpToken',
        'token': token,
        'expiryTime': expiryTime,
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('expiresIn', expiryTime.toIso8601String());
      if (update) {
        _token = token;
        _expiresIn = expiresIn;
        await AppStateNotifier.instance.apicall();
        notifyListeners();
      }
    } on Exception catch (e) {
      loggerNoStack.e(e);
    }
    ;
  }

  Future<void> Uptestuid(String uid) async {
    try {
      loggerNoStack.t({
        'Name': 'Uptestuid',
        'uid': uid,
      });
      _testuid = uid;
    } on Exception catch (e) {
      loggerNoStack.e(e);
    }
    ;
  }

  Future<void> Uptype(String type) async {
    _type = type;
    ;
  }

  Future<void> UpfirebaseToken(String token) async {
    loggerNoStack.t({
      'Name': 'UpfirebaseToken',
      'token': token,
    });
    _firebasetoken = token;
    ;
  }

  Future<void> removefirebaseToken() async {
    _firebasetoken = null;
    ;
  }

  Future<void> UprefreshToken(String token) async {
    try {
      loggerNoStack.t({
        'Name': 'UprefreshToken',
        'token': token,
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('refreshToken', token);
      _retoken = token;
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
    String? uid = AppStateNotifier.instance.userdata?.uid;
    print('data = $data');

    _groupData = data;
    loggerNoStack.i('Provider----------------------UpGroupData');
    final prefs = await SharedPreferences.getInstance();
    _myAuthority = _groupData!.first.members.firstWhere((element) => element.uid == uid).authority;
    _mymemberId = _groupData!.first.members.firstWhere((element) => element.uid == uid).memberId;
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

  Future<void> UpGroupTicket(GroupTicket data) async {
    loggerNoStack.i('Provider----------------------GroupTicket');
    _GroupTicket = data;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('GroupTicket', data.toJsonString());
    notifyListeners();
  }

  Future<void> UpGroupHistory(List<GroupHistory> data) async {
    _groupHistory = data;
    loggerNoStack.i('Provider----------------------UpGroupHistory');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('groupHistory', jsonEncode(data));
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

  Future<void> Updevice(String data) async {
    _device = data;
    loggerNoStack.i('Provider----------------------Updevice');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('device', data);
    notifyListeners();
  }

  Future<void> resetgroup() async {
    print('resetgroup');
    final prefs = await SharedPreferences.getInstance();

    _GroupInvitation = null;
    await prefs.remove('GroupInvitation');
    await prefs.remove('groupdata');
    _groupData = null;

    notifyListeners();
  }

  Future<void> resetcode() async {
    print('resetcode');
    final prefs = await SharedPreferences.getInstance();

    _GroupTicket = null;
    await prefs.remove('GroupTicket');
    notifyListeners();
  }

  Future<void> removedevice() async {
    print('removedevice');
    final prefs = await SharedPreferences.getInstance();
    _device = '';
    await prefs.remove('device');
    notifyListeners();
  }

  Future<void> logout() async {
    print('logout');
    final prefs = await SharedPreferences.getInstance();
    _token = null;
    _testuid = null;
    _expiresIn = null;

    _firebasetoken = null;
    await prefs.remove('refreshToken');

    _retoken = null;
    _type = null;
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
    _myAuthority = null;
    await prefs.remove('myAuthority');
    _device = '';
    await prefs.remove('device');
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
