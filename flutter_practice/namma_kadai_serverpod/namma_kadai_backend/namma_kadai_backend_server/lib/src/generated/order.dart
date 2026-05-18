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
import 'cart_item.dart' as _i2;
import 'package:namma_kadai_backend_server/src/generated/protocol.dart' as _i3;

abstract class OrderDb
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = OrderDbTable();

  static const db = OrderDbRepository._();

  @override
  int? id;

  String? uid;

  List<_i2.CartItemDb> items;

  double totalAmount;

  DateTime dateTime;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrderDb',
      if (id != null) 'id': id,
      if (uid != null) 'uid': uid,
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'totalAmount': totalAmount,
      'dateTime': dateTime.toJson(),
    };
  }

  static OrderDbInclude include() {
    return OrderDbInclude._();
  }

  static OrderDbIncludeList includeList({
    _i1.WhereExpressionBuilder<OrderDbTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderDbTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderDbTable>? orderByList,
    OrderDbInclude? include,
  }) {
    return OrderDbIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OrderDb.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(OrderDb.t),
      include: include,
    );
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

class OrderDbUpdateTable extends _i1.UpdateTable<OrderDbTable> {
  OrderDbUpdateTable(super.table);

  _i1.ColumnValue<String, String> uid(String? value) => _i1.ColumnValue(
    table.uid,
    value,
  );

  _i1.ColumnValue<List<_i2.CartItemDb>, List<_i2.CartItemDb>> items(
    List<_i2.CartItemDb> value,
  ) => _i1.ColumnValue(
    table.items,
    value,
  );

  _i1.ColumnValue<double, double> totalAmount(double value) => _i1.ColumnValue(
    table.totalAmount,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> dateTime(DateTime value) =>
      _i1.ColumnValue(
        table.dateTime,
        value,
      );
}

class OrderDbTable extends _i1.Table<int?> {
  OrderDbTable({super.tableRelation}) : super(tableName: 'order') {
    updateTable = OrderDbUpdateTable(this);
    uid = _i1.ColumnString(
      'uid',
      this,
    );
    items = _i1.ColumnSerializable<List<_i2.CartItemDb>>(
      'items',
      this,
    );
    totalAmount = _i1.ColumnDouble(
      'totalAmount',
      this,
    );
    dateTime = _i1.ColumnDateTime(
      'dateTime',
      this,
    );
  }

  late final OrderDbUpdateTable updateTable;

  late final _i1.ColumnString uid;

  late final _i1.ColumnSerializable<List<_i2.CartItemDb>> items;

  late final _i1.ColumnDouble totalAmount;

  late final _i1.ColumnDateTime dateTime;

  @override
  List<_i1.Column> get columns => [
    id,
    uid,
    items,
    totalAmount,
    dateTime,
  ];
}

class OrderDbInclude extends _i1.IncludeObject {
  OrderDbInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => OrderDb.t;
}

class OrderDbIncludeList extends _i1.IncludeList {
  OrderDbIncludeList._({
    _i1.WhereExpressionBuilder<OrderDbTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OrderDb.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => OrderDb.t;
}

class OrderDbRepository {
  const OrderDbRepository._();

  /// Returns a list of [OrderDb]s matching the given query parameters.
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
  Future<List<OrderDb>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OrderDbTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderDbTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderDbTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OrderDb>(
      where: where?.call(OrderDb.t),
      orderBy: orderBy?.call(OrderDb.t),
      orderByList: orderByList?.call(OrderDb.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OrderDb] matching the given query parameters.
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
  Future<OrderDb?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OrderDbTable>? where,
    int? offset,
    _i1.OrderByBuilder<OrderDbTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderDbTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OrderDb>(
      where: where?.call(OrderDb.t),
      orderBy: orderBy?.call(OrderDb.t),
      orderByList: orderByList?.call(OrderDb.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OrderDb] by its [id] or null if no such row exists.
  Future<OrderDb?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OrderDb>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OrderDb]s in the list and returns the inserted rows.
  ///
  /// The returned [OrderDb]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<OrderDb>> insert(
    _i1.DatabaseSession session,
    List<OrderDb> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<OrderDb>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [OrderDb] and returns the inserted row.
  ///
  /// The returned [OrderDb] will have its `id` field set.
  Future<OrderDb> insertRow(
    _i1.DatabaseSession session,
    OrderDb row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<OrderDb>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [OrderDb]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<OrderDb>> update(
    _i1.DatabaseSession session,
    List<OrderDb> rows, {
    _i1.ColumnSelections<OrderDbTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<OrderDb>(
      rows,
      columns: columns?.call(OrderDb.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OrderDb]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OrderDb> updateRow(
    _i1.DatabaseSession session,
    OrderDb row, {
    _i1.ColumnSelections<OrderDbTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<OrderDb>(
      row,
      columns: columns?.call(OrderDb.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OrderDb] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OrderDb?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<OrderDbUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<OrderDb>(
      id,
      columnValues: columnValues(OrderDb.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OrderDb]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<OrderDb>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<OrderDbUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<OrderDbTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderDbTable>? orderBy,
    _i1.OrderByListBuilder<OrderDbTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<OrderDb>(
      columnValues: columnValues(OrderDb.t.updateTable),
      where: where(OrderDb.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OrderDb.t),
      orderByList: orderByList?.call(OrderDb.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [OrderDb]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<OrderDb>> delete(
    _i1.DatabaseSession session,
    List<OrderDb> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<OrderDb>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [OrderDb].
  Future<OrderDb> deleteRow(
    _i1.DatabaseSession session,
    OrderDb row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OrderDb>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<OrderDb>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OrderDbTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<OrderDb>(
      where: where(OrderDb.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OrderDbTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<OrderDb>(
      where: where?.call(OrderDb.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OrderDb] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OrderDbTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OrderDb>(
      where: where(OrderDb.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
