// import 'package:flutter/material.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';
// import 'package:vibration/vibration.dart';
// import 'package:web_rtc/model/drawing_point.dart';
// import 'package:web_rtc/service/webrtc_socket.dart';
// import 'package:web_rtc/model/icecandidate_model.dart';
// import 'package:web_rtc/model/webrtc_model.dart';

// enum ScreenState { loading, initDone, receivedCalling }

// class VideoCallController extends WebRTCSocket {
//   String? to;
//   String? _from;
//   RTCPeerConnection? _peer;
//   RTCVideoRenderer? localRenderer = RTCVideoRenderer();
//   RTCVideoRenderer? remoteRenderer = RTCVideoRenderer();
//   /// [_receiveOffer] 발생시, [sendAnswer] 부분 데이터 처리
//   RTCSessionDescription? _answer;

//   ValueNotifier<bool> localVideoNotifier = ValueNotifier<bool>(false);
//   ValueNotifier<bool> localAudioNotifier = ValueNotifier<bool>(false);
//   ValueNotifier<bool> remoteVideoNotifier = ValueNotifier<bool>(false);
//   ValueNotifier<ScreenState> screenNotifier = ValueNotifier<ScreenState>(ScreenState.loading);

//   final List<IceCandidateModel> _candidateList = [];
//   ValueNotifier<List<DrawingPoint>> drawingPointsNotifier =
//       ValueNotifier<List<DrawingPoint>>([]);

//   MediaStream? _localStream;
//   bool _isConnected = false;
//   bool _isVideoOn = true;
//   bool _isAudioOn = true;
//   bool audioOnly = false;

//   BuildContext? webRTCVideoViewContext;

//   Future<void> initController() async {
//     await _initSocket();
//     await _initPeer();
//     await localRenderer!.initialize();
//     await remoteRenderer!.initialize();
//   }

  
//   void dispose() {
//     localVideoNotifier.dispose();
//     localAudioNotifier.dispose();
//     remoteVideoNotifier.dispose();
//     drawingPointsNotifier.dispose();
//     localRenderer?.dispose();
//     remoteRenderer?.dispose();
//     _localStream?.dispose();
//     _peer?.dispose();
//   }


//   /// [front] ///
//   void sendAnswer() {
//     debugPrint('[webRTC] send answer to $to');
//     _emitAnswer(_answer!);
//     _answer = null;

//     Vibration.hasVibrator().then((value) {
//       if (value ?? false) {
//         Vibration.cancel();
//       }
//     });
//   }



//   /// [front] ///
//   Future<void> sendOffer() async {
//     if (to == null) return;
//     await _initPeer();
//     await _startMedia();
//     final offer = await _peer!.createOffer({
//       'OfferToReceiveAudio': true,
//       'OfferToReceiveVideo': true
//     });
//     await _peer!.setLocalDescription(offer);
//     _emitOffer(offer, false);
//   }


//   /// [backend] ///
//   Future<void> _startMedia() async {
//     final constraints = {
//       'audio': true,
//       'video': {'facingMode': 'user'},
//     };
//     _localStream = await navigator.mediaDevices.getUserMedia(constraints);
//     for (var track in _localStream!.getTracks()) {
//       _peer!.addTrack(track, _localStream!);
//     }
//     localRenderer!.srcObject = _localStream;
//     localVideoNotifier.value = true;
//   }

//   void _emitOffer(RTCSessionDescription offer, bool isAudioOnly) {
//     final model = WebRTCModel(
//       from: _from,
//       to: to,
//       offerSDP: offer.sdp,
//       offerType: offer.type,
//       audioOnly: false,
//     );
//     socketEmit('offer', model.toJson());
//   }

//   /// [front] ///
//   void toggleVideo() {
//     if (_localStream != null) {
//       _isVideoOn = !_isVideoOn;
//       for (var track in _localStream!.getVideoTracks()) {
//         track.enabled = _isVideoOn;
//       }
//       localVideoNotifier.value = _isVideoOn;
//     }
//   }
//   void toggleAudio() {
//     if (_localStream != null) {
//       _isVideoOn = !_isVideoOn;
//       for (var track in _localStream!.getAudioTracks()) {
//         track.enabled = _isVideoOn;
//       }
//       localAudioNotifier.value = _isAudioOn;
//     }
//   }

