import 'package:flutter/material.dart';
import '../models/section.dart';
import '../prototype/document.dart';

/// Concrete Prototype
class InvoiceDocument extends Document {
  String currency;

  InvoiceDocument({
    required super.title,
    required super.sections,
    this.currency = 'USD',
  });

  /// Deep copy implementation
  @override
  Document clone() {
    // Deep copy sections
    final clonedSections = sections.map((s) => s.clone()).toList();
    
    return InvoiceDocument(
      title: title, 
      sections: clonedSections,
      currency: currency, // Copied primitive value
    );
  }

  @override
  Widget buildHeaderDetails(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.monetization_on, color: Colors.green, size: 20),
        const SizedBox(width: 8),
        Text(
          'Currency: $currency', 
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ],
    );
  }
}
