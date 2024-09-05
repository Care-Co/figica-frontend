import 'package:fisica/models/webrtc/drawing_point.dart';
import 'package:fisica/models/webrtc/icecandidate_model.dart';
import 'package:fisica/models/webrtc/webrtc_model.dart';
import 'package:fisica/utils/service/webrtc/webrtc_socket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:vibration/vibration.dart';
// import 'package:web_rtc/model/icecandidate_model.dart';
// import 'package:web_rtc/model/webrtc_model.dart';
// import 'package:web_rtc/service/webrtc_socket.dart';
// import 'package:web_rtc/model/drawing_point.dart';

enum ScreenState { loading, initDone, receivedCalling }

class WebRTCController extends WebRTCSocket {
  /////////////////////////////// ===== [variables] ===== ///////////////////////////////

  /// 상대방
  String? to;

  /// 역할
  String? role;

  /// 본인
  String? _from;

  /// [drawing] 그림, 색상
  DrawingGroup? currentGroup;
  Color? currentColor;

  /// 연결대상, 본인
  RTCPeerConnection? _peer;

  /// 본인 비디오 렌더러
  RTCVideoRenderer? localRenderer = RTCVideoRenderer();

  /// 상대방 비디오 렌더러
  RTCVideoRenderer? remoteRenderer = RTCVideoRenderer();

  /// 유저 리스트 관리
  ValueNotifier<List<Map<String, dynamic>>> userListNotifier = ValueNotifier<List<Map<String, dynamic>>>([]);

  /// 본인 비디오 렌더 관리
  ValueNotifier<bool> localVideoNotifier = ValueNotifier<bool>(false);
  ValueNotifier<bool> localAudioNotifier = ValueNotifier<bool>(false);

  /// 상대방 비디오 렌더 관리
  ValueNotifier<bool> remoteVideoNotifier = ValueNotifier<bool>(false);

  /// Drawing 관리
  ValueNotifier<List<DrawingGroup>> drawingGroupsNotifier = ValueNotifier<List<DrawingGroup>>([]);

  /// 메시지 관리
  ValueNotifier<List<Map<String, dynamic>>> messagesNotifier = ValueNotifier<List<Map<String, dynamic>>>([]);

  /// [_receiveOffer] 발생시, [sendAnswer] 부분 데이터 처리
  RTCSessionDescription? _answer;

  /// [WebRTCListView] 부분 state 처리
  ValueNotifier<ScreenState> screenNotifier = ValueNotifier<ScreenState>(ScreenState.loading);

  /// [WebRTCView] context. Navigator.pop 용도
  BuildContext? webRTCVideoViewContext;
  BuildContext? audioCallViewContext;

  /// offer/answer 과정 완료 후 send
  final List<IceCandidateModel> _candidateList = [];

  /// 본인 비디오
  MediaStream? _localStream;
  MediaStream? get localStream => _localStream;

  /// iceCandidate 연결 여부
  bool _isConnected = false;
  bool _isVideoOn = true; // 비디오 상태 관리
  bool _isAudioOn = true;
  bool get isVideoOn => _isVideoOn;
  bool get isAudioOn => _isAudioOn;
  bool audioOnly = false;

  /////////////////////////////// ===== [variables] ===== ///////////////////////////////
  ///                                                                                 ///
  ///////////////////////////////// ===== [embed] ===== /////////////////////////////////

  /// [_initSocket], [_initPeer] 소켓, 피어, 렌더러 초기화
  Future<void> initController() async {
    await _initSocket();
    await _initPeer();

    await localRenderer!.initialize();
    await remoteRenderer!.initialize();
    _isVideoOn = true;
    _isAudioOn = true;
    screenNotifier.value = ScreenState.initDone;
  }

