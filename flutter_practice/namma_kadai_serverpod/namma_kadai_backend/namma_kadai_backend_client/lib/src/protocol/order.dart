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
import 'cart_item.dart' as _i2;
import 'package:namma_kadai_backend_client/src/protocol/protocol.dart' as _i3;

abstract class OrderDb implements _i1.SerializableModel {
  OrderDb._({
    this.id,
    this.uid,
    required this.items,
    required this.totalAmount,
    required this.dateTime,
  });

  factory OrderDb({
    int? id,
    String? uid,
    required List<_i2.CartItemDb> items,
    required double totalAmount,
    required DateTime dateTime,
  }) = _OrderDbImpl;

  factory OrderDb.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderDb(
      id: jsonSerialization['id'] as int?,
      uid: jsonSerialization['uid'] as String?,
      items: _i3.Protocol().deserialize<List<_i2.CartItemDb>>(
        jsonSerialization['items'],
      ),
      totalAmount: (jsonSerialization['totalAmount'] as num).toDouble(),
      dateTime: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['dateTime'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String? uid;

  List<_i2.CartItemDb> items;

  double totalAmount;

  DateTime dateTime;

  /// Returns a shallow copy of this [OrderDb]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrderDb copyWith({
    int? id,
    String? uid,
    List<_i2.CartItemDb>? items,
    double? totalAmount,
    DateTime? dateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderDb',
      if (id != null) 'id': id,
      if (uid != null) 'uid': uid,
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'totalAmount': totalAmount,
      'dateTime': dateTime.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderDbImpl extends OrderDb {
  _OrderDbImpl({
    int? id,
    String? uid,
    required List<_i2.CartItemDb> items,
    required double totalAmount,
    required DateTime dateTime,
  }) : super._(
         id: id,
         uid: uid,
         items: items,
         totalAmount: totalAmount,
         dateTime: dateTime,
       );

  /// Returns a shallow copy of this [OrderDb]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrderDb copyWith({
    Object? id = _Undefined,
    Object? uid = _Undefined,
    List<_i2.CartItemDb>? items,
    double? totalAmount,
    DateTime? dateTime,
  }) {
    return OrderDb(
      id: id is int? ? id : this.id,
      uid: uid is String? ? uid : this.uid,
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      totalAmount: totalAmount ?? this.totalAmount,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
