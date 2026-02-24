import 'dart:convert';
import "../BuiltValue1/books.dart";
import 'package:dart_project/BuiltValue1/serializer1.dart';
import 'package:http/http.dart' as http;

void printDetails(List<dynamic> books){
  books.forEach((i)=>
  print("Id: ${i.id}\nTitle: ${i.Title}\nPublisher: ${i.Publisher}\nYear: ${i.Year}\nPages: ${i.Pages}\n${"-"*10}"));

}
Future<void> main() async{
  try{
    var url=Uri.parse("https://stephen-king-api.onrender.com/api/books");
    var response=await http.get(url);
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      
      print(data.runtimeType);
      List bookList=data["data"].map((e)=>serializers.deserializeWith(Books.serializer, e)).toList(); 
      print(bookList.runtimeType);
      printDetails(bookList);

    }
  }
  catch(ex){
    print("Error: $ex");
  }
  
}