import 'package:flutter/material.dart';

class AppNavbar extends StatefulWidget {
  const AppNavbar({super.key});

  @override
  State<AppNavbar> createState() => _AppNavbarState();
}

class _AppNavbarState extends State<AppNavbar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "MyJio"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Recharge"),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: "JioTunes",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "JioCare"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "GetHome"),
        BottomNavigationBarItem(
          icon: Container(color: const Color.fromARGB(255, 255, 255, 255)),
        ),
      ],
    );
  }
}
