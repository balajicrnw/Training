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
  late AnimationController _colorController;

  late Animation<Color?> _colorAnimation;

  late AnimationController _curveController;
  late Animation<double> _curveAnimation;

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

    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _colorAnimation = _colorController.drive(
      ColorTween(
        begin: Colors.purple,
        end: Colors.yellow,
      ),
    );

    _curveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _curveAnimation = Tween<double>(begin: 50, end: 200).animate(
      CurvedAnimation(
        parent: _curveController,
        curve: Curves.elasticOut,
      ),
    );
  }

  @override
  void dispose() {
    _loopController.dispose();
    _flingController.dispose();
    _animateToController.dispose();
    _colorController.dispose();
    _curveController.dispose();
    super.dispose();
  }

  void _flingAnimation() {
    if (!_flingController.isAnimating) {
      _flingController
        ..reset()
        ..fling(velocity: 10.0);
    }
  }

  void _animateToExample() {
    _animateToController
        .animateTo(
      150,
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
    )
        .then((_) {
      _animateToController.animateTo(
        50,
        duration: const Duration(seconds: 2),
        curve: Curves.bounceInOut,
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
                          borderRadius:
                              BorderRadius.circular(isCircle ? size / 2 : 10),
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
                    width: 200,
                    height: 200,
                    child:Image.asset("Logo.png"),
                  ),
                ),

                const SizedBox(height: 40),

                SpinningSquare(animation: _loopController),

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

                AnimatedBuilder(
                  animation: _colorAnimation,
                  builder: (context, child) {
                    return Container(
                      width: 120,
                      height: 120,
                      color: _colorAnimation.value,
                    );
                  },
                ),

                const SizedBox(height: 40),

                AnimatedBuilder(
                  animation: _curveAnimation,
                  builder: (context, child) {
                    return Container(
                      width: _curveAnimation.value,
                      height: _curveAnimation.value,
                      color: Colors.teal,
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

                    _loopController.repeat();
                    _flingAnimation();
                    _animateToExample();
                    _curveController.repeat();
                  },
                  child: const Text("Animate All Shapes"),
                ),

                ElevatedButton(
                  onPressed: () {
                    _loopController.stop();
                  },
                  child: const Text("Stop"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SpinningSquare extends AnimatedWidget {
  const SpinningSquare({super.key, required Animation<double> animation})
      : super(listenable: animation);

  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: animation.value * -6.28,
      child: Container(
        width: 100,
        height: 100,
        
        child:Image.asset("Logo.png",width: 40,height: 40,),
        
        
      )
    );
  }
}