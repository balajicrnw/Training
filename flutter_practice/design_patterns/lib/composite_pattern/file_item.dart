// file_item.dart
import 'package:flutter/material.dart';
import 'file_component.dart';

class FileItem implements FileComponent {
  final String name;
  final int size;

  FileItem(this.name, this.size);

  @override
  int getSize() => size;

  @override
  Widget buildWidget() {
    return ListTile(
      leading: const Icon(Icons.insert_drive_file),
      title: Text(name),
      trailing: Text("${size} KB"),
    );
  }
}