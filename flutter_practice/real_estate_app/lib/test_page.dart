import 'package:flutter/material.dart';
import 'package:real_estate_app/pages/booking_page.dart';
import 'package:real_estate_app/pages/details_page.dart';
import 'package:real_estate_app/pages/home_page.dart';
import 'package:real_estate_app/pages/search_page.dart';
import 'package:real_estate_app/pages/settings_page.dart';
import 'package:real_estate_app/widgets/app_bottom_navigator.dart';
import 'package:real_estate_app/widgets/app_calander.dart';
import 'package:real_estate_app/widgets/app_search_bar.dart';
import 'ui.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int index = 0;
  final List<Widget> pages = [
    HomePage(),
    DetailsPage(),
    SearchPage(),
    BookingPage(),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFFfdffe5), Colors.white], // Light Blue
          ),
        ),

        child: SafeArea(
          child: Stack(
            children: [
              IndexedStack(index: index - 1, children: pages),
              Positioned(
                bottom: 24,
                left: 0,
                right: 0,
                child: Center(
                  child: AppBottomNavigator(
                    selected: index,
                    onTap: (int indexReturned) {
                      setState(() {
                        index = indexReturned;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