  /// 종료시 작동
  void dispose() {
    currentGroup = null;

    userListNotifier.dispose();
    localVideoNotifier.dispose();
    remoteVideoNotifier.dispose();
    screenNotifier.dispose();
    // drawingPointsNotifier.dispose();
    drawingGroupsNotifier.dispose();
    messagesNotifier.dispose();

    localRenderer?.dispose();
    remoteRenderer?.dispose();

    _localStream?.dispose();
    _peer?.dispose();
    super.disconnectSocket();
  }

  /// [socket] 초기화
  Future<void> _initSocket() async {
    _from = await super.connectSocket();

    if (_from != null) {
      super.socketOn('updateUserlist', _updateUserList);
      super.socketOn('connect_error', (data) {
        debugPrint('[socket] error : $data');
      });
      super.socketOn('connect_timeout', (data) {
        debugPrint('[socket] error : $data');
      });
      super.socketOn('offer', _receiveOffer);
      super.socketOn('refuseV', _refusedVideoCallConnection);
      super.socketOn('refuseA', _refusedAudioCallConnection);
      super.socketOn('answer', _receiveAnswer);
      super.socketOn('remoteIceCandidate', _remotePeerIceCandidate);
      super.socketOn('disconnectVideoPeer', closeVideoCall);
      super.socketOn('disconnectAudioPeer', closeAudioCall);
      super.socketOn('drawing', _receiveDrawing);
      super.socketOn('drawingEnd', _receiveDrawingEnd);
      super.socketOn('message', _receiveMessage);
      super.socketOn('clearDrawing', _receiveClearDrawing);
      super.socketOn('setDrawingColor', _receiveSetDrawingColor);
      super.socketOn('drawingUndo', _receiveDrawingUndo);

      super.socketEmit('requestUserlist', null);
    }
  }

  /// [initiate]
  void initializeUserStatus() {
    String oppositeRole = role == 'expert' ? 'client' : 'expert';
    bool isUserOnline = false;

    for (var user in userListNotifier.value) {
      if (user['role'] == oppositeRole) {
        isUserOnline = true;
        break;
      }
    }

    if (isUserOnline) {
      // 상대방이 온라인 상태임을 처리
    } else {
      // 상대방이 오프라인 상태임을 처리
    }
  }

  /// [_peer] 초기화
  Future<void> _initPeer() async {
    _peer = await createPeerConnection({
      'iceServers': [
        {'url': 'stun:stun.l.google.com:19302'},
      ],
    });
    _peer!.onIceCandidate = _iceCandidateEvent;
    _peer!.onTrack = _remoteStream;
    _peer!.onConnectionState = _peerStateChange;
  }

  /// [_peer], [localRenderer], [remoteRenderer] 초기화 등
  Future<void> _resetElements() async {
    await turnOffMedia();

    _candidateList.clear();

    _peer?.close();
    _peer = null;

    await _initPeer();

    await localRenderer?.dispose();
    await remoteRenderer?.dispose();
    localRenderer = null;
    remoteRenderer = null;

    localRenderer = RTCVideoRenderer();
    remoteRenderer = RTCVideoRenderer();

    await localRenderer!.initialize();
    await remoteRenderer!.initialize();

    localVideoNotifier.value = false;
    remoteVideoNotifier.value = false;

    drawingGroupsNotifier.value = [];
    currentGroup = null;

    _isConnected = false;

    await _localStream?.dispose();
    _localStream = null;

    _isVideoOn = true; // 초기화 시 비디오 상태를 다시 true로 설정
    _isAudioOn = true;
  }

  /// [본인] 미디어 off
  Future<void> turnOffMedia() async {
    if (localRenderer!.srcObject != null) {
      localRenderer!.srcObject = null;
      localVideoNotifier.value = false;
      localAudioNotifier.value = false;

      for (MediaStreamTrack track in _localStream!.getTracks()) {
        track.enabled = false;
        await track.stop();
      }

      await _localStream?.dispose();
      _localStream = null;
      _isVideoOn = false;
      _isAudioOn = false;
    }
  }

