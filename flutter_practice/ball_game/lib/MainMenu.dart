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
      body: Stack(
        children: [
          Positioned(
            top: 300,
            left: 75,
            child: Text("MANDA ADI",style:TextStyle(color: Color.fromARGB(159, 5, 161, 252),fontSize: 50))),

          Positioned(
            top: 550,
            left: 100,
            child: ElevatedButton(onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>GamePage())),child:Text("Play"),style: ElevatedButton.styleFrom( minimumSize: Size(200, 60),backgroundColor: Color.fromARGB(223, 131, 234, 217) ),),)
        ],
      )
    );    throw UnimplementedError();
  }
}
