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
  Iterable<Object?> serialize(Serializers serializers, AppState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'products',
      serializers.serialize(object.products,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Product)])),
      'cartItems',
      serializers.serialize(object.cartItems,
          specifiedType:
              const FullType(BuiltList, const [const FullType(CartItem)])),
      'orders',
      serializers.serialize(object.orders,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Order)])),
      'selectedCategory',
      serializers.serialize(object.selectedCategory,
          specifiedType: const FullType(String)),
      'searchQuery',
      serializers.serialize(object.searchQuery,
          specifiedType: const FullType(String)),
      'isLoading',
      serializers.serialize(object.isLoading,
          specifiedType: const FullType(bool)),
      'isAuthInitialChecked',
      serializers.serialize(object.isAuthInitialChecked,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.authUser;
    if (value != null) {
      result
        ..add('authUser')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(AuthUser)));
    }
    value = object.userData;
    if (value != null) {
      result
        ..add('userData')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(UserModel)));
    }
    value = object.errorMessage;
    if (value != null) {
      result
        ..add('errorMessage')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  AppState deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = AppStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'products':
          result.products.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Product)]))!
              as BuiltList<Object?>);
          break;
        case 'cartItems':
          result.cartItems.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CartItem)]))!
              as BuiltList<Object?>);
          break;
        case 'orders':
          result.orders.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Order)]))!
              as BuiltList<Object?>);
          break;
        case 'authUser':
          result.authUser.replace(serializers.deserialize(value,
              specifiedType: const FullType(AuthUser))! as AuthUser);
          break;
        case 'userData':
          result.userData.replace(serializers.deserialize(value,
              specifiedType: const FullType(UserModel))! as UserModel);
          break;
        case 'errorMessage':
          result.errorMessage = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'selectedCategory':
          result.selectedCategory = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'searchQuery':
          result.searchQuery = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'isLoading':
          result.isLoading = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'isAuthInitialChecked':
          result.isAuthInitialChecked = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
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
  @override
  final AuthUser? authUser;
  @override
  final UserModel? userData;
  @override
  final String? errorMessage;
  @override
  final String selectedCategory;
  @override
  final String searchQuery;
  @override
  final bool isLoading;
  @override
  final bool isAuthInitialChecked;

  factory _$AppState([void Function(AppStateBuilder)? updates]) =>
      (AppStateBuilder()..update(updates))._build();

  _$AppState._(
      {required this.products,
      required this.cartItems,
      required this.orders,
      this.authUser,
      this.userData,
      this.errorMessage,
      required this.selectedCategory,
      required this.searchQuery,
      required this.isLoading,
      required this.isAuthInitialChecked})
      : super._();
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
        orders == other.orders &&
        authUser == other.authUser &&
        userData == other.userData &&
        errorMessage == other.errorMessage &&
        selectedCategory == other.selectedCategory &&
        searchQuery == other.searchQuery &&
        isLoading == other.isLoading &&
        isAuthInitialChecked == other.isAuthInitialChecked;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, products.hashCode);
    _$hash = $jc(_$hash, cartItems.hashCode);
    _$hash = $jc(_$hash, orders.hashCode);
    _$hash = $jc(_$hash, authUser.hashCode);
    _$hash = $jc(_$hash, userData.hashCode);
    _$hash = $jc(_$hash, errorMessage.hashCode);
    _$hash = $jc(_$hash, selectedCategory.hashCode);
    _$hash = $jc(_$hash, searchQuery.hashCode);
    _$hash = $jc(_$hash, isLoading.hashCode);
    _$hash = $jc(_$hash, isAuthInitialChecked.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AppState')
          ..add('products', products)
          ..add('cartItems', cartItems)
          ..add('orders', orders)
          ..add('authUser', authUser)
          ..add('userData', userData)
          ..add('errorMessage', errorMessage)
          ..add('selectedCategory', selectedCategory)
          ..add('searchQuery', searchQuery)
          ..add('isLoading', isLoading)
          ..add('isAuthInitialChecked', isAuthInitialChecked))
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

  AuthUserBuilder? _authUser;
  AuthUserBuilder get authUser => _$this._authUser ??= AuthUserBuilder();
  set authUser(AuthUserBuilder? authUser) => _$this._authUser = authUser;

  UserModelBuilder? _userData;
  UserModelBuilder get userData => _$this._userData ??= UserModelBuilder();
  set userData(UserModelBuilder? userData) => _$this._userData = userData;

  String? _errorMessage;
  String? get errorMessage => _$this._errorMessage;
  set errorMessage(String? errorMessage) => _$this._errorMessage = errorMessage;

  String? _selectedCategory;
  String? get selectedCategory => _$this._selectedCategory;
  set selectedCategory(String? selectedCategory) =>
      _$this._selectedCategory = selectedCategory;

  String? _searchQuery;
  String? get searchQuery => _$this._searchQuery;
  set searchQuery(String? searchQuery) => _$this._searchQuery = searchQuery;

  bool? _isLoading;
  bool? get isLoading => _$this._isLoading;
  set isLoading(bool? isLoading) => _$this._isLoading = isLoading;

  bool? _isAuthInitialChecked;
  bool? get isAuthInitialChecked => _$this._isAuthInitialChecked;
  set isAuthInitialChecked(bool? isAuthInitialChecked) =>
      _$this._isAuthInitialChecked = isAuthInitialChecked;

  AppStateBuilder();

  AppStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _products = $v.products.toBuilder();
      _cartItems = $v.cartItems.toBuilder();
      _orders = $v.orders.toBuilder();
      _authUser = $v.authUser?.toBuilder();
      _userData = $v.userData?.toBuilder();
      _errorMessage = $v.errorMessage;
      _selectedCategory = $v.selectedCategory;
      _searchQuery = $v.searchQuery;
      _isLoading = $v.isLoading;
      _isAuthInitialChecked = $v.isAuthInitialChecked;
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
      _$result = _$v ??
          _$AppState._(
            products: products.build(),
            cartItems: cartItems.build(),
            orders: orders.build(),
            authUser: _authUser?.build(),
            userData: _userData?.build(),
            errorMessage: errorMessage,
            selectedCategory: BuiltValueNullFieldError.checkNotNull(
                selectedCategory, r'AppState', 'selectedCategory'),
            searchQuery: BuiltValueNullFieldError.checkNotNull(
                searchQuery, r'AppState', 'searchQuery'),
            isLoading: BuiltValueNullFieldError.checkNotNull(
                isLoading, r'AppState', 'isLoading'),
            isAuthInitialChecked: BuiltValueNullFieldError.checkNotNull(
                isAuthInitialChecked, r'AppState', 'isAuthInitialChecked'),
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
        _$failedField = 'authUser';
        _authUser?.build();
        _$failedField = 'userData';
        _userData?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
