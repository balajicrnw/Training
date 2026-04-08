import '../model/product.dart';
import '../collection/product_collection.dart';
import 'iterator.dart';

class ProductIterator implements Iterator<Product> {
  final ProductCollection collection;
  int _index = 0;

  ProductIterator(this.collection);

  @override
  bool hasNext() {
    return _index < collection.products.length;
  }

  @override
  Product? next() {
    if (!hasNext()) return null;
    return collection.products[_index++];
  }

  @override
  void reset() {
    _index = 0;
  }
}