import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class GamePage extends StatefulWidget {
  const GamePage({super.key});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int time = 40;
  AudioPlayer player = AudioPlayer();

  List<bool> isvisible = List.filled(12, false);
  int score = 0;

  bool isGameRunning = true;

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
    } catch (e) {}
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
            child: Text("$time", style: const TextStyle(fontSize: 50)),
          ),
          Positioned(
            top: 150,
            left: width * 0.3,
            child: Text("Score: $score", style: const TextStyle(fontSize: 50)),
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
              children: List.generate(isvisible.length, (index) {
                return Hole(
                  key: ValueKey(index), // ✅ ensures widget rebuild per hole
                  isvisible: isvisible[index],
                  onTap: () {
                    incrementScore(isvisible[index]);
                    setState(() {
                      isvisible[index] = false;
                    });
                  },
                );
              }),
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

class Hole extends StatefulWidget {
  final bool isvisible;
  final VoidCallback? onTap;

  const Hole({required Key key, this.isvisible = false, this.onTap})
    : super(key: key);

  @override
  _HoleState createState() => _HoleState();
}

class _HoleState extends State<Hole> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _clicked = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(Hole oldWidget) {
    super.didUpdateWidget(oldWidget);

    // ✅ Reset state if visibility changed
    if (widget.isvisible && !_clicked) {
      _controller.forward(from: 0.0);
    } else if (!widget.isvisible) {
      _controller.reset();
      _clicked = false;
    }
  }

  void handleTap() {
    if (!_clicked && widget.isvisible) {
      _clicked = true;
      _controller.reverse(from: _controller.value);
      widget.onTap?.call();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black54,
          shape: BoxShape.circle,
        ),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Align(
              alignment: Alignment(0, _animation.value),
              child: child,
            );
          },
          child: Image.asset("assets/Duck.png"),
        ),
      ),
    );
  }
}
