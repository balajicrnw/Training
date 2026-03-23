import 'package:flutter/material.dart';
import '../services/github_service.dart';
import '../services/ai_service.dart';

class AnalyzerHomeScreen extends StatefulWidget {
  const AnalyzerHomeScreen({super.key});

  @override
  State<AnalyzerHomeScreen> createState() => _AnalyzerHomeScreenState();
}

class _AnalyzerHomeScreenState extends State<AnalyzerHomeScreen> {
  final _repoController = TextEditingController();
  final _apiKeyController = TextEditingController();
  AIModel _selectedModel = AIModel.chatGpt;
  AnalysisGoal _selectedGoal = AnalysisGoal.analyzeFiles;

  bool _isLoading = false;
  String _resultText = '';
  String _errorText = '';

  Future<void> _analyzeRepo() async {
    final repoUrl = _repoController.text.trim();
    // Clean API key of known problematic control characters while allowing a wider range of valid key symbols
    final apiKey = _apiKeyController.text.trim().replaceAll(RegExp(r'[\s\x00-\x1F\x7F-\x9F]'), '');

    if (repoUrl.isEmpty || apiKey.isEmpty) {
      setState(() {
        _errorText = 'Please provide both GitHub URL and API Key.';
        _resultText = '';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorText = '';
      _resultText = '';
    });

    try {
      List<String>? files;
      if (_selectedGoal == AnalysisGoal.analyzeFiles) {
        // Fetch file names from GitHub only if we need to analyze files
        files = await GitHubService.fetchRepoFiles(repoUrl);
      }
      
      // Request analysis from the selected AI
      final analysis = await AIService.analyzeRepo(
        apiKey: apiKey,
        model: _selectedModel,
        goal: _selectedGoal,
        files: files,
        repoUrl: repoUrl,
      );

      setState(() {
        _resultText = analysis;
      });
    } catch (e) {
      setState(() {
        _errorText = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _repoController.dispose();
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repo AI Analyzer'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User Inputs section
            TextField(
              controller: _repoController,
              decoration: const InputDecoration(
                labelText: 'GitHub Repo URL (e.g., https://github.com/flutter/flutter)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.link),
              ),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 16),
            
            // Secure Input for API Key
            TextField(
              controller: _apiKeyController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'AI API Key',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.security),
              ),
            ),
            const SizedBox(height: 16),
            
            // Analysis Goal Selection
            Row(
              children: [
                const Text('Analysis Goal: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<AnalysisGoal>(
                    value: _selectedGoal,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: AnalysisGoal.analyzeFiles,
                        child: Text('Analyze Files'),
                      ),
                      DropdownMenuItem(
                        value: AnalysisGoal.summarizeCommits,
                        child: Text('Summarize Commits'),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedGoal = val;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Model Selection Dropdown
            Row(
              children: [
                const Text('AI Model: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<AIModel>(
                    value: _selectedModel,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: AIModel.chatGpt,
                        child: Text('ChatGPT'),
                      ),
                      DropdownMenuItem(
                        value: AIModel.gemini,
                        child: Text('Gemini'),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedModel = val;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Action Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _analyzeRepo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )
                ),
                child: const Text('Analyze Repo', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 24),
            
            // Loading Indicator
            if (_isLoading) ...[
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              const Text('Fetching files and analyzing context...'),
              const SizedBox(height: 16),
            ],
            
            // Error Display area
            if (_errorText.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Text(
                  _errorText,
                  style: TextStyle(color: Colors.red.shade900),
                ),
              ),
              const SizedBox(height: 16),
            ],
            
            // Scrollable Results Display
            Expanded(
              child: _resultText.isEmpty && !_isLoading && _errorText.isEmpty
                  ? const Center(
                      child: Text(
                        'Ready: Enter a URL and your API Key to analyze.',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          _resultText,
                          style: const TextStyle(fontSize: 15, height: 1.5),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
