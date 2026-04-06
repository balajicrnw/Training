// file_page.dart
import 'package:flutter/material.dart';
import 'folder.dart';
import 'file_item.dart';

class FilePage extends StatelessWidget {
  const FilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // ROOT FOLDER
    final root = Folder("Media");

    final music = Folder("Music");
    music.add(FileItem("song1.mp3", 5));
    music.add(FileItem("song2.mp3", 8));

    final photos = Folder("Photos");
    photos.add(FileItem("img1.jpg", 2));
    photos.add(FileItem("img2.jpg", 3));

    root.add(music);
    root.add(photos);
    root.add(FileItem("readme.txt", 1));

    return Scaffold(
      appBar: AppBar(title: const Text("Composite Pattern")),
      body: ListView(
        children: [
          root.buildWidget(),
        ],
      ),
    );
  }
}