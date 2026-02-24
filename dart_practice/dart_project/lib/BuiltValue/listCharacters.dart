import 'dart:convert';
import 'package:http/http.dart' as http;
import 'character.dart';
import 'serializers.dart';

Future<void> main() async {
  final url =
      Uri.parse('https://potterapi-fedeperin.vercel.app/es/characters');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    List data = jsonDecode(response.body);
    final characters = data
        .map((e) => serializers.deserializeWith(
              Character.serializer,
              e,
            )!)
        .toList();

    // Print details
    for (var c in characters) {
      print("Name: ${c.fullName}");
      print("House: ${c.hogwartsHouse}");
      print("Actor: ${c.interpretedBy}");
      print("---------------------");
    }
  } else {
    print("Error loading API");
  }
}