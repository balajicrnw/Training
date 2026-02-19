import 'package:http/http.dart' as http;
import 'dart:convert';

class GameModel{
    String title;
    String shortDescription;
    String Platform;
    String Developer;
    String genre;

    GameModel({required this.title,required this.shortDescription,required this.Platform,required this.Developer,required this.genre});

    factory GameModel.fromJson(Map<String, dynamic> json){
        return (GameModel(
            title: json['title'],
            shortDescription: json['short_description'],
            Platform: json['platform'], 
            Developer: json['developer'],
            genre: json['genre'],
        ));
    }

    void display(){
        print("Title: $title");
        print("Short Description: $shortDescription");
        print("Platform: $Platform");
        print("Developer: $Developer");
        print("Genre: $genre");
        print("*"*20);
    }
}

Future<void> main() async{
    List<GameModel> gamesList=[];
    var url=Uri.parse("https://www.freetogame.com/api/games");
    var response= await http.get(url);
    
    var games=jsonDecode(response.body);
    games.forEach((game){
        gamesList.add(GameModel.fromJson(game));
    });
    
    gamesList.forEach((game)=>game.display());





}


    

    
