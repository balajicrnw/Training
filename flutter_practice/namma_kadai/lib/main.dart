import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'services/local_storage_service_impl.dart';
import 'core/providers.dart';
import 'view/product_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  
  // Initialize LocalStorageService
  final storageService = LocalStorageServiceImpl();
  await storageService.init();
  
  runApp(
    ProviderScope(
      overrides: [
        localStorageServiceProvider.overrideWithValue(storageService),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namma Kadai',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const ProductListScreen(),
    );
  }
}
