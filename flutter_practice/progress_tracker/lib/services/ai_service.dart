import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_generative_ai/google_generative_ai.dart';

enum AIModel {
  chatGpt,
  gemini
}

enum AnalysisGoal {
  analyzeFiles,
  summarizeCommits
}

class AIService {
  static Future<String> analyzeRepo({
    required String apiKey,
    required AIModel model,
    required AnalysisGoal goal,
    List<String>? files,
    String? repoUrl,
  }) async {
    String fullPrompt;

    if (goal == AnalysisGoal.summarizeCommits) {
      fullPrompt = '''
You are a helpful assistant that can summarise github commits from the link $repoUrl. 
Summarise the commits done by me in a table format based on timeline based on clustering and grouping the commits based on the commit messages and the files changed by dates and time.
''';
    } else {
      const fileAnalysisInstructions = '''
Analyze the following list of files and directories from a GitHub repository.
Based solely on the file structure and names, provide:
1. Topics learned (the core concepts and technologies used in this project)
2. Skills acquired (what someone would learn by building or studying this project)
3. A short summary (2-3 sentences explaining what this repository likely is)

File list:
''';
      fullPrompt = '$fileAnalysisInstructions\n${(files ?? []).join('\n')}';
    }

    if (model == AIModel.chatGpt) {
      return _generateChatGPT(apiKey, fullPrompt);
    } else {
      return _generateGemini(apiKey, fullPrompt);
    }
  }

  static Future<String> _generateChatGPT(String apiKey, String prompt) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo-16k',
          'messages': [
            {
              'role': 'system', 
              'content': 'You are an expert software engineer and code analyzer.'
            },
            {
              'role': 'user', 
              'content': prompt
            }
          ]
        }),
      );

      if (response.statusCode != 200) {
        final error = jsonDecode(response.body);
        throw Exception(error['error']['message'] ?? 'Unknown ChatGPT API error');
      }

      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } catch (e) {
      throw Exception('ChatGPT Integration Error: $e');
    }
  }

  static Future<String> _generateGemini(String apiKey, String prompt) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-3-flash-preview',
        apiKey: apiKey,
        safetySettings: [
          SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none),
          SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.none),
          SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.none),
          SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.none),
        ],
      );

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      if (response.text == null) {
        if (response.candidates.isNotEmpty && response.candidates.first.finishReason == FinishReason.safety) {
          throw Exception('Gemini analysis was blocked by safety filters. Please try a different repository or check the content.');
        }
        throw Exception('No analysis result generated from Gemini.');
      }

      return response.text!;
    } catch (e) {
      throw Exception('Gemini Integration Error (gemini-3-flash-preview): $e');
    }
  }
}
