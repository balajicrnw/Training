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
  /// Analyzes a GitHub repository using either ChatGPT or Gemini
  static Future<String> analyzeRepo({
    required String apiKey,
    required AIModel model,
    required AnalysisGoal goal,
    List<String>? files,
    String? repoUrl,
  }) async {
    String fullPrompt;

    // PROMPT for commit summary with dates
    if (goal == AnalysisGoal.summarizeCommits) {
      fullPrompt = '''
You are an expert software mentor and code reviewer.

Summarize the commits from the GitHub repository at $repoUrl. Include commit messages and exact commit dates (YYYY-MM-DD).

Return ONLY valid JSON with this structure:

{
  "topics": [
    {"name": "Technical topic", "date": "YYYY-MM-DD"}
  ],
  "skills": [
    {"name": "Skill acquired", "date": "YYYY-MM-DD"}
  ],
  "technologies": ["list of tools/frameworks like Firebase, Dart, Python"],
  "project_type": "type of project (e.g., Mobile App, Web App, ML Project)",
  "difficulty_level": "Beginner | Intermediate | Advanced",
  "summary": "2-3 sentence summary of what the student learned",
  "confidence_score": number between 0 and 1
}

Rules:
- Avoid duplicates
- Keep items concise (1-3 words per topic/skill)
- Ignore meaningless commits like "fix" or "update"
- Return ONLY JSON
''';
    } else {
      // PROMPT for file analysis with inferred dates
      fullPrompt = '''
You are an expert software mentor and code reviewer.

Analyze the following GitHub repository files and directories:

${(files ?? []).join('\n')}

Based solely on the file names and structure, generate ONLY valid JSON in this format:

{
  "topics": [
    {"name": "Technical topic", "date": "YYYY-MM-DD"}
  ],
  "skills": [
    {"name": "Skill acquired", "date": "YYYY-MM-DD"}
  ],
  "technologies": ["list of tools/frameworks like Firebase, Dart, Python"],
  "project_type": "type of project (e.g., Mobile App, Web App, ML Project)",
  "difficulty_level": "Beginner | Intermediate | Advanced",
  "summary": "2-3 sentence summary of what the student learned",
  "confidence_score": number between 0 and 1
}

Rules:
- Infer learning dates from file creation/commit dates if available
- Avoid duplicates
- Keep items concise (1-3 words per topic/skill)
- Return ONLY JSON
''';
    }

    // Call the selected AI model
    if (model == AIModel.chatGpt) {
      return _generateChatGPT(apiKey, fullPrompt);
    } else {
      return _generateGemini(apiKey, fullPrompt);
    }
  }

  /// ChatGPT integration
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
      final text = data['choices'][0]['message']['content'];
      return _extractJsonFromText(text);
    } catch (e) {
      throw Exception('ChatGPT Integration Error: $e');
    }
  }

  /// Gemini integration
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
        if (response.candidates.isNotEmpty &&
            response.candidates.first.finishReason == FinishReason.safety) {
          throw Exception(
              'Gemini analysis was blocked by safety filters. Please try a different repository or check the content.');
        }
        throw Exception('No analysis result generated from Gemini.');
      }

      return _extractJsonFromText(response.text!);
    } catch (e) {
      throw Exception('Gemini Integration Error (gemini-3-flash-preview): $e');
    }
  }

  /// Utility: Extract JSON from AI response text (in case AI adds extra text)
  static String _extractJsonFromText(String text) {
    try {
      final start = text.indexOf('{');
      final end = text.lastIndexOf('}');
      if (start == -1 || end == -1) {
        throw Exception('No JSON found in AI response');
      }
      final jsonString = text.substring(start, end + 1);
      // Validate JSON
      jsonDecode(jsonString);
      return jsonString;
    } catch (e) {
      throw Exception('Failed to parse JSON from AI response: $e\nText: $text');
    }
  }
}