import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async{
  var url=Uri.parse('https://valorant-api.com/v1/agents');
  print(url);
  // Response(String body, int statusCode, {BaseRequest? request, Map<String, String> headers = const {}, bool isRedirect = false, bool persistentConnection = true, String? reasonPhrase})
  var response=await http.get(url);
  print(response);
  print(response.statusCode);
  var data=jsonDecode(response.body);
  // print(data);  //data got

  print(data['data'][0]['displayName']);

  var data2=data['data'];
  print(data2[0].keys);
  // print(data2);

  data2.forEach((item) {
  print(item["displayName"]);
});
}