//   Future<void> close(_) async {
//     if (webRTCVideoViewContext == null) {
//       return;
//     }
//     super.socketEmit('disconnectVideoPeer', {'to': to});
//     Navigator.pop(webRTCVideoViewContext!);
//     webRTCVideoViewContext = null;
//     await _resetElements();
//   }


//   /// [backend] ///
//   Future<void> _resetElements() async {
//     await turnOffMedia();
//     _peer?.close();
//     _peer = null;
//     await _initPeer();
//     localRenderer = RTCVideoRenderer();
//     remoteRenderer = RTCVideoRenderer();
//     await localRenderer!.initialize();
//     await remoteRenderer!.initialize();
//     localVideoNotifier.value = false;
//     localAudioNotifier.value = false;
//     remoteVideoNotifier.value = false;
//   }

  
//   /// [front] ///
//   Future<void> sendDrawing(Offset point, Color color) async {
//     if (to != null) {
//       super.socketEmit('drawing', {
//         'to': to,
//         'point': {'x': point.dx.toDouble(), 'y': point.dy.toDouble()},
//         'color': color.value.toRadixString(16),
//       });
//     }
//   }

//   /// [front] ///
//   Future<void> sendDrawingEnd() async {
//     if (to != null) {
//       super.socketEmit('drawingEnd', {
//         'to': to,
//         'point': null,
//         'color': null,
//       });
//     }
//   }

  
//   /// [backend] ///
//   Future<void> _initSocket() async {
//     _from = await super.getUserId();

//     if (_from != null) {
//       super.socketOn('offer', _receiveOffer);
//       super.socketOn('refuseV', _refusedConnection);
//       super.socketOn('answer', _receiveAnswer);
//       super.socketOn('remoteIceCandidate', _remotePeerIceCandidate);
//       super.socketOn('disconnectVideoPeer', close);
//       super.socketOn('drawing', _receiveDrawing);
//       super.socketOn('drawingEnd', _receiveDrawingEnd);
//       super.socketOn('clearDrawing', _receiveClearDrawing);

//     }
//   }









//   /// [backend] ///
//   Future<void> _initPeer() async {
//     _peer = await createPeerConnection({
//       'iceServers': [
//         {'url': 'stun:stun.l.google.com:19302'},
//       ],
//     });

//     _peer!.onIceCandidate = _iceCandidateEvent;
//     _peer!.onTrack = _remoteStream;
//     _peer!.onConnectionState = _peerStateChange;
//   }
  
//   /// [본인, 상대방] ice candidate 연결 요청
//   void _iceCandidateEvent(RTCIceCandidate e) {
//     IceCandidateModel model = IceCandidateModel(
//       candidate: e.candidate,
//       sdpMid: e.sdpMid,
//       sdpMLineIndex: e.sdpMLineIndex,
//       to: to,
//     );

//     if (model.candidate == null || model.to == null) {
//       return;
//     }

//     int index = _candidateList
//         .indexWhere((element) => element.candidate == model.candidate);

//     if (index < 0) {
//       _candidateList.add(model);
//     }
//   }

//   /// [backend] ///
//   void _remoteStream(RTCTrackEvent e) {
//     debugPrint('[webRTC] gotRemoteStream data : ${e.track}, ${e.streams}');

//     if (e.streams.isNotEmpty) {
//         MediaStream stream = e.streams.first;
//         remoteRenderer!.srcObject = stream;
//         remoteVideoNotifier.value = true;
//         debugPrint('[webRTC] Remote stream added to renderer.');
//     } else {
//         debugPrint('[webRTC] No remote stream available.');
//     }
//   }

//   /// [backend] ///
//   void _peerStateChange(RTCPeerConnectionState state) {
//     if (state == RTCPeerConnectionState.RTCPeerConnectionStateConnected &&
//         !_isConnected) {
//       _isConnected = true;
//     } else if (state == RTCPeerConnectionState.RTCPeerConnectionStateFailed) {
//       _peer?.restartIce();
//     }
//   }
//   ///////////////////////////////////////////////////////////////////////////////



