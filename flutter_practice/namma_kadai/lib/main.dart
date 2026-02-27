import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namma_kadai/viewmodel/view_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'services/local_storage_service_impl.dart';
import 'core/services/local_storage_service.dart';
import 'view/product_list_screen.dart';
import '../viewmodel/view_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await localStorageServiceProvider.init();
  
  runApp(
    const ProviderScope(
      child: MyApp(),
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
