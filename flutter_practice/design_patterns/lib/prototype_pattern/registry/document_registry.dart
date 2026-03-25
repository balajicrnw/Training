import '../prototype/document.dart';

/// The Prototype Registry
class DocumentRegistry {
  final Map<String, Document> _prototypes = {};

  void register(String key, Document prototype) {
    _prototypes[key] = prototype;
  }

  /// Returns a CLONE of the registered document, ensuring the original template is unmodified.
  Document get(String key) {
    final prototype = _prototypes[key];
    if (prototype == null) {
      throw Exception('Prototype with key "$key" not found in Registry.');
    }
    return prototype.clone();
  }
}
