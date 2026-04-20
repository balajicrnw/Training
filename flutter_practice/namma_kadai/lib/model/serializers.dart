import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'product.dart';
import 'cart_item.dart';
import 'order.dart';
import 'user_model.dart';

part 'serializers.g.dart';

@SerializersFor([Product, CartItem, Order, UserModel])
final Serializers serializers =
    (_$serializers.toBuilder()
          ..add(MyDateTimeSerializer())
          ..addPlugin(StandardJsonPlugin()))
        .build();

class MyDateTimeSerializer implements PrimitiveSerializer<DateTime> {
  @override
  final Iterable<Type> types = [DateTime];
  @override
  final String wireName = 'DateTime';

  @override
  Object serialize(
    Serializers serializers,
    DateTime dateTime, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return dateTime.toIso8601String();
  }

  @override
  DateTime deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    if (serialized is int) {
      return DateTime.fromMillisecondsSinceEpoch(serialized);
    }
    return DateTime.parse(serialized as String);
  }
}
