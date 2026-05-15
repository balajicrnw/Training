import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'product.dart';
import 'cart_item.dart';
import 'order.dart';
import 'user_model.dart';
import 'auth_user.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  BuiltList<Product> get products;
  BuiltList<CartItem> get cartItems;
  BuiltList<Order> get orders;
  AuthUser? get authUser;
  UserModel? get userData;
  String? get errorMessage;
  String get selectedCategory;
  String get searchQuery;
  bool get isLoading;
  bool get isAuthInitialChecked;

  AppState._();
  factory AppState([void Function(AppStateBuilder) updates]) = _$AppState;

  factory AppState.initial() => AppState(
        (b) => b
          ..products = ListBuilder<Product>([])
          ..cartItems = ListBuilder<CartItem>([])
          ..orders = ListBuilder<Order>([])
          ..errorMessage = null
          ..selectedCategory = 'All'
          ..searchQuery = ''
          ..isLoading = false
          ..isAuthInitialChecked = false,
      );

  static Serializer<AppState> get serializer => _$appStateSerializer;
}
