import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

class GameProvider extends ChangeNotifier {
  int score;
  GameProvider({this.score = 0});

  void increment() {
    score++;
    notifyListeners();
  }
}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}


class _GamePageState extends State<GamePage> {
  List<bool> isvisible=List.filled(6, false);
  int score = 0;

  Future<void> triggeraVisiblity() async{
    Random random=Random();
    int value = random.nextInt(6);
    setState(() {
      isvisible[value]=true;
    });
      
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      isvisible[value]=false;
    });
    
  }
@override
void initState() {
  super.initState();
  startGame();
}


void startGame() async {
  for (int i = 0; i < 10; i++) {
    await triggeraVisiblity();
  }

}

  void incrementScore(bool isvisible) {
    if(isvisible){
      setState(() {
      score++;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 110,
            child: Text(
              "Score: $score",
              style: TextStyle(fontSize: 50),
            ),
          ),
          Positioned(
            top: 300,
            left: 20,
            right: 20,
            bottom: 20,
            child: SizedBox(
              height: 300,
              child: GridView.count(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 3,
                children:List.generate(isvisible.length, (index) {
                return Hole(
                  isvisible: isvisible[index],
                  onTap: () => incrementScore(isvisible[index]),
                );
                
                },
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 100,
            left:125,
            child: ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Back to MainMenu")))
        ],
      ),
    );
  }
}

class Hole extends StatelessWidget {
  final bool isvisible;
  final VoidCallback? onTap;

  Hole({this.isvisible = false, this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: isvisible
              ? const Color.fromARGB(255, 244, 95, 54)
              : Colors.green.shade700,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}