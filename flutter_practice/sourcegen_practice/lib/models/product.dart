import '../annotations/model.dart';

part 'product.g.dart';

@Model()
class Product {
  final String name;

  final double price;

  final bool inStock;

  Product({required this.name, required this.price, required this.inStock});
}
