// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AppState> _$appStateSerializer = _$AppStateSerializer();

class _$AppStateSerializer implements StructuredSerializer<AppState> {
  @override
  final Iterable<Type> types = const [AppState, _$AppState];
  @override
  final String wireName = 'AppState';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    AppState object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'products',
      serializers.serialize(
        object.products,
        specifiedType: const FullType(BuiltList, const [
          const FullType(Product),
        ]),
      ),
      'cartItems',
      serializers.serialize(
        object.cartItems,
        specifiedType: const FullType(BuiltList, const [
          const FullType(CartItem),
        ]),
      ),
      'orders',
      serializers.serialize(
        object.orders,
        specifiedType: const FullType(BuiltList, const [const FullType(Order)]),
      ),
    ];

    return result;
  }

  @override
  AppState deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AppStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'products':
          result.products.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(Product),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'cartItems':
          result.cartItems.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(CartItem),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'orders':
          result.orders.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(Order),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$AppState extends AppState {
  @override
  final BuiltList<Product> products;
  @override
  final BuiltList<CartItem> cartItems;
  @override
  final BuiltList<Order> orders;

  factory _$AppState([void Function(AppStateBuilder)? updates]) =>
      (AppStateBuilder()..update(updates))._build();

  _$AppState._({
    required this.products,
    required this.cartItems,
    required this.orders,
  }) : super._();
  @override
  AppState rebuild(void Function(AppStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => AppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppState &&
        products == other.products &&
        cartItems == other.cartItems &&
        orders == other.orders;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, products.hashCode);
    _$hash = $jc(_$hash, cartItems.hashCode);
    _$hash = $jc(_$hash, orders.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AppState')
          ..add('products', products)
          ..add('cartItems', cartItems)
          ..add('orders', orders))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState? _$v;

  ListBuilder<Product>? _products;
  ListBuilder<Product> get products =>
      _$this._products ??= ListBuilder<Product>();
  set products(ListBuilder<Product>? products) => _$this._products = products;

  ListBuilder<CartItem>? _cartItems;
  ListBuilder<CartItem> get cartItems =>
      _$this._cartItems ??= ListBuilder<CartItem>();
  set cartItems(ListBuilder<CartItem>? cartItems) =>
      _$this._cartItems = cartItems;

  ListBuilder<Order>? _orders;
  ListBuilder<Order> get orders => _$this._orders ??= ListBuilder<Order>();
  set orders(ListBuilder<Order>? orders) => _$this._orders = orders;

  AppStateBuilder();

  AppStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _products = $v.products.toBuilder();
      _cartItems = $v.cartItems.toBuilder();
      _orders = $v.orders.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    _$v = other as _$AppState;
  }

  @override
  void update(void Function(AppStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AppState build() => _build();

  _$AppState _build() {
    _$AppState _$result;
    try {
      _$result =
          _$v ??
          _$AppState._(
            products: products.build(),
            cartItems: cartItems.build(),
            orders: orders.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'products';
        products.build();
        _$failedField = 'cartItems';
        cartItems.build();
        _$failedField = 'orders';
        orders.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AppState',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
