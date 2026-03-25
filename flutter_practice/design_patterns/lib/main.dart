import 'package:flutter/material.dart';
import 'abstract_factory/factory/ui_factory.dart';
import 'abstract_factory/factory/light_factory.dart';
import 'abstract_factory/factory/dark_factory.dart';
import 'abstract_factory/screens/home_page.dart';
import 'abstract_factory/core/theme_selector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Toggle this boolean to switch between LightFactory and DarkFactory
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    // Abstract Factory: client code only knows about UIFactory
    final UIFactory factory = isDark ? DarkFactory() : LightFactory();

    return MaterialApp(
      title: 'Abstract Factory Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Abstract Factory Pattern'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // ThemeSelector from core/ — responsible for switching the factory
            ThemeSelector(
              isDark: isDark,
              onThemeChanged: (value) {
                setState(() {
                  isDark = value;
                });
              },
            ),
            const Divider(),
            // HomePage uses only UIFactory — it doesn't know Light or Dark details
            Expanded(
              child: HomePage(factory: factory),
            ),
          ],
        ),
      ),
    );
  }
}
