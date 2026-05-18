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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class CartItemDb
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CartItemDb._({
    this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.userId,
  });

  factory CartItemDb({
    int? id,
    required String productId,
    required String title,
    required double price,
    required String imageUrl,
    required int quantity,
    required String userId,
  }) = _CartItemDbImpl;

  factory CartItemDb.fromJson(Map<String, dynamic> jsonSerialization) {
    return CartItemDb(
      id: jsonSerialization['id'] as int?,
      productId: jsonSerialization['productId'] as String,
      title: jsonSerialization['title'] as String,
      price: (jsonSerialization['price'] as num).toDouble(),
      imageUrl: jsonSerialization['imageUrl'] as String,
      quantity: jsonSerialization['quantity'] as int,
      userId: jsonSerialization['userId'] as String,
    );
  }

  static final t = CartItemDbTable();

  static const db = CartItemDbRepository._();

  @override
  int? id;

  String productId;

  String title;

  double price;

  String imageUrl;

  int quantity;

  String userId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CartItemDb]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CartItemDb copyWith({
    int? id,
    String? productId,
    String? title,
    double? price,
    String? imageUrl,
    int? quantity,
    String? userId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CartItemDb',
      if (id != null) 'id': id,
      'productId': productId,
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'userId': userId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CartItemDb',
      if (id != null) 'id': id,
      'productId': productId,
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'userId': userId,
    };
  }

  static CartItemDbInclude include() {
    return CartItemDbInclude._();
  }

  static CartItemDbIncludeList includeList({
    _i1.WhereExpressionBuilder<CartItemDbTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CartItemDbTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CartItemDbTable>? orderByList,
    CartItemDbInclude? include,
  }) {
    return CartItemDbIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CartItemDb.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CartItemDb.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CartItemDbImpl extends CartItemDb {
  _CartItemDbImpl({
    int? id,
    required String productId,
    required String title,
    required double price,
    required String imageUrl,
    required int quantity,
    required String userId,
  }) : super._(
         id: id,
         productId: productId,
         title: title,
         price: price,
         imageUrl: imageUrl,
         quantity: quantity,
         userId: userId,
       );

  /// Returns a shallow copy of this [CartItemDb]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CartItemDb copyWith({
    Object? id = _Undefined,
    String? productId,
    String? title,
    double? price,
    String? imageUrl,
    int? quantity,
    String? userId,
  }) {
    return CartItemDb(
      id: id is int? ? id : this.id,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      userId: userId ?? this.userId,
    );
  }
}

class CartItemDbUpdateTable extends _i1.UpdateTable<CartItemDbTable> {
  CartItemDbUpdateTable(super.table);

  _i1.ColumnValue<String, String> productId(String value) => _i1.ColumnValue(
    table.productId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<double, double> price(double value) => _i1.ColumnValue(
    table.price,
    value,
  );

  _i1.ColumnValue<String, String> imageUrl(String value) => _i1.ColumnValue(
    table.imageUrl,
    value,
  );

  _i1.ColumnValue<int, int> quantity(int value) => _i1.ColumnValue(
    table.quantity,
    value,
  );

  _i1.ColumnValue<String, String> userId(String value) => _i1.ColumnValue(
    table.userId,
    value,
  );
}

class CartItemDbTable extends _i1.Table<int?> {
  CartItemDbTable({super.tableRelation}) : super(tableName: 'cart_item') {
    updateTable = CartItemDbUpdateTable(this);
    productId = _i1.ColumnString(
      'productId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    price = _i1.ColumnDouble(
      'price',
      this,
    );
    imageUrl = _i1.ColumnString(
      'imageUrl',
      this,
    );
    quantity = _i1.ColumnInt(
      'quantity',
      this,
    );
    userId = _i1.ColumnString(
      'userId',
      this,
    );
  }

  late final CartItemDbUpdateTable updateTable;

  late final _i1.ColumnString productId;

  late final _i1.ColumnString title;

  late final _i1.ColumnDouble price;

  late final _i1.ColumnString imageUrl;

  late final _i1.ColumnInt quantity;

  late final _i1.ColumnString userId;

  @override
  List<_i1.Column> get columns => [
    id,
    productId,
    title,
    price,
    imageUrl,
    quantity,
    userId,
  ];
}

class CartItemDbInclude extends _i1.IncludeObject {
  CartItemDbInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CartItemDb.t;
}

class CartItemDbIncludeList extends _i1.IncludeList {
  CartItemDbIncludeList._({
    _i1.WhereExpressionBuilder<CartItemDbTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CartItemDb.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CartItemDb.t;
}

class CartItemDbRepository {
  const CartItemDbRepository._();

  /// Returns a list of [CartItemDb]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<CartItemDb>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CartItemDbTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CartItemDbTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CartItemDbTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CartItemDb>(
      where: where?.call(CartItemDb.t),
      orderBy: orderBy?.call(CartItemDb.t),
      orderByList: orderByList?.call(CartItemDb.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CartItemDb] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<CartItemDb?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CartItemDbTable>? where,
    int? offset,
    _i1.OrderByBuilder<CartItemDbTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CartItemDbTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CartItemDb>(
      where: where?.call(CartItemDb.t),
      orderBy: orderBy?.call(CartItemDb.t),
      orderByList: orderByList?.call(CartItemDb.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CartItemDb] by its [id] or null if no such row exists.
  Future<CartItemDb?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CartItemDb>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CartItemDb]s in the list and returns the inserted rows.
  ///
  /// The returned [CartItemDb]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<CartItemDb>> insert(
    _i1.DatabaseSession session,
    List<CartItemDb> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CartItemDb>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CartItemDb] and returns the inserted row.
  ///
  /// The returned [CartItemDb] will have its `id` field set.
  Future<CartItemDb> insertRow(
    _i1.DatabaseSession session,
    CartItemDb row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CartItemDb>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CartItemDb]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CartItemDb>> update(
    _i1.DatabaseSession session,
    List<CartItemDb> rows, {
    _i1.ColumnSelections<CartItemDbTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CartItemDb>(
      rows,
      columns: columns?.call(CartItemDb.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CartItemDb]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CartItemDb> updateRow(
    _i1.DatabaseSession session,
    CartItemDb row, {
    _i1.ColumnSelections<CartItemDbTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CartItemDb>(
      row,
      columns: columns?.call(CartItemDb.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CartItemDb] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CartItemDb?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<CartItemDbUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CartItemDb>(
      id,
      columnValues: columnValues(CartItemDb.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CartItemDb]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CartItemDb>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CartItemDbUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CartItemDbTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CartItemDbTable>? orderBy,
    _i1.OrderByListBuilder<CartItemDbTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CartItemDb>(
      columnValues: columnValues(CartItemDb.t.updateTable),
      where: where(CartItemDb.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CartItemDb.t),
      orderByList: orderByList?.call(CartItemDb.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CartItemDb]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CartItemDb>> delete(
    _i1.DatabaseSession session,
    List<CartItemDb> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CartItemDb>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CartItemDb].
  Future<CartItemDb> deleteRow(
    _i1.DatabaseSession session,
    CartItemDb row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CartItemDb>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CartItemDb>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CartItemDbTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CartItemDb>(
      where: where(CartItemDb.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CartItemDbTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CartItemDb>(
      where: where?.call(CartItemDb.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CartItemDb] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CartItemDbTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CartItemDb>(
      where: where(CartItemDb.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
