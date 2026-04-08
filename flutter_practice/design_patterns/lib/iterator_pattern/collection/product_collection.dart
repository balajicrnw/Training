import '../model/product.dart';

class ProductCollection {
  final List<Product> _products;

  ProductCollection(this._products);

  List<Product> get products => _products;
}