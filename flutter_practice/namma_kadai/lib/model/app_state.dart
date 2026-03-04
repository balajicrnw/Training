import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'product.dart';
import 'cart_item.dart';
import 'order.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  BuiltList<Product> get products;
  BuiltList<CartItem> get cartItems;
  BuiltList<Order> get orders;
  BuiltMap<String, dynamic>? get userData;
  String? get errorMessage;

  AppState._();
  factory AppState([void Function(AppStateBuilder) updates]) = _$AppState;

  factory AppState.initial() => AppState((b) => b
    ..products = ListBuilder<Product>([])
    ..cartItems = ListBuilder<CartItem>([])
    ..orders = ListBuilder<Order>([])
    ..errorMessage = null);

  static Serializer<AppState> get serializer => _$appStateSerializer;
}
