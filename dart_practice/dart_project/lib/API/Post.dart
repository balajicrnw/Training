import 'package:http/http.dart' as http;
import 'dart:convert';
Future<void> main() async {
  
  await postData(); 
  await getData();
}
Future<void> postData() async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    headers: {
      'Content-Type': 'application/json',   
    },
    body: jsonEncode({
      'userId': 101,
      'title': 'Batman',
      'body': 'I am Vengence I am dark Knight',
      
    }),
  );
  print(response.body);  
}

Future<void> getData() async {
  try{
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
  );
  print(response.body);

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    print(data);
  } else {
    print('Failed to load data Error: ${response.statusCode}');
  }
} catch(ex){
  print(ex);

}
}