  /// [본인] 미디어 on
  Future<void> turnOnMedia() async {
    final constraints = {
      'audio': true,
      'video': !audioOnly ? {'facingMode': 'user'} : false,
    };
    _localStream = await navigator.mediaDevices.getUserMedia(constraints);
    for (var track in _localStream!.getTracks()) {
      _peer!.addTrack(track, _localStream!);
    }
    localRenderer!.srcObject = _localStream;
    localVideoNotifier.value = !audioOnly;
    _isVideoOn = true;
    _isAudioOn = true;
  }

  /// 미디어 Initiate
  Future<void> _startMedia({required bool isAudioOnly}) async {
    final constraints = {
      'audio': true,
      'video': !isAudioOnly ? {'facingMode': 'user'} : false,
    };

    // 미디어 스트림 초기화
    _localStream = await navigator.mediaDevices.getUserMedia(constraints);
    debugPrint('Audio tracks: ${_localStream!.getAudioTracks()}'); // 추가
    // 트랙을 피어 연결에 추가
    for (var track in _localStream!.getTracks()) {
      _peer!.addTrack(track, _localStream!);
    }

    if (!isAudioOnly) {
      localRenderer!.srcObject = _localStream;
      localVideoNotifier.value = !isAudioOnly;
    }
  }

  /// peer state 확인용
  void _peerStateChange(RTCPeerConnectionState state) {
    if (state == RTCPeerConnectionState.RTCPeerConnectionStateConnected && !_isConnected) {
      _isConnected = true;
    } else if (state == RTCPeerConnectionState.RTCPeerConnectionStateFailed) {
      _peer?.restartIce();
    }
  }

  /// [본인, 상대방] ice candidate 연결 처리
  void _remotePeerIceCandidate(data) async {
    try {
      IceCandidateModel model = IceCandidateModel.fromJson(data);

      RTCIceCandidate candidate = RTCIceCandidate(model.candidate, model.sdpMid, model.sdpMLineIndex);

      await _peer!.addCandidate(candidate);
    } catch (e) {
      debugPrint('[webRTC] remoteIceCandidate error : $e');
    }
  }

  /// 상대방 미디어 처리
  void _remoteStream(RTCTrackEvent e) {
    debugPrint('[webRTC] gotRemoteStream data : ${e.track}, ${e.streams}');

    if (e.streams.isNotEmpty) {
      MediaStream stream = e.streams.first;
      remoteRenderer!.srcObject = stream;
      remoteVideoNotifier.value = !audioOnly;
      debugPrint('[webRTC] Remote stream added to renderer.');
    } else {
      debugPrint('[webRTC] No remote stream available.');
    }
  }

  /// [본인, 상대방] ice candidate 연결 요청
  void _iceCandidateEvent(RTCIceCandidate e) {
    IceCandidateModel model = IceCandidateModel(
      candidate: e.candidate,
      sdpMid: e.sdpMid,
      sdpMLineIndex: e.sdpMLineIndex,
      to: to,
    );

    if (model.candidate == null || model.to == null) {
      return;
    }

    int index = _candidateList.indexWhere((element) => element.candidate == model.candidate);

    if (index < 0) {
      _candidateList.add(model);
    }
  }

  /// [본인] 상대방 answer 받음
  void _receiveAnswer(data) async {
    WebRTCModel model = WebRTCModel.fromJson(data);

    debugPrint('[webRTC] receive answer : ${model.answerType}');

    await _peer!.setRemoteDescription(RTCSessionDescription(
        model.answerSDP!.replaceFirst('useinbandfec=1', 'useinbandfec=1; stereo=1; maxaveragebitrate=510000'), model.answerType));

    for (IceCandidateModel candidateModel in _candidateList) {
      if (!_isConnected) {
        debugPrint('[webRTC] send iceCandidate : ${candidateModel.toJson()}');
        super.socketEmit('iceCandidate', candidateModel.toJson());
        break;
      }
    }
  }

