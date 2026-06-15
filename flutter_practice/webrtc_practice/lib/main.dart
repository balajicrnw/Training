import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

void main() {
  // ✅ FIX: WidgetsFlutterBinding must be initialized before any plugin
  // This prevents the "flutter/lifecycle channel discarded" error
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebRTC Video Call',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const VideoCallScreen(),
    );
  }
}

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final _localVideoRenderer = RTCVideoRenderer();
  final _remoteVideoRenderer = RTCVideoRenderer();
  final sdpController = TextEditingController();

  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;

  bool _isGathering = false;
  bool _sdpReady = false;
  String _status = 'Initializing...';

  @override
  void initState() {
    super.initState();
    // ✅ FIX: Delay init slightly so framework listeners are registered first
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  Future<void> _init() async {
    await _initRenderers();
    await _createPeerConnection();
    await _getUserMedia();
  }

  @override
  void dispose() {
    _localVideoRenderer.dispose();
    _remoteVideoRenderer.dispose();
    sdpController.dispose();
    _localStream?.getTracks().forEach((t) => t.stop());
    _localStream?.dispose();
    _peerConnection?.dispose();
    super.dispose();
  }

  Future<void> _initRenderers() async {
    await _localVideoRenderer.initialize();
    await _remoteVideoRenderer.initialize();
  }

  Future<void> _getUserMedia() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {
        'facingMode': 'user',
        'width': {'ideal': 1280},
        'height': {'ideal': 720},
      },
    };

    try {
      _localStream = await navigator.mediaDevices.getUserMedia(
        mediaConstraints,
      );

      setState(() {
        _localVideoRenderer.srcObject = _localStream;
        _status =
            'Camera ready ✅ — tap Create Offer (caller) or paste SDP (callee)';
      });

      for (final track in _localStream!.getTracks()) {
        await _peerConnection?.addTrack(track, _localStream!);
      }
    } catch (e) {
      _setStatus('Camera error ❌: $e');
    }
  }

  Future<void> _createPeerConnection() async {
    // ✅ FIX: "urls" not "url" — critical typo fix
    // ✅ FIX: unified-plan — required for web/browser compatibility
    // ✅ FIX: TURN servers added for networks that block UDP
    final Map<String, dynamic> configuration = {
      'sdpSemantics': 'unified-plan',
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
        {'urls': 'stun:stun1.l.google.com:19302'},
        {'urls': 'stun:stun2.l.google.com:19302'},
        {'urls': 'stun:stun.stunprotocol.org:3478'},
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

    _peerConnection = await createPeerConnection(configuration);

    _peerConnection?.onIceCandidate = (RTCIceCandidate candidate) {
      print('ICE candidate: ${candidate.candidate}');
    };

    _peerConnection?.onIceConnectionState = (RTCIceConnectionState state) {
      print('ICE state: $state');
      switch (state) {
        case RTCIceConnectionState.RTCIceConnectionStateConnected:
          _setStatus('Connected ✅ — video should appear!');
          break;
        case RTCIceConnectionState.RTCIceConnectionStateFailed:
          _setStatus('Connection failed ❌ — try again on mobile hotspot');
          break;
        case RTCIceConnectionState.RTCIceConnectionStateDisconnected:
          _setStatus('Disconnected ⚠️');
          break;
        default:
          break;
      }
    };

    _peerConnection?.onSignalingState = (RTCSignalingState state) {
      print('Signaling state: $state');
    };

    _peerConnection?.onTrack = (RTCTrackEvent event) {
      print('Got remote track: ${event.track.kind}');
      if (event.track.kind == 'video' && event.streams.isNotEmpty) {
        setState(() {
          _remoteVideoRenderer.srcObject = event.streams[0];
        });
        _setStatus('Remote video received ✅');
      }
    };
  }

  // ✅ FIX: Force VP8 codec — VP8 works on ALL platforms (web + Android + iOS)
  // H264 is Android default but not always supported in browsers
  String _preferVP8(String sdp) {
    final lines = sdp.split('\n');

    String? vp8Payload;
    for (final line in lines) {
      if (line.toUpperCase().contains('VP8/90000')) {
        // Line: a=rtpmap:96 VP8/90000
        final match = RegExp(
          r'a=rtpmap:(\d+) VP8',
          caseSensitive: false,
        ).firstMatch(line);
        if (match != null) {
          vp8Payload = match.group(1);
          break;
        }
      }
    }

    if (vp8Payload == null) {
      print('VP8 not found in SDP — using as-is');
      return sdp;
    }

    print('Forcing VP8 payload type: $vp8Payload');

    final result = <String>[];
    for (final line in lines) {
      if (line.startsWith('m=video')) {
        // m=video 9 UDP/TLS/RTP/SAVPF 96 97 98 99 100 ...
        final parts = line.trim().split(' ');
        if (parts.length > 3) {
          final payloads = List<String>.from(parts.sublist(3));
          payloads.remove(vp8Payload);
          payloads.insert(0, vp8Payload!); // VP8 first = highest priority
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

  // ✅ FIX: 3-second timeout instead of waiting for GatheringStateComplete
  // GatheringStateComplete can hang forever on restricted networks
  Future<void> _waitAndGetSDP() async {
    setState(() {
      _isGathering = true;
      _sdpReady = false;
      _status = 'Gathering ICE candidates... (3 seconds)';
    });

    await Future.delayed(const Duration(seconds: 3));

    final desc = await _peerConnection!.getLocalDescription();
    if (desc != null) {
      setState(() {
        sdpController.text = jsonEncode(desc.toMap());
        _isGathering = false;
        _sdpReady = true;
        _status = 'SDP ready ✅ — tap Copy and send to the other device';
      });
    } else {
      setState(() {
        _isGathering = false;
        _status = 'Failed to get SDP ❌';
      });
    }
  }

  Future<void> _createOffer() async {
    try {
      _setStatus('Creating offer...');

      final offer = await _peerConnection!.createOffer({
        'offerToReceiveAudio': true,
        'offerToReceiveVideo': true,
      });

      // ✅ Apply VP8 preference before setting local description
      final fixedSdp = _preferVP8(offer.sdp ?? '');
      final fixedOffer = RTCSessionDescription(fixedSdp, offer.type);

      await _peerConnection!.setLocalDescription(fixedOffer);
      await _waitAndGetSDP();
    } catch (e) {
      _setStatus('Offer error ❌: $e');
      print('Create offer error: $e');
    }
  }

  Future<void> _createAnswer() async {
    if (sdpController.text.isEmpty) {
      _showSnack('Paste the Offer SDP first');
      return;
    }

    try {
      final session = jsonDecode(sdpController.text);
      final type = session['type'] as String?;

      if (type != 'offer') {
        _showSnack('This is not an Offer SDP. Did you paste the right text?');
        return;
      }

      _setStatus('Setting remote offer...');

      // ✅ Apply VP8 to remote offer too
      final fixedRemoteSdp = _preferVP8(session['sdp'] as String);
      await _peerConnection!.setRemoteDescription(
        RTCSessionDescription(fixedRemoteSdp, type),
      );

      _setStatus('Creating answer...');

      final answer = await _peerConnection!.createAnswer({
        'offerToReceiveAudio': true,
        'offerToReceiveVideo': true,
      });

      // ✅ Apply VP8 to our answer
      final fixedAnswerSdp = _preferVP8(answer.sdp ?? '');
      final fixedAnswer = RTCSessionDescription(fixedAnswerSdp, answer.type);

      await _peerConnection!.setLocalDescription(fixedAnswer);
      await _waitAndGetSDP();
    } catch (e) {
      _setStatus('Answer error ❌: $e');
      print('Create answer error: $e');
    }
  }

  Future<void> _setRemoteDescription() async {
    if (sdpController.text.isEmpty) {
      _showSnack('Paste the Answer SDP first');
      return;
    }

    try {
      final session = jsonDecode(sdpController.text);
      final type = session['type'] as String?;

      if (type == 'offer') {
        _showSnack(
          'You pasted an Offer — use "Set Offer & Create Answer" instead',
        );
        return;
      }

      // ✅ Apply VP8 to the incoming answer too
      final fixedSdp = _preferVP8(session['sdp'] as String);
      await _peerConnection!.setRemoteDescription(
        RTCSessionDescription(fixedSdp, type),
      );

      sdpController.clear();
      setState(() => _sdpReady = false);
      _setStatus('Answer accepted ✅ — connecting...');
    } catch (e) {
      _setStatus('Set answer error ❌: $e');
      print('Set remote description error: $e');
    }
  }

  Future<void> _copyToClipboard() async {
    if (sdpController.text.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: sdpController.text));
    _showSnack('Copied to clipboard ✅');
  }

  Future<void> _pasteFromClipboard() async {
    final data = await Clipboard.getData('text/plain');
    if (data?.text != null && data!.text!.isNotEmpty) {
      setState(() {
        sdpController.text = data.text!;
        _sdpReady = false;
      });
      _showSnack('Pasted ✅');
    } else {
      _showSnack('Clipboard is empty');
    }
  }

  void _setStatus(String msg) {
    if (mounted) setState(() => _status = msg);
    print('STATUS: $msg');
  }

  void _showSnack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('WebRTC Video Call'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // ── Video boxes ──────────────────────────────────────
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildVideoBox(_localVideoRenderer, 'YOU', true),
                ),
                Expanded(
                  child: _buildVideoBox(_remoteVideoRenderer, 'REMOTE', false),
                ),
              ],
            ),
          ),

          // ── Status bar ───────────────────────────────────────
          Container(
            width: double.infinity,
            color: Colors.deepPurple.shade50,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                if (_isGathering)
                  const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                if (_isGathering) const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _status,
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),

          // ── SDP text field ───────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: TextField(
              controller: sdpController,
              maxLines: 4,
              style: const TextStyle(fontSize: 10),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'SDP — paste offer or answer here',
                filled: true,
                fillColor: Colors.grey.shade50,
                suffixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.copy, size: 18),
                      tooltip: 'Copy SDP',
                      onPressed: _sdpReady ? _copyToClipboard : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.paste, size: 18),
                      tooltip: 'Paste SDP',
                      onPressed: _pasteFromClipboard,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Buttons ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                _buildButton(
                  label: '1. Create Offer',
                  icon: Icons.call_made,
                  color: Colors.green.shade100,
                  onPressed: _isGathering ? null : _createOffer,
                ),
                _buildButton(
                  label: '2. Set Offer + Answer',
                  icon: Icons.call_received,
                  color: Colors.blue.shade100,
                  onPressed: _isGathering ? null : _createAnswer,
                ),
                _buildButton(
                  label: '3. Set Answer',
                  icon: Icons.check_circle_outline,
                  color: Colors.orange.shade100,
                  onPressed: _isGathering ? null : _setRemoteDescription,
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildVideoBox(RTCVideoRenderer renderer, String label, bool mirror) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: Colors.black),
        RTCVideoView(
          renderer,
          mirror: mirror,
          objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
        ),
        Positioned(
          bottom: 8,
          left: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback? onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 13)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.black87,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
