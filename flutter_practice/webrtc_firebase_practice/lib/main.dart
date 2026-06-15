import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'signaling.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebRTC Firebase Practice',
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
  Signaling signaling = Signaling();
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? roomId;
  TextEditingController textEditingController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    _initRenderers();
  }

  void _initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();

    signaling.onAddRemoteStream = ((stream) {
      _remoteRenderer.srcObject = stream;
      setState(() {});
    });

    await signaling.openUserMedia(_localRenderer, _remoteRenderer);
    setState(() {});
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Call App"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              ElevatedButton(
                onPressed: () async {
                  roomId = await signaling.createRoom(_remoteRenderer);
                  textEditingController.text = roomId!;
                  setState(() {});
                },
                child: const Text("2. Create room"),
              ),
              ElevatedButton(
                onPressed: () {
                  signaling.joinRoom(textEditingController.text, _remoteRenderer);
                },
                child: const Text("3. Join room"),
              ),
              ElevatedButton(
                onPressed: () {
                  signaling.hangUp(_localRenderer);
                  setState(() {
                    roomId = null;
                    textEditingController.text = "";
                  });
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red[100]),
                child: const Text("Hangup"),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Join the following Room: "),
                Flexible(
                  child: TextFormField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text("Local Video"),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                            child: RTCVideoView(_localRenderer, mirror: true),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      children: [
                        const Text("Remote Video"),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                            child: RTCVideoView(_remoteRenderer),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