  /// [상대방] offer 받음
  void _receiveOffer(data) async {
    WebRTCModel model = WebRTCModel.fromJson(data);

    audioOnly = model.audioOnly!;

    debugPrint('[webRTC] receive offer : ${model.to} from ${model.from}');

    await _peer!.setRemoteDescription(RTCSessionDescription(model.offerSDP, model.offerType));
    await _startMedia(isAudioOnly: audioOnly);
    _answer = await _peer!.createAnswer({
      'mandatory': {
        'OfferToReceiveAudio': true,
        'OfferToReceiveVideo': !audioOnly,
      }
    });
    await _peer!.setLocalDescription(_answer!);

    to = model.from;

    screenNotifier.value = ScreenState.receivedCalling;

    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 1500);
    }
  }

  /// [본인] offer 보냄
  void _emitOffer(RTCSessionDescription offer, bool isAudioOnly) {
    final model = WebRTCModel(
      from: _from,
      to: to,
      offerSDP: offer.sdp,
      offerType: offer.type,
      audioOnly: isAudioOnly,
    );
    socketEmit('offer', model.toJson());
  }

  /// [본인] answer 보냄
  void _emitAnswer(RTCSessionDescription answer, bool isAudioOnly) {
    final model = WebRTCModel(
      from: _from,
      to: to,
      answerSDP: answer.sdp,
      answerType: answer.type,
      audioOnly: isAudioOnly,
    );
    socketEmit('answer', model.toJson());
  }

  ///////////////////////////////// ===== [embed] ===== /////////////////////////////////
  ///                                                                                 ///
  ///////////////////////////////// ===== [back] =====  /////////////////////////////////

  /// [main] ///

  /// 역할 설정
  void setRole(String newRole) {
    role = newRole;
    if (_from != null) {
      super.socketEmit('setRole', {'role': role});
    }
  }

  /// 유저 리스트 업데이트
  void _updateUserList(data) {
    debugPrint('[socket] userList update $data');
    Map<String, dynamic> map = Map.castFrom(data);

    List<Map<String, dynamic>> list = List<Map<String, dynamic>>.from(map['userList']);
    debugPrint('[socket] list : $list');
    list.removeWhere((element) => element['userId'] == super.user);

    userListNotifier.value = list;
  }

  /// [AudioCall] ///

  /// [본인] 통화 거절 받음
  void _refusedAudioCallConnection(_) async {
    await closeAudioCall(_);
  }

  /// [VideoCall] ///

  /// [본인] 통화 거절 받음
  void _refusedVideoCallConnection(_) async {
    await closeVideoCall(_);
  }

  /// [drawing]데이터 받음
  void _receiveDrawing(data) {
    Offset? receivedPoint = data['point'] == null ? null : Offset((data['point']['x'] as num).toDouble(), (data['point']['y'] as num).toDouble());

    if (currentColor == null) return; // 색상이 설정되지 않았다면 그리지 않음

    // 그룹이 없으면 새 그룹 생성
    if (currentGroup == null) {
      currentGroup = DrawingGroup(color: currentColor!, points: []);
      drawingGroupsNotifier.value = List.from(drawingGroupsNotifier.value)..add(currentGroup!);
    }

    if (receivedPoint != null) {
      currentGroup!.points.add(DrawingPoint(receivedPoint));
    }

    drawingGroupsNotifier.value = List.from(drawingGroupsNotifier.value);
  }

  /// [drwaing]리셋
  void _resetDrawingState() {
    drawingGroupsNotifier.value = [];
    currentGroup = null;
  }

  /// [drawing]되돌리기 시그널 전송
  Future<void> sendDrawingUndo() async {
    if (to != null) {
      super.socketEmit('drawingUndo', {
        'to': to,
      });
    }
  }

  /// [drawing]되돌리기 시그널 받음
  void _receiveDrawingUndo(_) {
    if (drawingGroupsNotifier.value.isNotEmpty) {
      drawingGroupsNotifier.value = List.from(drawingGroupsNotifier.value)..removeLast();
    }
  }

  /// [drawing]색상 시그널 받음
  void _receiveSetDrawingColor(data) {
    Color color = Color(int.parse(data['color'], radix: 16)); // 색상 정보 파싱
    currentColor = color;
  }

  /// [drawing]리셋 시그널 받음
  void _receiveClearDrawing(_) {
    drawingGroupsNotifier.value = [];
    currentGroup = null; // 모든 드로잉이 지워졌으므로 currentGroup을 초기화
  }

  /// [drawing]종료 시그널 받음
  void _receiveDrawingEnd(data) {
    // 작업을 끝내고 현재 작업 중인 그룹을 null로 설정
    currentGroup = null;

    // 그룹 리스트를 업데이트 (현재 추가된 내용을 반영)
    drawingGroupsNotifier.value = List.from(drawingGroupsNotifier.value);
  }

  /// [chatting] ///

  /// [message]데이터 수신
  void _receiveMessage(data) {
    String message = data['message'];
    messagesNotifier.value = List.from(messagesNotifier.value)..add({'message': message, 'isOwn': false});
  }

  ///////////////////////////////// ===== [back]  ===== /////////////////////////////////
  ///                                                                                 ///
  ///////////////////////////////// ===== [front] ===== /////////////////////////////////

  /// [main] ///

  /// [localStream]의 null 여부를 반환합니다.
  bool checkStream() {
    return localStream != null;
  }

  /// [AudioCall_VideoCall] 공통 ///

  /// 통화 받음
  void sendAnswer() {
    debugPrint('[webRTC] send answer to $to');
    _emitAnswer(_answer!, audioOnly);
    _answer = null;

    Vibration.hasVibrator().then((value) {
      if (value ?? false) {
        Vibration.cancel();
      }
    });
  }

  /// [AudioCall] ///

  /// 통화 요청 보냄
  Future<void> sendAudioCallOffer() async {
    if (to == null) return;
    audioOnly = true;
    await _initPeer();
    await _startMedia(isAudioOnly: true);
    final offer = await _peer!.createOffer({'OfferToReceiveAudio': true, 'OfferToReceiveVideo': false});
    await _peer!.setLocalDescription(offer);
    _emitOffer(offer, true);
  }

  /// 통화 거절 보냄
  Future<void> refuseAudioOffer() async {
    socketEmit('refuseA', {'to': to});
    await _resetElements();

    screenNotifier.value = ScreenState.initDone;
  }

  /// 음성 통화 종료
  Future<void> closeAudioCall(_) async {
    if (audioCallViewContext == null) {
      return;
    }

    super.socketEmit('disconnectAudioPeer', {'to': to});

    Navigator.pop(audioCallViewContext!);
    audioCallViewContext = null;
    await _resetElements();
  }

  /// 음소거 버튼(on/off)
  void toggleMuteA() {
    _isAudioOn = !_isAudioOn;
    for (var track in _localStream!.getTracks()) {
      track.enabled = _isAudioOn;
    }
    localAudioNotifier.value = _isAudioOn;
  }

  /// [VideoCall] ///

  /// 통화 요청 보냄
  Future<void> sendVideoCallOffer() async {
    if (to == null) return;
    audioOnly = false;
    await _initPeer(); // 피어 초기화
    await _startMedia(isAudioOnly: false); // 미디어 초기화 및 시작

    final offer = await _peer!.createOffer({'OfferToReceiveAudio': true, 'OfferToReceiveVideo': true});
    await _peer!.setLocalDescription(offer);
    _emitOffer(offer, false);
  }

  /// 통화 거절 보냄
  Future<void> refuseVideoOffer() async {
    socketEmit('refuseV', {'to': to});
    await _resetElements();

    screenNotifier.value = ScreenState.initDone;
  }

  /// 화상 통화 종료
  Future<void> closeVideoCall(_) async {
    if (webRTCVideoViewContext == null) {
      return;
    }

    super.socketEmit('disconnectVideoPeer', {'to': to});

    Navigator.pop(webRTCVideoViewContext!);
    webRTCVideoViewContext = null;
    await _resetElements();
  }

  /// 내 비디오 버튼(on/off)
  void toggleVideo() {
    if (_localStream != null) {
      _isVideoOn = !_isVideoOn;
      for (var track in _localStream!.getVideoTracks()) {
        track.enabled = _isVideoOn;
      }
      localVideoNotifier.value = _isVideoOn;
    }
  }

  /// 음소거 버튼(on/off)
  void toggleMuteV() {
    _isAudioOn = !_isAudioOn;
    for (var track in _localStream!.getAudioTracks()) {
      track.enabled = _isAudioOn;
    }
    localAudioNotifier.value = _isAudioOn;
  }

  /// [drawing]데이터 전송
  Future<void> sendDrawing(Offset point) async {
    if (to != null && currentColor != null) {
      if (currentGroup == null) {
        currentGroup = DrawingGroup(color: currentColor!, points: []);
        drawingGroupsNotifier.value = List.from(drawingGroupsNotifier.value)..add(currentGroup!);
      }
      currentGroup!.points.add(DrawingPoint(point));
      drawingGroupsNotifier.value = List.from(drawingGroupsNotifier.value);

      super.socketEmit('drawing', {
        'to': to,
        'point': {'x': point.dx.toDouble(), 'y': point.dy.toDouble()},
      });
    }
  }

  /// [drawing]색상 시그널 전송
  Future<void> setDrawingColor(Color color) async {
    currentColor = color;
    if (to != null) {
      super.socketEmit('setDrawingColor', {
        'to': to,
        'color': color.value.toRadixString(16),
      });
    }
  }

  /// [drawing]리셋 시그널 전송
  Future<void> sendClearDrawing() async {
    if (to != null) {
      super.socketEmit('clearDrawing', {'to': to});
    }
    _resetDrawingState();
  }

  /// [drawing]되돌리기 버튼
  Future<void> undoLastDrawing() async {
    if (drawingGroupsNotifier.value.isNotEmpty) {
      drawingGroupsNotifier.value = List.from(drawingGroupsNotifier.value)..removeLast();
      await sendDrawingUndo();
    }
  }

  /// [drawing]종료 시그널 전송
  Future<void> sendDrawingEnd() async {
    if (to != null) {
      super.socketEmit('drawingEnd', {
        'to': to,
      });
    }
    currentGroup = null;
  }

  /// [chatting] ///

  /// [message] 데이터 전송
  Future<void> sendMessage(String message) async {
    if (to != null) {
      super.socketEmit('message', {
        'to': to,
        'message': message,
      });
      messagesNotifier.value = List.from(messagesNotifier.value)..add({'message': message, 'isOwn': true});
    }
  }

  ///////////////////////////////// ===== [front] ===== /////////////////////////////////
}

/// [temp] ///
/// [_peer] 초기화
// Future<void> _initPeer() async {
//   _peer = await createPeerConnection({
//     'iceServers': [
//       {
//         'username': 'WKaDlqMtZ9UmVIGuY13KHJfEHRC8VdvPyKNg2w1wILiQCdJChfDoUofp4hWdCGFVAAAAAGaEAh52ZW52ZWV2',
//         'credential': 'f1257df2-3877-11ef-8ff1-0242ac120004',
//         'urls': [
//           'turn:ntk-turn-1.xirsys.com:80?transport=udp',
//           'turn:ntk-turn-1.xirsys.com:3478?transport=udp',
//           'turn:ntk-turn-1.xirsys.com:80?transport=tcp',
//           'turn:ntk-turn-1.xirsys.com:3478?transport=tcp',
//           'turns:ntk-turn-1.xirsys.com:443?transport=tcp',
//           'turns:ntk-turn-1.xirsys.com:5349?transport=tcp'
//         ]
//       },
//     ],
//   });
//   _peer!.onIceCandidate = _iceCandidateEvent;
//   _peer!.onTrack = _remoteStream;
//   _peer!.onConnectionState = _peerStateChange;
// }
