import 'package:flutter/material.dart';
import '../prototype/document.dart';

/// A simple widget to render a Document. 
class DocumentView extends StatelessWidget {
  final Document document;

  const DocumentView({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: document.render(context), // Pass context downwards to subclass render methods
      ),
    );
  }
}
