import 'package:package_practice/package_practice.dart';

Future<void> main() async {
  final values = await ApiFetch.fetchSingle(
    url: "https://dogapi.dog/api/v2/facts?limit=1",
    fields: ["data"],
  );

  print(values["data"][0]["attributes"]["body"]);

  final pokemons = await ApiFetch.fetchMap(
  url: "https://pokeapi.co/api/v2/pokemon",
  fields: ["name", "url"],
  listKey: "results", 
  );

  for (var p in pokemons) {
     print(p);
  }  

  final dragon=await ApiFetch.fetchMap(url: "https://dragonball-api.com/api/characters", fields: ["name","race","gender"],listKey: "items");
  for(var d in dragon){
    print(d);
  }

  final users = await ApiFetch.fetchMap(
  url: "https://dummyjson.com/users",
  fields: ["firstName", "email"],
  listKey: "users",
  );

  for (var u in users){
    print(u);
  }
  final countries = await ApiFetch.fetchList(
  url: "https://restcountries.com/v3.1/all?fields=name,capital,currencies,language",
  fields: ["name", "capital","currencies","language"], 
  );

  for(var country in countries){
    print(country);
  }
  

}