import 'package:flavor_practice/flavors/flavor_config.dart';
import 'package:flavor_practice/main.dart';
import 'package:flutter/material.dart';

void mainCommon({
  required Flavor flavor,
  required String name,
  String? apiUrl,
}) {
  FlavorConfig(flavor: flavor, name: name, apiUrl: apiUrl);
  runApp(MyApp());
}
