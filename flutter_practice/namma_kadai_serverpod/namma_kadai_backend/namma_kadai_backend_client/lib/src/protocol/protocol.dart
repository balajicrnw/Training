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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'cart_item.dart' as _i2;
import 'greetings/greeting.dart' as _i3;
import 'order.dart' as _i4;
import 'product.dart' as _i5;
import 'user_model.dart' as _i6;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i7;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i8;
export 'cart_item.dart';
export 'greetings/greeting.dart';
export 'order.dart';
export 'product.dart';
export 'user_model.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.CartItemDb) {
      return _i2.CartItemDb.fromJson(data) as T;
    }
    if (t == _i3.Greeting) {
      return _i3.Greeting.fromJson(data) as T;
    }
    if (t == _i4.OrderDb) {
      return _i4.OrderDb.fromJson(data) as T;
    }
    if (t == _i5.ProductDb) {
      return _i5.ProductDb.fromJson(data) as T;
    }
    if (t == _i6.UserModelDb) {
      return _i6.UserModelDb.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.CartItemDb?>()) {
      return (data != null ? _i2.CartItemDb.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.Greeting?>()) {
      return (data != null ? _i3.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.OrderDb?>()) {
      return (data != null ? _i4.OrderDb.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.ProductDb?>()) {
      return (data != null ? _i5.ProductDb.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.UserModelDb?>()) {
      return (data != null ? _i6.UserModelDb.fromJson(data) : null) as T;
    }
    if (t == List<_i2.CartItemDb>) {
      return (data as List).map((e) => deserialize<_i2.CartItemDb>(e)).toList()
          as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<dynamic>(v)),
          )
          as T;
    }
    try {
      return _i7.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i8.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.CartItemDb => 'CartItemDb',
      _i3.Greeting => 'Greeting',
      _i4.OrderDb => 'OrderDb',
      _i5.ProductDb => 'ProductDb',
      _i6.UserModelDb => 'UserModelDb',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'namma_kadai_backend.',
        '',
      );
    }

    switch (data) {
      case _i2.CartItemDb():
        return 'CartItemDb';
      case _i3.Greeting():
        return 'Greeting';
      case _i4.OrderDb():
        return 'OrderDb';
      case _i5.ProductDb():
        return 'ProductDb';
      case _i6.UserModelDb():
        return 'UserModelDb';
    }
    className = _i7.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i8.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'CartItemDb') {
      return deserialize<_i2.CartItemDb>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i3.Greeting>(data['data']);
    }
    if (dataClassName == 'OrderDb') {
      return deserialize<_i4.OrderDb>(data['data']);
    }
    if (dataClassName == 'ProductDb') {
      return deserialize<_i5.ProductDb>(data['data']);
    }
    if (dataClassName == 'UserModelDb') {
      return deserialize<_i6.UserModelDb>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i7.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i8.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i7.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i8.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
