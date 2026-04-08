import 'package:flutter/material.dart';
import '../memento/originator.dart';
import '../memento/caretaker.dart';
import 'dart:math';

class DrawingPage extends StatefulWidget {
  @override
  State<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  final originator = Originator();
  final caretaker = Caretaker();

  void changeColor() {
  caretaker.save(originator.save());

  setState(() {
    originator.state.color =
        Colors.primaries[Random().nextInt(Colors.primaries.length)];
  });
}
  void increaseSize() {
    caretaker.save(originator.save());

    setState(() {
      originator.state.size += 10;
    });
  }

  void undo() {
    final memento = caretaker.undo();
    if (memento != null) {
      setState(() {
        originator.restore(memento);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Memento Pattern - Drawing App")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: originator.state.size,
              height: originator.state.size,
              color: originator.state.color,
            ),
          ),

          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: changeColor,
            child: Text("Change Color"),
          ),

          ElevatedButton(
            onPressed: increaseSize,
            child: Text("Increase Size"),
          ),

          ElevatedButton(
            onPressed: undo,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text("Undo"),
          ),
        ],
      ),
    );
  }
}