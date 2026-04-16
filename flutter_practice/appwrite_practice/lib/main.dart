import 'package:appwrite_practice/app_state.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final client = Client()
      .setEndpoint('https://fra.cloud.appwrite.io/v1')
      .setProject('69df82f2001157e1f2a5')
      .setSelfSigned(status: true); // for local dev

  final account = Account(client);

  runApp(MyApp(account: account));
}
