import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:ball_game/GamePage.dart';
import 'package:flutter/material.dart';

class Mainmenu extends StatefulWidget {
  const Mainmenu({super.key});

  @override
  State<Mainmenu> createState() => _MainmenuState();
}

class _MainmenuState extends State<Mainmenu> {
  double size = 300;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Stack(
        children: [
          GestureDetector(
            child: Center(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
                width: size,
                height: size,
                child: Image.asset("assets/Duck.png"),
              ),
            ),
            onTap: () async {
              setState(() {
                size = 400;
              });
              AudioPlayer().play(AssetSource('duck.mp3'));
              await Future.delayed(Duration(milliseconds: 500));
              setState(() {
                size = 300;
              });
            },
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "MANDA ADI",
                  style: TextStyle(
                    color: Color.fromARGB(159, 5, 161, 252),
                    fontSize: 50,
                  ),
                ),

                SizedBox(height: 40),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GamePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 60),
                    backgroundColor: Color.fromARGB(223, 131, 234, 217),
                  ),
                  child: Text("Play", style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
