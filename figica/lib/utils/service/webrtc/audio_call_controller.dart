// import 'package:flutter/material.dart';
// import 'package:web_rtc/service/webrtc_socket.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';
// import 'package:web_rtc/model/icecandidate_model.dart';
// import 'package:web_rtc/model/webrtc_model.dart';
// import 'package:vibration/vibration.dart';

// enum ScreenState { loading, initDone, receivedCalling }

// class AudioCallController extends WebRTCSocket {
//   String? to;
//   String? _from;
//   RTCPeerConnection? _peer;

//   MediaStream? _localStream;
//   bool _isAudioOn = true;
//   bool _isConnected = false;
//   ValueNotifier<bool> localAudioNotifier = ValueNotifier<bool>(true);
//   ValueNotifier<ScreenState> screenNotifier = ValueNotifier<ScreenState>(ScreenState.loading);
//   final List<IceCandidateModel> _candidateList = [];
//   RTCSessionDescription? _answer;

//   BuildContext? audioCallViewContext;

//   Future<void> initController() async {
//     await _initSocket();
//     await _initPeer();
//   }

//   Future<void> sendOffer() async {
//     if (to == null) return;
//     await _initPeer();
//     await _startMedia();
//     final offer = await _peer!.createOffer({
//       'OfferToReceiveAudio': true,
//       'OfferToReceiveVideo': false,
//     });
//     await _peer!.setLocalDescription(offer);
//     _emitOffer(offer);
//   }

//   Future<void> _startMedia() async {
//     final constraints = {
//       'audio': true,
//       'video': false,
//     };
//     _localStream = await navigator.mediaDevices.getUserMedia(constraints);
//     for (var track in _localStream!.getTracks()) {
//       _peer!.addTrack(track, _localStream!);
//     }
//   }

//   void _emitOffer(RTCSessionDescription offer) {
//     final model = WebRTCModel(
//       from: _from,
//       to: to,
//       offerSDP: offer.sdp,
//       offerType: offer.type,
//       audioOnly: true,
//     );
//     socketEmit('offer', model.toJson());
//   }

//   void toggleMute() {
//     if (_localStream != null) {
//       _isAudioOn = !_isAudioOn;
//       for (var track in _localStream!.getAudioTracks()) {
//         track.enabled = _isAudioOn;
//       }
//       localAudioNotifier.value = _isAudioOn;
//     }
//   }

//   Future<void> close(_) async {
//     if (audioCallViewContext == null) {
//       return;
//     }
//     super.socketEmit('disconnectAudioPeer', {'to': to});
//     Navigator.pop(audioCallViewContext!);
//     audioCallViewContext = null;
//     await _resetElements();
//   }


//   Future<void> _resetElements() async {
//     await turnOffMedia();
//     _peer?.close();
//     _peer = null;
//     await _initPeer();
//     localAudioNotifier.value = false;
//   }

//   void dispose() {
//     localAudioNotifier.dispose();
//     _localStream?.dispose();
//     _peer?.dispose();
//     super.disconnectSocket();
//   }




  
//   /// [backend] ///
//   Future<void> _initSocket() async {
//     _from = await super.getUserId();

//     if (_from != null) {
//       super.socketOn('offer', _receiveOffer);
//       super.socketOn('refuseV', _refusedConnection);
//       super.socketOn('answer', _receiveAnswer);
//       super.socketOn('remoteIceCandidate', _remotePeerIceCandidate);
//       super.socketOn('disconnectAudioPeer', close);
//     }
//   }






//   /// [backend] ///
//   Future<void> turnOffMedia() async {
//       localAudioNotifier.value = false;

//       for (MediaStreamTrack track in _localStream!.getTracks()) {
//         track.enabled = false;
//         await track.stop();
//       }

//       await _localStream?.dispose();
//       _localStream = null;
//       _isAudioOn = false;
//   }






//   /// [backend] ///
//   Future<void> _initPeer() async {
//     _peer = await createPeerConnection({
//       'iceServers': [
//         {'url': 'stun:stun.l.google.com:19302'},
//       ],
//     });

//     _peer!.onIceCandidate = _iceCandidateEvent;
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
//   void _peerStateChange(RTCPeerConnectionState state) {
//     if (state == RTCPeerConnectionState.RTCPeerConnectionStateConnected &&
//         !_isConnected) {
//       _isConnected = true;
//     } else if (state == RTCPeerConnectionState.RTCPeerConnectionStateFailed) {
//       _peer?.restartIce();
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

//   /// [backend] ///
//   void _receiveOffer(data) async {
//     WebRTCModel model = WebRTCModel.fromJson(data);
//     debugPrint('[webRTC] receive offer : ${model.to} from ${model.from}');

//     await _peer!.setRemoteDescription(
//         RTCSessionDescription(model.offerSDP, model.offerType));
//     await _startMedia();
//     _answer = await _peer!.createAnswer({
//       'mandatory': {
//         'OfferToReceiveAudio': true,
//         'OfferToReceiveVideo': false,
//       }
//     });
//     await _peer!.setLocalDescription(_answer!);

//     to = model.from;

//     screenNotifier.value = ScreenState.receivedCalling;

//     if (await Vibration.hasVibrator() ?? false) {
//       Vibration.vibrate(duration: 1500);
//     }
//   }


// }
