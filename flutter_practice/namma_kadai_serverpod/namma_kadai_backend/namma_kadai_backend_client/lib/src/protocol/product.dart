/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class ProductDb implements _i1.SerializableModel {
  ProductDb._({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.category,
  });

  factory ProductDb({
    int? id,
    required String title,
    required String description,
    required double price,
    required String imageUrl,
    String? category,
  }) = _ProductDbImpl;

  factory ProductDb.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProductDb(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      price: (jsonSerialization['price'] as num).toDouble(),
      imageUrl: jsonSerialization['imageUrl'] as String,
      category: jsonSerialization['category'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String title;

  String description;

  double price;

  String imageUrl;

  String? category;

  /// Returns a shallow copy of this [ProductDb]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProductDb copyWith({
    int? id,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
    String? category,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProductDb',
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      if (category != null) 'category': category,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProductDbImpl extends ProductDb {
  _ProductDbImpl({
    int? id,
    required String title,
    required String description,
    required double price,
    required String imageUrl,
    String? category,
  }) : super._(
         id: id,
         title: title,
         description: description,
         price: price,
         imageUrl: imageUrl,
         category: category,
       );

  /// Returns a shallow copy of this [ProductDb]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProductDb copyWith({
    Object? id = _Undefined,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
    Object? category = _Undefined,
  }) {
    return ProductDb(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category is String? ? category : this.category,
    );
  }
}
