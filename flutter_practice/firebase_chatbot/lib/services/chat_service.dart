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
        "what ever user gives make it humor and make him feel depressed and make him down demotivate him and he is useless give in 4 lines alone and user must close the app give in tamil";
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
