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

abstract class ProductDb
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = ProductDbTable();

  static const db = ProductDbRepository._();

  @override
  int? id;

  String title;

  String description;

  double price;

  String imageUrl;

  String? category;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static ProductDbInclude include() {
    return ProductDbInclude._();
  }

  static ProductDbIncludeList includeList({
    _i1.WhereExpressionBuilder<ProductDbTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductDbTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductDbTable>? orderByList,
    ProductDbInclude? include,
  }) {
    return ProductDbIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProductDb.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ProductDb.t),
      include: include,
    );
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

class ProductDbUpdateTable extends _i1.UpdateTable<ProductDbTable> {
  ProductDbUpdateTable(super.table);

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> description(String value) => _i1.ColumnValue(
    table.description,
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

  _i1.ColumnValue<String, String> category(String? value) => _i1.ColumnValue(
    table.category,
    value,
  );
}

class ProductDbTable extends _i1.Table<int?> {
  ProductDbTable({super.tableRelation}) : super(tableName: 'product') {
    updateTable = ProductDbUpdateTable(this);
    title = _i1.ColumnString(
      'title',
      this,
    );
    description = _i1.ColumnString(
      'description',
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
    category = _i1.ColumnString(
      'category',
      this,
    );
  }

  late final ProductDbUpdateTable updateTable;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnDouble price;

  late final _i1.ColumnString imageUrl;

  late final _i1.ColumnString category;

  @override
  List<_i1.Column> get columns => [
    id,
    title,
    description,
    price,
    imageUrl,
    category,
  ];
}

class ProductDbInclude extends _i1.IncludeObject {
  ProductDbInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ProductDb.t;
}

class ProductDbIncludeList extends _i1.IncludeList {
  ProductDbIncludeList._({
    _i1.WhereExpressionBuilder<ProductDbTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ProductDb.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ProductDb.t;
}

class ProductDbRepository {
  const ProductDbRepository._();

  /// Returns a list of [ProductDb]s matching the given query parameters.
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
  Future<List<ProductDb>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductDbTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductDbTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductDbTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ProductDb>(
      where: where?.call(ProductDb.t),
      orderBy: orderBy?.call(ProductDb.t),
      orderByList: orderByList?.call(ProductDb.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ProductDb] matching the given query parameters.
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
  Future<ProductDb?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductDbTable>? where,
    int? offset,
    _i1.OrderByBuilder<ProductDbTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductDbTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ProductDb>(
      where: where?.call(ProductDb.t),
      orderBy: orderBy?.call(ProductDb.t),
      orderByList: orderByList?.call(ProductDb.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ProductDb] by its [id] or null if no such row exists.
  Future<ProductDb?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ProductDb>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ProductDb]s in the list and returns the inserted rows.
  ///
  /// The returned [ProductDb]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ProductDb>> insert(
    _i1.DatabaseSession session,
    List<ProductDb> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ProductDb>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ProductDb] and returns the inserted row.
  ///
  /// The returned [ProductDb] will have its `id` field set.
  Future<ProductDb> insertRow(
    _i1.DatabaseSession session,
    ProductDb row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ProductDb>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ProductDb]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ProductDb>> update(
    _i1.DatabaseSession session,
    List<ProductDb> rows, {
    _i1.ColumnSelections<ProductDbTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ProductDb>(
      rows,
      columns: columns?.call(ProductDb.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProductDb]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ProductDb> updateRow(
    _i1.DatabaseSession session,
    ProductDb row, {
    _i1.ColumnSelections<ProductDbTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ProductDb>(
      row,
      columns: columns?.call(ProductDb.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProductDb] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ProductDb?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ProductDbUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ProductDb>(
      id,
      columnValues: columnValues(ProductDb.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ProductDb]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ProductDb>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ProductDbUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ProductDbTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductDbTable>? orderBy,
    _i1.OrderByListBuilder<ProductDbTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ProductDb>(
      columnValues: columnValues(ProductDb.t.updateTable),
      where: where(ProductDb.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProductDb.t),
      orderByList: orderByList?.call(ProductDb.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ProductDb]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ProductDb>> delete(
    _i1.DatabaseSession session,
    List<ProductDb> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ProductDb>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ProductDb].
  Future<ProductDb> deleteRow(
    _i1.DatabaseSession session,
    ProductDb row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ProductDb>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ProductDb>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProductDbTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ProductDb>(
      where: where(ProductDb.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductDbTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ProductDb>(
      where: where?.call(ProductDb.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ProductDb] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProductDbTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ProductDb>(
      where: where(ProductDb.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
