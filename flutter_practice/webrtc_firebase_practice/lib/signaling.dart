import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

typedef StreamStateCallback = void Function(MediaStream stream);

class Signaling {
  Map<String, dynamic> get configuration => {
    if (kIsWeb) 'sdpSemantics': 'unified-plan',
    'iceServers': [
      {
        'urls': [
          'stun:stun1.l.google.com:19302',
          'stun:stun2.l.google.com:19302',
        ],
      },
      {
        'urls': 'turn:openrelay.metered.ca:80',
        'username': 'openrelayproject',
        'credential': 'openrelayproject',
      },
      {
        'urls': 'turn:openrelay.metered.ca:443',
        'username': 'openrelayproject',
        'credential': 'openrelayproject',
      },
      {
        'urls': 'turn:openrelay.metered.ca:443?transport=tcp',
        'username': 'openrelayproject',
        'credential': 'openrelayproject',
      },
    ],
  };

  RTCPeerConnection? peerConnection;
  MediaStream? localStream;
  MediaStream? remoteStream;
  String? roomId;
  bool isHost = false;
  StreamStateCallback? onAddRemoteStream;

  String _preferVP8(String sdp) {
    final lines = sdp.split('\n');
    String? vp8Payload;
    for (final line in lines) {
      final match = RegExp(
        r'a=rtpmap:(\d+) VP8',
        caseSensitive: false,
      ).firstMatch(line);
      if (match != null) {
        vp8Payload = match.group(1);
        break;
      }
    }
    if (vp8Payload == null) return sdp;

    final result = <String>[];
    for (final line in lines) {
      if (line.startsWith('m=video')) {
        final parts = line.trim().split(' ');
        if (parts.length > 3) {
          final payloads = List<String>.from(parts.sublist(3));
          payloads.remove(vp8Payload);
          payloads.insert(0, vp8Payload!);
          result.add('${parts.sublist(0, 3).join(' ')} ${payloads.join(' ')}');
        } else {
          result.add(line);
        }
      } else {
        result.add(line);
      }
    }
    return result.join('\n');
  }

  Future<String> createRoom(RTCVideoRenderer remoteRenderer) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference roomRef = db.collection('rooms').doc();

    peerConnection = await createPeerConnection(configuration);
    registerPeerConnectionListeners();

    localStream?.getTracks().forEach((track) {
      peerConnection?.addTrack(track, localStream!);
    });

    final Set<String> sentCandidates = {};
    var callerCandidatesCollection = roomRef.collection('callerCandidates');
    peerConnection?.onIceCandidate = (RTCIceCandidate candidate) {
      final key = candidate.candidate ?? '';
      if (key.isEmpty || sentCandidates.contains(key)) return;
      sentCandidates.add(key);
      callerCandidatesCollection.add(candidate.toMap());
    };

    RTCSessionDescription offer = await peerConnection!.createOffer();
    final fixedOffer = RTCSessionDescription(
      _preferVP8(offer.sdp ?? ''),
      offer.type,
    );
    await peerConnection!.setLocalDescription(fixedOffer);

    await roomRef.set({'offer': fixedOffer.toMap()});
    roomId = roomRef.id;
    isHost = true;

    // Listen for answer
    roomRef.snapshots().listen((snapshot) async {
      final data = snapshot.data() as Map<String, dynamic>?;
      if (data == null || data['answer'] == null) return;
      final remoteDesc = await peerConnection?.getRemoteDescription();
      if (remoteDesc != null) return;

      final fixedAnswerSdp = _preferVP8(data['answer']['sdp'] as String);
      await peerConnection?.setRemoteDescription(
        RTCSessionDescription(fixedAnswerSdp, data['answer']['type']),
      );
    });

