import 'dart:convert';
import 'package:http/http.dart' as http;
import 'character_model.dart';
import 'serializers.dart';

Future<void> main() async {
  final url =
      Uri.parse('https://rickandmortyapi.com/api/character');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final  data = jsonDecode(response.body) as Map<String, dynamic>; 
    final results = data['results'] as List<dynamic>;  
    final characters = results
        .map((e) => serializers.deserializeWith(
              Characters.serializer,
              e,
            )!)
        .toList();

    // Print details
    for (var c in characters) {
      print("ID: ${c.id}");
      print("Name: ${c.name}");
      print("Species: ${c.species}");
      print("---------------------");
    }
  } else {
    print("Error loading API");
  }
}