import 'package:comic_info/Models/ComicModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Comicservice {
  Future<List<Comicmodel>> fetchComic() async {
    String apiUrl="https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/all.json";
    var response=await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var data=jsonDecode(response.body);
      List<Comicmodel> comicList=[];
      data.forEach((comic){
        comicList.add(Comicmodel.fromJson(comic));
      });
      return comicList;
    } else {
      throw Exception('Failed to load comic');
    }
  }
}