import 'package:flutter/material.dart';
import '../models/section.dart';
import '../prototype/document.dart';

/// Concrete Prototype
class ReportDocument extends Document {
  bool isConfidential;

  ReportDocument({
    required super.title,
    required super.sections,
    this.isConfidential = false,
  });

  /// Deep copy implementation
  @override
  Document clone() {
    // Deep copy sections
    final clonedSections = sections.map((s) => s.clone()).toList();
    
    return ReportDocument(
      title: title, 
      sections: clonedSections,
      isConfidential: isConfidential, // Copied primitive value
    );
  }

  @override
  Widget buildHeaderDetails(BuildContext context) {
    if (!isConfidential) return const SizedBox.shrink();

    return Row(
      children: [
        const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 20),
        const SizedBox(width: 8),
        const Text(
          'CONFIDENTIAL REPORT', 
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        ),
      ],
    );
  }
}
