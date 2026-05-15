import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_user.g.dart';

abstract class AuthUser implements Built<AuthUser, AuthUserBuilder> {
  String get id;
  String get email;

  AuthUser._();
  factory AuthUser([void Function(AuthUserBuilder) updates]) = _$AuthUser;

  static Serializer<AuthUser> get serializer => _$authUserSerializer;
}
