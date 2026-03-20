import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../model/character_model.dart';
import '../model/serializers.dart';

class CharacterService {
  final String url = "https://dbd.tricky.lol/api/characters";

  Future<List<CharacterModel>> fetchCharacters() async {
    var customZone = Zone.current.fork(
      specification: ZoneSpecification(
        print: (self, parent, zone, message) {
          parent.print(zone, "Zone Log: $message");
        },
        handleUncaughtError: (self, parent, zone, error, stackTrace) {
          parent.print(zone, "Zone Error: $error");
        },
      ),
    );

    return customZone.run(() async {
      print("Fetching characters from $url");

      final response = await http.get(Uri.parse(url));

      print("Response received: ${response.statusCode}");

      if (response.statusCode == 200) {
        return compute(parseCharacters, response.body);
      } else {
        throw Exception("Failed to load characters");
      }
    });
  }
}

List<CharacterModel> parseCharacters(String responseBody) {
  final Map<String, dynamic> decoded = json.decode(responseBody);

  final list = decoded.values.toList();

  return list.map((jsonItem) {
    return CharacterModel((b) => b
      ..name = jsonItem['name'] ?? ''
      ..role = jsonItem['role'] ?? ''
      ..gender = jsonItem['gender'] ?? '');
  }).toList();
}