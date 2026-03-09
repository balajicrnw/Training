import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  bool visible = true;
  double size = 100;
  double rotation = 0;
  bool isCircle = true;

  late AnimationController _loopController;
  late AnimationController _flingController;
  late AnimationController _animateToController;

  @override
  void initState() {
    super.initState();

    _loopController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _flingController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 200,
      duration: const Duration(seconds: 2),
    );

    _animateToController = AnimationController(
      vsync: this,
      lowerBound: 50,
      upperBound: 150,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _loopController.dispose();
    _flingController.dispose();
    _animateToController.dispose();
    super.dispose();
  }

  void _flingAnimation() {
    if (!_flingController.isAnimating) {
      _flingController
        ..reset()
        ..fling(velocity: 2.0);
    }
  }

  void _animateToExample() {
    _animateToController.animateTo(
      150, 
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
    ).then((_) {
      _animateToController.animateTo(
        50, 
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: rotation),
                  duration: const Duration(seconds: 1),
                  builder: (context, value, child) {
                    return Transform.rotate(
                      angle: value,
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            isCircle ? size / 2 : 10,
                          ),
                          image: const DecorationImage(
                            image: NetworkImage(
                              "https://images.unsplash.com/photo-1715316110001-c2374d87e753?w=600&auto=format&fit=crop&q=60",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 40),

                
                RotationTransition(
                  turns: _loopController,
                  child: Container(
                    width: 120,
                    height: 120,
                    color: Colors.green,
                  ),
                ),

                const SizedBox(height: 40),

                
                AnimatedBuilder(
                  animation: _flingController,
                  builder: (context, child) {
                    return Container(
                      width: _flingController.value,
                      height: _flingController.value,
                      color: Colors.red,
                    );
                  },
                ),

                const SizedBox(height: 40),

                
                AnimatedBuilder(
                  animation: _animateToController,
                  builder: (context, child) {
                    return Container(
                      width: _animateToController.value,
                      height: _animateToController.value,
                      color: Colors.blue,
                    );
                  },
                ),

                const SizedBox(height: 40),

                AnimatedOpacity(
                  opacity: visible ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  child: const Text(
                    "Hello",
                    style: TextStyle(fontSize: 30),
                  ),
                ),

                const SizedBox(height: 40),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      visible = !visible;
                      size = size == 100 ? 200 : 100;
                      rotation += 1.57;
                      isCircle = !isCircle;
                    });

                    _flingAnimation(); 
                    _animateToExample(); 
                  },
                  child: const Text("Animate All Shapes"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}