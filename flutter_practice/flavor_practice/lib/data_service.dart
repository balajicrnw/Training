import 'dart:convert';
import 'package:flavor_practice/flavors/flavor_config.dart';
import 'package:http/http.dart' as http;

class DataService {
  final List<String> _localFacts = [
    "The Flutter logo is a bird called a Dash.",
    "Dart was originally called Dash.",
    "Flutter was first announced at Google I/O 2017.",
    "The first version of Flutter was called Sky.",
    "Hot reload is one of the most loved features of Flutter.",
  ];

  Future<String> fetchFact() async {
    final config = FlavorConfig.instance;

    if (config.flavor == Flavor.dev) {
      return _localFacts[DateTime.now().millisecond % _localFacts.length];
    }

    final apiUrl = config.apiUrl;
    if (apiUrl == null) return "No API URL configured for this flavor.";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.containsKey('setup') && data.containsKey('punchline')) {
          return "${data['setup']}\n\n${data['punchline']}";
        }
        return data['text'] ?? "No fact found.";
      } else {
        return "Failed to fetch fact: ${response.statusCode}";
      }
    } catch (e) {
      return "Error: $e";
    }
  }
}
