import 'package:flutter/material.dart';
import '../prototype/document.dart';
import '../concrete_prototypes/invoice_document.dart';
import '../concrete_prototypes/report_document.dart';
import '../registry/document_registry.dart';
import '../widgets/document_view.dart';
import '../models/section.dart';

class DocumentPage extends StatefulWidget {
  const DocumentPage({super.key});

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  late final DocumentRegistry _registry;
  Document? _currentDocument;

  @override
  void initState() {
    super.initState();
    _registry = DocumentRegistry();
    _preloadTemplates();
  }

  void _preloadTemplates() {
    // Base Invoice
    _registry.register('invoice', InvoiceDocument(
      title: 'INVOICE TEMPLATE',
      currency: 'USD',
      sections: [
        Section(title: 'Header', content: 'Company: Corp Inc.\nDate: [Date]'),
        Section(title: 'Body', content: 'Items:\n- [Item 1]\n- [Item 2]'),
        Section(title: 'Footer', content: 'Total: [0.00]'),
      ],
    ));

    // Base Report
    _registry.register('report', ReportDocument(
      title: 'REPORT TEMPLATE',
      isConfidential: true,
      sections: [
        Section(title: 'Executive Summary', content: '[TL;DR]'),
        Section(title: 'Findings', content: '[Details]'),
        Section(title: 'Conclusion', content: '[Summary]'),
      ],
    ));
  }

  void _createInvoice(String currency) {
    final doc = _registry.get('invoice');
    
    // Demonstrate polymorphism: safely update subclass properties
    if (doc is InvoiceDocument) {
      doc.currency = currency;
    }

    doc.updateContent(
      newTitle: 'Invoice #INT-2023X', 
      sectionTitle: 'Header', 
      newContent: 'Company: Corp Inc.\nDate: Nov 12, 2023',
    );
    doc.updateContent(
      newTitle: 'Invoice #INT-2023X', 
      sectionTitle: 'Body', 
      newContent: 'Items:\n- Flutter Dev (10hrs)\n- UI Design (5hrs)',
    );
    doc.updateContent(
      newTitle: 'Invoice #INT-2023X', 
      sectionTitle: 'Footer', 
      newContent: 'Total: 1,500.00',
    );

    setState(() => _currentDocument = doc);
  }

  void _createReport(bool makeConfidential) {
    final doc = _registry.get('report');
    
    // Demonstrate polymorphism: safely update subclass properties
    if (doc is ReportDocument) {
      doc.isConfidential = makeConfidential;
    }

    doc.updateContent(
      newTitle: 'Q4 Financial Report',
      sectionTitle: 'Executive Summary',
      newContent: 'Q4 showed exceptional growth.',
    );
    doc.updateContent(
      newTitle: 'Q4 Financial Report',
      sectionTitle: 'Findings',
      newContent: 'Revenue up 25%. Costs down 10%.',
    );
    doc.updateContent(
      newTitle: 'Q4 Financial Report',
      sectionTitle: 'Conclusion',
      newContent: 'Ready for an aggressive Q1.',
    );

    setState(() => _currentDocument = doc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prototype Registry'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'The UI clones a pre-configured template from the Registry and injects custom data into it, showcasing all prototype functionalities.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _createInvoice('EUR'),
                  icon: const Icon(Icons.euro),
                  label: const Text('EUR Invoice'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _createInvoice('GBP'),
                  icon: const Icon(Icons.currency_pound),
                  label: const Text('GBP Invoice'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _createReport(true),
                  icon: const Icon(Icons.security),
                  label: const Text('Secret Report'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _createReport(false),
                  icon: const Icon(Icons.public),
                  label: const Text('Public Report'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: _currentDocument == null
                  ? const Center(child: Text('No Document Generated'))
                  : Center(
                      child: SingleChildScrollView(
                        child: DocumentView(document: _currentDocument!),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
