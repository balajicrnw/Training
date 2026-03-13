import 'package:ball_game/GamePage.dart';
import 'package:flutter/material.dart';

class Mainmenu extends StatefulWidget {
  @override
  _MainmenuState createState() => _MainmenuState();
}

class _MainmenuState extends State<Mainmenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  MaterialPageRoute(
                    builder: (context) => GamePage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 60),
                backgroundColor: Color.fromARGB(223, 131, 234, 217),
              ),
              child: Text(
                "Play",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}