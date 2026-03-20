import 'package:flutter/material.dart';
import '../service/character_service.dart';
import '../model/character_model.dart';

class ListPage extends StatefulWidget {
  @override
  State<ListPage> createState() => ListPageState();
}

class ListPageState extends State<ListPage> {

  late Future<List<CharacterModel>> characters;

  @override
  void initState() {
    super.initState();
    characters = CharacterService().fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Characters"),
      ),
      body: FutureBuilder<List<CharacterModel>>(
        future: characters,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final data = snapshot.data!;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final character = data[index];

              return ListTile(
                title: Text(character.name),
                subtitle: Text("${character.role} | ${character.gender}"),
              );
            },
          );
        },
      ),
    );
  }
}