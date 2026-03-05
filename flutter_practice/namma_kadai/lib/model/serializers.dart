import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'product.dart';
import 'cart_item.dart';
import 'order.dart';
import 'user_model.dart';

part 'serializers.g.dart';

@SerializersFor([
  Product,
  CartItem,
  Order,
  UserModel,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..addPlugin(StandardJsonPlugin()))
    .build();
