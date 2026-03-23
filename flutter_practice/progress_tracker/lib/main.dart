import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const RepoAnalyzerApp());
}

class RepoAnalyzerApp extends StatelessWidget {
  const RepoAnalyzerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Repo AI Analyzer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AnalyzerHomeScreen(),
    );
  }
}
