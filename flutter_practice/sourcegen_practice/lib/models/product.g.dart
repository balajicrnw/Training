// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

extension ProductJson on Product {
  Map<String, dynamic> toJson() {
    return {'name': name, 'price': price, 'inStock': inStock};
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: json['price'],
      inStock: json['inStock'],
    );
  }
}
