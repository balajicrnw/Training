import 'package:flutter/material.dart';
import '../core/environment.dart';
import '../creator/api_service.dart';

class ApiExamplePage extends StatefulWidget {
  const ApiExamplePage({super.key});

  @override
  State<ApiExamplePage> createState() => _ApiExamplePageState();
}

class _ApiExamplePageState extends State<ApiExamplePage> {
  Environment _selectedEnv = Environment.dev;
  bool _isLoading = false;
  String _result = '';
  String _currentUrl = '';

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _result = '';
      _currentUrl = '';
    });

    // We use the Factory Method here. The UI never calls DevApiService() or ProdApiService() directly.
    // It solely relies on the ApiService abstraction.
    final ApiService service = ApiService.createService(_selectedEnv);

    final url = service.getBaseUrl();
    final data = await service.fetchData();

    setState(() {
      _currentUrl = url;
      _result = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Factory Method Example'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select Environment:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SegmentedButton<Environment>(
              segments: const [
                ButtonSegment(
                  value: Environment.dev,
                  label: Text('Development'),
                ),
                ButtonSegment(
                  value: Environment.prod,
                  label: Text('Production'),
                ),
              ],
              selected: {_selectedEnv},
              onSelectionChanged: (Set<Environment> newSelection) {
                setState(() {
                  _selectedEnv = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _fetchData,
              icon: const Icon(Icons.cloud_download),
              label: const Text('Fetch Data'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 32),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_currentUrl.isNotEmpty) ...[
              const Text(
                'Connected Base URL:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                _currentUrl,
                style: const TextStyle(color: Colors.blueAccent, fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'API Response:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _result,
                  style: const TextStyle(fontFamily: 'monospace'),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
