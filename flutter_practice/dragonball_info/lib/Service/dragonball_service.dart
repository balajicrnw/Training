import 'package:http/http.dart' as http;
import "dart:convert";
import "../Models/dragonball_model.dart";

class DragonballService {
  Future<List<DragonBallModel>> getCharacters() async {
     var url=Uri.parse("https://dragonball-api.com/api/characters?limit=100");
     var response=await http.get(url);
     if(response.statusCode==200){
      var data=jsonDecode(response.body);
      print("Data recieved 1");
      List items = data["items"];
      return items
          .map((i) => DragonBallModel.fromJson(i))
          .toList();
    }
    else{
      print("Error");
    }
    return [];
}
}