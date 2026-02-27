import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product.g.dart';

abstract class Product implements Built<Product, ProductBuilder> {
  int? get id;
  String get title;
  String get description;
  double get price;
  String get imageUrl;

  Product._();
  factory Product([void Function(ProductBuilder) updates]) = _$Product;

  static Serializer<Product> get serializer => _$productSerializer;
}
