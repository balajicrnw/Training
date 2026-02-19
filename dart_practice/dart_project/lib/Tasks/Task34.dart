import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonModel{
  String PokemonName;
  String url;
  PokemonModel({required this.PokemonName,required this.url});

  factory PokemonModel.fromJson(Map<String,dynamic> json){
    return PokemonModel(
      PokemonName:json['name'],
      url:json['url']
    );
  }
}

Future<void> main()async{
  var url=Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=100");
  var response=await http.get(url);
  var data=jsonDecode(response.body);

  List<PokemonModel> pokemon=data["results"].map<PokemonModel>((i)=>PokemonModel.fromJson(i)).toList();
  
  for(PokemonModel poke in pokemon){
    print("Pokemon Name: ${poke.PokemonName}");
    print("URL: ${poke.url}");
    print("*"*20);
  }
}
