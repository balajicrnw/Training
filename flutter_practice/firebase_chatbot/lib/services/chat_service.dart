import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:http/http.dart' as http;
import '../../env.dart';

class ChatService {
  static const String modelName = 'gemini-3.1-flash-lite';

  final String apiKey = geminiApiKey;
  final uri = Uri.parse(
    'https://generativelanguage.googleapis.com/v1beta/models/$modelName:generateContent?key=$geminiApiKey',
  );

  Future<String> sendMessage(String text) async {
    final prompt =
        "get only 2 line answers for any of the chat user gives only make use to ask only for books topic if deviated then tell the thing he asks is out of topic please ask based on books only";
    final Map<String, dynamic> requestBody = {
      "contents": [
        {
          "parts": [
            {"text": prompt + text},
          ],
        },
      ],
    };

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    final data = jsonDecode(response.body);

    return data['candidates'][0]['content']['parts'][0]['text'] as String;
  }
}
