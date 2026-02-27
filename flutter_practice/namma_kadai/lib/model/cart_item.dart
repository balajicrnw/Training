import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'cart_item.g.dart';

abstract class CartItem implements Built<CartItem, CartItemBuilder> {
  int? get id;
  int get productId;
  String get title;
  double get price;
  String get imageUrl;
  int get quantity;

  CartItem._();
  factory CartItem([void Function(CartItemBuilder) updates]) = _$CartItem;

  static Serializer<CartItem> get serializer => _$cartItemSerializer;
}

extension CartItemExtension on CartItem {
  double get total => price * quantity;
}
