import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../provider/count_provider.dart';

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  late VideoPlayerController controller;
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.asset('assets/background.mp4')
      ..initialize().then((_) {
        setState(() {});
        controller.setLooping(true); // 🔁 loop
        controller.setVolume(0);     // 🔇 mute
        controller.play();
      });
  }

  @override
  void dispose() {
    controller.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.value.isInitialized
          ? Stack(
              children: [
                // 🎥 FULL SCREEN VIDEO
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: controller.value.size.width,
                      height: controller.value.size.height,
                      child: VideoPlayer(controller),
                    ),
                  ),
                ),

                // 🌑 DARK OVERLAY (optional for better UI visibility)
                Container(
                  color: Colors.black.withOpacity(0.4),
                ),

                // 🎮 UI ON TOP
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "This is a new page",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          context.read<CountProvider>().decrement();
                        },
                        child: Text(
                          context.watch<CountProvider>().count.toString(),
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextField(
                        controller: nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Enter a name',
                          hintStyle: TextStyle(color: Colors.white70),
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<CountProvider>()
                              .changeName(nameController.text);
                        },
                        child: const Text("Change Name"),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}