//   /// [webrtc] ///


//   /// [backend] ///
//   void _emitAnswer(RTCSessionDescription answer) {
//     final model = WebRTCModel(
//       from: _from,
//       to: to,
//       answerSDP: answer.sdp,
//       answerType: answer.type,
//       audioOnly: false,
//     );
//     socketEmit('answer', model.toJson());
//   }

//   /// [backend] ///
//   void _receiveOffer(data) async {
//     WebRTCModel model = WebRTCModel.fromJson(data);

//     audioOnly = model.audioOnly!;

//     debugPrint('[webRTC] receive offer : ${model.to} from ${model.from}');

//     await _peer!.setRemoteDescription(
//         RTCSessionDescription(model.offerSDP, model.offerType));
//     await _startMedia();
//     _answer = await _peer!.createAnswer({
//       'mandatory': {
//         'OfferToReceiveAudio': true,
//         'OfferToReceiveVideo': !audioOnly,
//       }
//     });
//     await _peer!.setLocalDescription(_answer!);

//     to = model.from;

//     screenNotifier.value = ScreenState.receivedCalling;

//     if (await Vibration.hasVibrator() ?? false) {
//       Vibration.vibrate(duration: 1500);
//     }
//   }


//   /// [backend] ///
//   Future<void> turnOffMedia() async {
//     if (localRenderer!.srcObject != null) {
//       localRenderer!.srcObject = null;
//       localVideoNotifier.value = false;
//       localAudioNotifier.value = false;

//       for (MediaStreamTrack track in _localStream!.getTracks()) {
//         track.enabled = false;
//         await track.stop();
//       }

//       await _localStream?.dispose();
//       _localStream = null;
//       _isVideoOn = false;
//       _isAudioOn = false;
//     }
//   }





//   /// [undefined] 미확인부
//   void _receiveAnswer(data) async {
//     WebRTCModel model = WebRTCModel.fromJson(data);

//     debugPrint('[webRTC] receive answer : ${model.answerType}');

//     await _peer!.setRemoteDescription(RTCSessionDescription(
//         model.answerSDP!.replaceFirst('useinbandfec=1',
//             'useinbandfec=1; stereo=1; maxaveragebitrate=510000'),
//         model.answerType));

//     for (IceCandidateModel candidateModel in _candidateList) {
//       if (!_isConnected) {
//         debugPrint('[webRTC] send iceCandidate : ${candidateModel.toJson()}');
//         super.socketEmit('iceCandidate', candidateModel.toJson());
//         break;
//       }
//     }
//   }

//   /// [undefined] 미확인부
//   void _remotePeerIceCandidate(data) async {
//     try {
//       IceCandidateModel model = IceCandidateModel.fromJson(data);

//       RTCIceCandidate candidate =
//           RTCIceCandidate(model.candidate, model.sdpMid, model.sdpMLineIndex);

//       await _peer!.addCandidate(candidate);
//     } catch (e) {
//       debugPrint('[webRTC] remoteIceCandidate error : $e');
//     }
//   }

//   /// [undefined] 미확인부
//   void _refusedConnection(_) async {
//     await close(_);
//   }


//   void _receiveDrawing(data) {
//     Offset? receivedPoint = data['point'] == null
//         ? null
//         : Offset((data['point']['x'] as num).toDouble(), (data['point']['y'] as num).toDouble());

//     Color color = Color(int.parse(data['color'], radix: 16)); // 색상 정보 파싱

//     List<DrawingPoint> updatedPoints = List.from(drawingPointsNotifier.value)
//       ..add(DrawingPoint(receivedPoint, color));

//     drawingPointsNotifier.value = updatedPoints;
//   }

//   /// [그림판] 종료 신호를 소켓을 통해 수신
//   void _receiveDrawingEnd(data) {
//     List<DrawingPoint> updatedPoints = List.from(drawingPointsNotifier.value)
//       ..add(DrawingPoint(null, Colors.transparent)); // DrawingPoint with null point

//     drawingPointsNotifier.value = updatedPoints;
//   }

//   void _receiveClearDrawing(_) {
//       drawingPointsNotifier.value = [];
//   }
// }
