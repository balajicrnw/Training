import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'cart_item.dart';

part 'order.g.dart';

abstract class Order implements Built<Order, OrderBuilder> {
  String? get id;
  String? get uid;
  BuiltList<CartItem> get items;
  double get totalAmount;
  DateTime get dateTime;

  Order._();
  factory Order([void Function(OrderBuilder) updates]) = _$Order;

  static Serializer<Order> get serializer => _$orderSerializer;
}
