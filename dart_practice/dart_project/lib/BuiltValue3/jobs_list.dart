import 'dart:convert';

import 'package:dart_project/BuiltValue3/jobSerializer.dart';
import 'package:dart_project/BuiltValue3/jobs.dart';
import 'package:http/http.dart' as http;
void printDetails(List<dynamic> jobs){
  for(var i in jobs){
    print("Id: ${i.id}\nJob Title: ${i.jobTitle}\nCompany Name: ${i.companyName}\n${"-"*10}");
  }
}
Future<void> main() async{
  try{
    var url=Uri.parse("https://jobicy.com/api/v2/remote-jobs");
    var response=await http.get(url);
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      print(data.runtimeType);
      var original_data=data["jobs"];
      // print(original_data.runtimeType);
      // print(original_data);
      List<dynamic> jobs=original_data.map((i)=>serializers.deserializeWith(Jobs.serializer,i)).toList();
      // print(jobs);
      printDetails(jobs);
    }

  }
  catch(ex){
    print("Error: $ex");
    
  }
}