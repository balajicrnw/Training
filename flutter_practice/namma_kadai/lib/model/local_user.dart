import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'local_user.g.dart';

abstract class LocalUser implements Built<LocalUser, LocalUserBuilder> {
  
  int get id;
  String get email;

  LocalUser._();

  factory LocalUser([void Function(LocalUserBuilder) updates]) = _$LocalUser;

  static Serializer<LocalUser> get serializer => _$localUserSerializer;
}