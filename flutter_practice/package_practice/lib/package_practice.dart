import 'api_service.dart';
class ApiFetch {

  static Future<List<Map<String, dynamic>>> fetchList({
    required String url,
    required List<String> fields,
  }) async {
    final response = await ApiService.get(url);

    if (response is List) {
      return FieldExtractor.extract(response, fields);
    } else {
      throw Exception("Expected List response");
    }
  }

  static Future<List<Map<String, dynamic>>> fetchMap({
    required String url,
    required List<String> fields,
    String listKey = "data",
  }) async {
    final response = await ApiService.get(url);

    if (response is Map && response[listKey] is List) {
      return FieldExtractor.extract(response[listKey], fields);
    } else {
      throw Exception("Expected Map with List at key: $listKey");
    }
  }

  static Future<Map<String, dynamic>> fetchSingle({
    required String url,
    required List<String> fields,
  }) async {
    final response = await ApiService.get(url);

    if (response is Map<String, dynamic>) {
      final result = <String, dynamic>{};

      for (var field in fields) {
        result[field] = response[field]; 
      }

      return result;
    } else {
      throw Exception("Expected Map response");
    }
  }
}