    // Listen for callee ICE candidates
    roomRef.collection('calleeCandidates').snapshots().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          final data = change.doc.data() as Map<String, dynamic>;
          peerConnection!.addCandidate(
            RTCIceCandidate(
              data['candidate'],
              data['sdpMid'],
              data['sdpMLineIndex'],
            ),
          );
        }
      }
    });

    return roomId!;
  }

  Future<void> joinRoom(String roomId, RTCVideoRenderer remoteVideo) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference roomRef = db.collection('rooms').doc(roomId);
    var roomSnapshot = await roomRef.get();

    if (!roomSnapshot.exists) return;

    peerConnection = await createPeerConnection(configuration);
    registerPeerConnectionListeners();

    localStream?.getTracks().forEach((track) {
      peerConnection?.addTrack(track, localStream!);
    });

    final Set<String> sentCandidates = {};
    var calleeCandidatesCollection = roomRef.collection('calleeCandidates');
    peerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
      final key = candidate.candidate ?? '';
      if (key.isEmpty || sentCandidates.contains(key)) return;
      sentCandidates.add(key);
      calleeCandidatesCollection.add(candidate.toMap());
    };

    final data = roomSnapshot.data() as Map<String, dynamic>;
    final offerData = data['offer'] as Map<String, dynamic>;
    final fixedOfferSdp = _preferVP8(offerData['sdp'] as String);
    await peerConnection?.setRemoteDescription(
      RTCSessionDescription(fixedOfferSdp, offerData['type']),
    );

    RTCSessionDescription answer = await peerConnection!.createAnswer();
    final fixedAnswer = RTCSessionDescription(
      _preferVP8(answer.sdp ?? ''),
      answer.type,
    );
    await peerConnection!.setLocalDescription(fixedAnswer);

    await roomRef.update({
      'answer': {'type': fixedAnswer.type, 'sdp': fixedAnswer.sdp},
    });

    // Listen for caller ICE candidates
    roomRef.collection('callerCandidates').snapshots().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          final data = change.doc.data() as Map<String, dynamic>;
          peerConnection!.addCandidate(
            RTCIceCandidate(
              data['candidate'],
              data['sdpMid'],
              data['sdpMLineIndex'],
            ),
          );
        }
      }
    });
  }

  Future<void> openUserMedia(
    RTCVideoRenderer localVideo,
    RTCVideoRenderer remoteVideo,
  ) async {
    final stream = await navigator.mediaDevices.getUserMedia({
      'video': {
        'facingMode': 'user',
        'width': {'ideal': 1280},
        'height': {'ideal': 720},
      },
      'audio': true,
    });
    localVideo.srcObject = stream;
    localStream = stream;
  }

  Future<void> hangUp(RTCVideoRenderer localVideo) async {
    localVideo.srcObject?.getTracks().forEach((t) => t.stop());
    remoteStream?.getTracks().forEach((t) => t.stop());
    await peerConnection?.close();
    peerConnection = null;

    if (isHost && roomId != null) {
      final db = FirebaseFirestore.instance;
      final roomRef = db.collection('rooms').doc(roomId);
      final callee = await roomRef.collection('calleeCandidates').get();
      for (var doc in callee.docs) await doc.reference.delete();
      final caller = await roomRef.collection('callerCandidates').get();
      for (var doc in caller.docs) await doc.reference.delete();
      await roomRef.delete();
    }

    localStream?.dispose();
    remoteStream?.dispose();
    localStream = null;
    remoteStream = null;
    roomId = null;
    isHost = false;
  }

  void registerPeerConnectionListeners() {
    if (kIsWeb) {
      peerConnection?.onTrack = (RTCTrackEvent event) async {
        if (event.streams.isNotEmpty) {
          remoteStream = event.streams[0];
        } else {
          remoteStream ??= await createLocalMediaStream('remoteStream');
          remoteStream!.addTrack(event.track);
        }
        onAddRemoteStream?.call(remoteStream!);
      };
    } else {
      peerConnection?.onAddStream = (MediaStream stream) {
        remoteStream = stream;
        onAddRemoteStream?.call(stream);
      };
      peerConnection?.onTrack = (RTCTrackEvent event) async {
        if (remoteStream == null && event.streams.isNotEmpty) {
          remoteStream = event.streams[0];
          onAddRemoteStream?.call(remoteStream!);
        }
      };
    }
  }
}
