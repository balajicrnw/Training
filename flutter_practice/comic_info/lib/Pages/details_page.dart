import 'package:comic_info/Models/ComicModel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:comic_info/Router/router_names.dart';

class DetailPage extends StatefulWidget {
  final Comicmodel hero;
  const DetailPage({super.key, required this.hero});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hero.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(widget.hero.image),
            const SizedBox(height: 20),
            Text(
              'Name: ${widget.hero.name}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Publisher: ${widget.hero.publisher}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              'Gender: ${widget.hero.gender}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              'Occupation: ${widget.hero.occupation}',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
                onPressed: () {
                  context.pushNamed(RouterNames.characters);
                },
                child: const Text("Go Back"))
          ],
        ),
      ),
    );
  }
}