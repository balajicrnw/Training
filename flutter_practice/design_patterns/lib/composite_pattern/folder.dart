// folder.dart
import 'package:flutter/material.dart';
import 'file_component.dart';

class Folder implements FileComponent {
  final String name;
  final List<FileComponent> children = [];

  Folder(this.name);

  void add(FileComponent item) {
    children.add(item);
  }

  @override
  int getSize() {
    int total = 0;
    for (var item in children) {
      total += item.getSize();
    }
    return total;
  }

  @override
  Widget buildWidget() {
    return ExpansionTile(
      leading: const Icon(Icons.folder),
      title: Text("$name (${getSize()} KB)"),
      children: children.map((e) => e.buildWidget()).toList(),
    );
  }
}