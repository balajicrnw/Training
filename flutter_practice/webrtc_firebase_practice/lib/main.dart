import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'signaling.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebRTC Call',
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
  final Signaling signaling = Signaling();
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  final TextEditingController _roomIdController = TextEditingController();

  String? roomId;
  String _status = 'Starting camera...';
  bool _inCall = false;
  bool _localReady = false;
  bool _remoteReady = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initRenderers());
  }

  Future<void> _initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();

    signaling.onAddRemoteStream = (stream) {
      setState(() {
        _remoteRenderer.srcObject = stream;
        _remoteReady = true;
        _status = '✅ Connected!';
      });
      if (kIsWeb) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) setState(() {});
        });
      }
    };

    try {
      await signaling.openUserMedia(_localRenderer, _remoteRenderer);
      setState(() {
        _localReady = true;
        _status = 'Camera ready — Create or Join a room';
      });
    } catch (e) {
      setState(() => _status = '❌ Camera error: $e');
    }
  }

  Future<void> _createRoom() async {
    setState(() => _status = 'Creating room...');
    try {
      roomId = await signaling.createRoom(_remoteRenderer);
      _roomIdController.text = roomId!;
      setState(() {
        _inCall = true;
        _status = 'Room created ✅ — share the Room ID';
      });
    } catch (e) {
      setState(() => _status = '❌ Error: $e');
    }
  }

  Future<void> _joinRoom() async {
    final id = _roomIdController.text.trim();
    if (id.isEmpty) {
      _showSnack('Enter a Room ID first');
      return;
    }
    setState(() => _status = 'Joining room...');
    try {
      await signaling.joinRoom(id, _remoteRenderer);
      setState(() {
        roomId = id;
        _inCall = true;
        _status = 'Joined ✅ — waiting for remote video...';
      });
    } catch (e) {
      setState(() => _status = '❌ Error: $e');
    }
  }

  Future<void> _hangUp() async {
    await signaling.hangUp(_localRenderer);
    setState(() {
      roomId = null;
      _inCall = false;
      _remoteReady = false;
      _roomIdController.clear();
      _remoteRenderer.srcObject = null;
      _status = 'Call ended — Camera ready';
    });
  }

  void _copyRoomId() {
    if (roomId == null) return;
    Clipboard.setData(ClipboardData(text: roomId!));
    _showSnack('Room ID copied! ✅');
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    _roomIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Video Call [${kIsWeb ? 'Web' : 'Android'}]'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // ── Status bar ───────────────────────────────────────
          Container(
            width: double.infinity,
            color: _status.contains('❌')
                ? Colors.red.shade50
                : Colors.deepPurple.shade50,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              _status,
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ),

          // ── Video boxes ──────────────────────────────────────
          Expanded(
            child: Row(
              children: [
                // Local
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(color: Colors.black),
                      if (_localReady)
                        RTCVideoView(
                          _localRenderer,
                          mirror: true,
                          objectFit:
                              RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                        )
                      else
                        const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(color: Colors.white54),
                              SizedBox(height: 8),
                              Text(
                                'Starting camera...',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      _label('YOU'),
                    ],
                  ),
                ),

                // Remote
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(color: Colors.black87),
                      if (_remoteReady)
                        RTCVideoView(
                          _remoteRenderer,
                          objectFit:
                              RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                        )
                      else
                        const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.white24,
                                size: 48,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Waiting for remote...',
                                style: TextStyle(
                                  color: Colors.white38,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      _label('REMOTE'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Room ID row ──────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            child: Row(
              children: [
                const Text(
                  'Room ID:',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _roomIdController,
                    enabled: !_inCall,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    decoration: InputDecoration(
                      hintText: 'Paste Room ID to join',
                      hintStyle: const TextStyle(color: Colors.white38),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.white24),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.white24),
                      ),
                    ),
                  ),
                ),
                // ✅ Copy Room ID button — always visible when roomId exists
                if (roomId != null) ...[
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: _copyRoomId,
                    icon: const Icon(Icons.copy, size: 16),
                    label: const Text('Copy ID'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // ── Action buttons ────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _inCall ? null : _createRoom,
                    icon: const Icon(Icons.add_call, size: 16),
                    label: const Text('Create Room'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade100,
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _inCall ? null : _joinRoom,
                    icon: const Icon(Icons.call, size: 16),
                    label: const Text('Join Room'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade100,
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _inCall ? _hangUp : null,
                  icon: const Icon(Icons.call_end, size: 16),
                  label: const Text('End'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade300,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Positioned(
      bottom: 8,
      left: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
