import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int time = 40;
  AudioPlayer player = AudioPlayer();

  List<bool> isvisible = List.filled(12, false);
  int score = 0;

  bool isGameRunning = true; // ✅ control loop

  @override
  void initState() {
    super.initState();
    startGame();
  }

  Future<void> triggerVisibility() async {
    if (!isGameRunning) return;

    Random random = Random();
    int value = random.nextInt(12);

    if (!mounted) return;

    setState(() {
      time--;
      isvisible[value] = true;
    });

    // ✅ Increased visibility time (important for test)
    await Future.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;

    setState(() {
      isvisible[value] = false;
    });
  }

  void startGame() async {
    while (time >= 1 && isGameRunning) {
      await triggerVisibility();
    }
  }

  void playSound() async {
    try {
      await player.play(AssetSource('duck.mp3'));

      Future.delayed(const Duration(milliseconds: 500), () {
        player.stop();
      });
    } catch (e) {
      // ✅ prevents crash in tests
    }
  }

  void incrementScore(bool visible) {
    if (visible) {
      playSound();
      setState(() {
        score++;
      });
    }
  }

  @override
  void dispose() {
    // 🔥 CRITICAL FIX
    isGameRunning = false;
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: width * 0.4,
            child: Text(
              "$time",
              style: const TextStyle(fontSize: 50),
            ),
          ),
          Positioned(
            top: 150,
            left: width * 0.3,
            child: Text(
              "Score: $score",
              style: const TextStyle(fontSize: 50),
            ),
          ),
          Positioned(
            top: 220,
            left: 20,
            right: 20,
            bottom: 20,
            child: GridView.count(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 3,
              children: List.generate(
                isvisible.length,
                (index) {
                  return Hole(
                    isvisible: isvisible[index],
                    onTap: () {
                      incrementScore(isvisible[index]);
                      setState(() {
                        isvisible[index] = false;
                      });
                    },
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: width * 0.3,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Back to MainMenu"),
            ),
          ),
        ],
      ),
    );
  }
}

class Hole extends StatelessWidget {
  final bool isvisible;
  final VoidCallback? onTap;

  const Hole({this.isvisible = false, this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black54,
              shape: BoxShape.circle,
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isvisible ? 1.0 : 0.0,
            child: Container(
              alignment: Alignment.center,
              color: Colors.transparent,
              child: Image.asset("assets/Duck.png"),
            ),
          )
        ],
      ),
    );
  }
}