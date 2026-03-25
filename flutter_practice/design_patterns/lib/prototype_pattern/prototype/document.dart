import 'package:flutter/material.dart';
import '../models/section.dart';

/// The Prototype (Abstract Class)
abstract class Document {
  String title;
  List<Section> sections;

  Document({
    required this.title,
    required this.sections,
  });

  /// The primary cloning method that concrete classes must implement.
  Document clone();

  /// Updates the title and a specific section's content.
  void updateContent({required String newTitle, required String sectionTitle, required String newContent}) {
    title = newTitle;
    try {
      final section = sections.firstWhere((s) => s.title == sectionTitle);
      section.content = newContent;
    } catch (e) {
      // Section not found
    }
  }

  /// Hook for subclasses to render their specific details (e.g., currency, confidentiality)
  Widget buildHeaderDetails(BuildContext context);

  /// Main render method for the document, using the Template Method pattern to insert subclass details.
  Widget render(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        buildHeaderDetails(context),
        const SizedBox(height: 12),
        const Divider(),
        const SizedBox(height: 8),
        ...sections.map(
          (s) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(s.content, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
