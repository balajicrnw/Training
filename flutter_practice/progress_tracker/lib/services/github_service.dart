import 'dart:convert';
import 'package:http/http.dart' as http;

class GitHubService {
  static Future<List<String>> fetchRepoFiles(String repoUrl) async {
    final uri = Uri.tryParse(repoUrl);
    if (uri == null || uri.host != 'github.com') {
      throw Exception('Invalid GitHub URL. Must be in the format https://github.com/owner/repo');
    }
    
    final pathSegments = uri.pathSegments;
    if (pathSegments.length < 2) {
      throw Exception('URL must contain both owner and repository name.');
    }
    
    final owner = pathSegments[0];
    final repo = pathSegments[1];
    
    final repoApiUrl = 'https://api.github.com/repos/$owner/$repo';
    final repoRes = await http.get(Uri.parse(repoApiUrl));
    
    if (repoRes.statusCode == 404) {
      throw Exception('Repository not found. Please check the URL.');
    } else if (repoRes.statusCode != 200) {
      throw Exception('Failed to fetch repo info: ${repoRes.statusCode} ${repoRes.body}');
    }
    
    final repoData = jsonDecode(repoRes.body);
    final defaultBranch = repoData['default_branch'] ?? 'main';
    
    final treeApiUrl = 'https://api.github.com/repos/$owner/$repo/git/trees/$defaultBranch?recursive=1';
    final treeRes = await http.get(Uri.parse(treeApiUrl));
    
    if (treeRes.statusCode != 200) {
      throw Exception('Failed to fetch repository tree: ${treeRes.statusCode}');
    }
    
    final treeData = jsonDecode(treeRes.body);
    final tree = treeData['tree'] as List;
    
    final filePaths = tree
        .where((item) => item['type'] == 'blob')
        .map<String>((item) => item['path'] as String)
        .toList();
        

    const maxFiles = 300;
    if (filePaths.length > maxFiles) {
      return filePaths.take(maxFiles).toList()
        ..add('... and ${filePaths.length - maxFiles} more files not listed due to constraints.');
    }
    
    return filePaths;
  }
}
