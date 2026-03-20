import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<dynamic> get(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("API failed with status: ${response.statusCode}");
    }
  }
}

class FieldExtractor {

  static List<Map<String, dynamic>> extract(
      List data, List<String> fields) {

    return data.map<Map<String, dynamic>>((item) {
      if (item is! Map<String, dynamic>) return {};

      final Map<String, dynamic> filtered = {};

      for (var field in fields) {
        filtered[field] = item[field]; 
      }

      return filtered;
    }).toList();
  }
}