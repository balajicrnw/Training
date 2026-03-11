import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RivePage extends StatefulWidget {
  @override
  _RivePageState createState() => _RivePageState();
}

class _RivePageState extends State<RivePage> {

  SMITrigger? click;

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");

    if (controller != null) {
      artboard.addController(controller);
      click = controller.findInput<bool>("click") as SMITrigger?;
    }
  }

  void _handleTap() {
    click?.fire();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: _handleTap,
          child: RiveAnimation.asset(
            "Icons.riv",
            onInit: _onRiveInit,
          ),
        ),
      ),
    );
  }
}