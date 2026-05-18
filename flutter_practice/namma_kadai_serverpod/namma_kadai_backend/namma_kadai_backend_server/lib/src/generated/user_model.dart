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

abstract class UserModelDb
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserModelDb._({
    this.id,
    required this.userId,
    required this.email,
    this.name,
    this.gender,
    this.profileImageUrl,
    this.createdAt,
  });

  factory UserModelDb({
    int? id,
    required String userId,
    required String email,
    String? name,
    String? gender,
    String? profileImageUrl,
    DateTime? createdAt,
  }) = _UserModelDbImpl;

  factory UserModelDb.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserModelDb(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      email: jsonSerialization['email'] as String,
      name: jsonSerialization['name'] as String?,
      gender: jsonSerialization['gender'] as String?,
      profileImageUrl: jsonSerialization['profileImageUrl'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = UserModelDbTable();

  static const db = UserModelDbRepository._();

  @override
  int? id;

  String userId;

  String email;

  String? name;

  String? gender;

  String? profileImageUrl;

  DateTime? createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserModelDb]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserModelDb copyWith({
    int? id,
    String? userId,
    String? email,
    String? name,
    String? gender,
    String? profileImageUrl,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserModelDb',
      if (id != null) 'id': id,
      'userId': userId,
      'email': email,
      if (name != null) 'name': name,
      if (gender != null) 'gender': gender,
      if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserModelDb',
      if (id != null) 'id': id,
      'userId': userId,
      'email': email,
      if (name != null) 'name': name,
      if (gender != null) 'gender': gender,
      if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  static UserModelDbInclude include() {
    return UserModelDbInclude._();
  }

  static UserModelDbIncludeList includeList({
    _i1.WhereExpressionBuilder<UserModelDbTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserModelDbTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserModelDbTable>? orderByList,
    UserModelDbInclude? include,
  }) {
    return UserModelDbIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserModelDb.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserModelDb.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserModelDbImpl extends UserModelDb {
  _UserModelDbImpl({
    int? id,
    required String userId,
    required String email,
    String? name,
    String? gender,
    String? profileImageUrl,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         email: email,
         name: name,
         gender: gender,
         profileImageUrl: profileImageUrl,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [UserModelDb]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserModelDb copyWith({
    Object? id = _Undefined,
    String? userId,
    String? email,
    Object? name = _Undefined,
    Object? gender = _Undefined,
    Object? profileImageUrl = _Undefined,
    Object? createdAt = _Undefined,
  }) {
    return UserModelDb(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name is String? ? name : this.name,
      gender: gender is String? ? gender : this.gender,
      profileImageUrl: profileImageUrl is String?
          ? profileImageUrl
          : this.profileImageUrl,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
    );
  }
}

class UserModelDbUpdateTable extends _i1.UpdateTable<UserModelDbTable> {
  UserModelDbUpdateTable(super.table);

  _i1.ColumnValue<String, String> userId(String value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> email(String value) => _i1.ColumnValue(
    table.email,
    value,
  );

  _i1.ColumnValue<String, String> name(String? value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> gender(String? value) => _i1.ColumnValue(
    table.gender,
    value,
  );

  _i1.ColumnValue<String, String> profileImageUrl(String? value) =>
      _i1.ColumnValue(
        table.profileImageUrl,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class UserModelDbTable extends _i1.Table<int?> {
  UserModelDbTable({super.tableRelation}) : super(tableName: 'user_model') {
    updateTable = UserModelDbUpdateTable(this);
    userId = _i1.ColumnString(
      'userId',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    gender = _i1.ColumnString(
      'gender',
      this,
    );
    profileImageUrl = _i1.ColumnString(
      'profileImageUrl',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final UserModelDbUpdateTable updateTable;

  late final _i1.ColumnString userId;

  late final _i1.ColumnString email;

  late final _i1.ColumnString name;

  late final _i1.ColumnString gender;

  late final _i1.ColumnString profileImageUrl;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    email,
    name,
    gender,
    profileImageUrl,
    createdAt,
  ];
}

class UserModelDbInclude extends _i1.IncludeObject {
  UserModelDbInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => UserModelDb.t;
}

class UserModelDbIncludeList extends _i1.IncludeList {
  UserModelDbIncludeList._({
    _i1.WhereExpressionBuilder<UserModelDbTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserModelDb.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserModelDb.t;
}

class UserModelDbRepository {
  const UserModelDbRepository._();

  /// Returns a list of [UserModelDb]s matching the given query parameters.
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
  Future<List<UserModelDb>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserModelDbTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserModelDbTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserModelDbTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserModelDb>(
      where: where?.call(UserModelDb.t),
      orderBy: orderBy?.call(UserModelDb.t),
      orderByList: orderByList?.call(UserModelDb.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserModelDb] matching the given query parameters.
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
  Future<UserModelDb?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserModelDbTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserModelDbTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserModelDbTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserModelDb>(
      where: where?.call(UserModelDb.t),
      orderBy: orderBy?.call(UserModelDb.t),
      orderByList: orderByList?.call(UserModelDb.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserModelDb] by its [id] or null if no such row exists.
  Future<UserModelDb?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserModelDb>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserModelDb]s in the list and returns the inserted rows.
  ///
  /// The returned [UserModelDb]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<UserModelDb>> insert(
    _i1.DatabaseSession session,
    List<UserModelDb> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<UserModelDb>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [UserModelDb] and returns the inserted row.
  ///
  /// The returned [UserModelDb] will have its `id` field set.
  Future<UserModelDb> insertRow(
    _i1.DatabaseSession session,
    UserModelDb row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserModelDb>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserModelDb]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserModelDb>> update(
    _i1.DatabaseSession session,
    List<UserModelDb> rows, {
    _i1.ColumnSelections<UserModelDbTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserModelDb>(
      rows,
      columns: columns?.call(UserModelDb.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserModelDb]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserModelDb> updateRow(
    _i1.DatabaseSession session,
    UserModelDb row, {
    _i1.ColumnSelections<UserModelDbTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserModelDb>(
      row,
      columns: columns?.call(UserModelDb.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserModelDb] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserModelDb?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<UserModelDbUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<UserModelDb>(
      id,
      columnValues: columnValues(UserModelDb.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserModelDb]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<UserModelDb>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<UserModelDbUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<UserModelDbTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserModelDbTable>? orderBy,
    _i1.OrderByListBuilder<UserModelDbTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<UserModelDb>(
      columnValues: columnValues(UserModelDb.t.updateTable),
      where: where(UserModelDb.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserModelDb.t),
      orderByList: orderByList?.call(UserModelDb.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [UserModelDb]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserModelDb>> delete(
    _i1.DatabaseSession session,
    List<UserModelDb> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserModelDb>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserModelDb].
  Future<UserModelDb> deleteRow(
    _i1.DatabaseSession session,
    UserModelDb row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserModelDb>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserModelDb>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserModelDbTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserModelDb>(
      where: where(UserModelDb.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserModelDbTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserModelDb>(
      where: where?.call(UserModelDb.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserModelDb] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserModelDbTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserModelDb>(
      where: where(UserModelDb.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
