import 'package:comic_info/Models/ComicModel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:comic_info/Router/router_names.dart';

class DetailPage extends StatefulWidget {
  final Comicmodel hero;
  final String charName;
  const DetailPage({super.key, required this.hero,required this.charName});

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
            Hero(
              tag: widget.hero.name,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    widget.hero.image,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
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
                  context.goNamed(RouterNames.characters);
                },
                child: const Text("Go Back"))
          ],
        ),
      ),
    );
  }
}