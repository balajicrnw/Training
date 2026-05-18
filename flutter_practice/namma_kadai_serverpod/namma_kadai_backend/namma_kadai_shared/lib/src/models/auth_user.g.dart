// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AuthUser> _$authUserSerializer = _$AuthUserSerializer();

class _$AuthUserSerializer implements StructuredSerializer<AuthUser> {
  @override
  final Iterable<Type> types = const [AuthUser, _$AuthUser];
  @override
  final String wireName = 'AuthUser';

  @override
  Iterable<Object?> serialize(Serializers serializers, AuthUser object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  AuthUser deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = AuthUserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$AuthUser extends AuthUser {
  @override
  final String id;
  @override
  final String email;

  factory _$AuthUser([void Function(AuthUserBuilder)? updates]) =>
      (AuthUserBuilder()..update(updates))._build();

  _$AuthUser._({required this.id, required this.email}) : super._();
  @override
  AuthUser rebuild(void Function(AuthUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthUserBuilder toBuilder() => AuthUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthUser && id == other.id && email == other.email;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthUser')
          ..add('id', id)
          ..add('email', email))
        .toString();
  }
}

class AuthUserBuilder implements Builder<AuthUser, AuthUserBuilder> {
  _$AuthUser? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  AuthUserBuilder();

  AuthUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthUser other) {
    _$v = other as _$AuthUser;
  }

  @override
  void update(void Function(AuthUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthUser build() => _build();

  _$AuthUser _build() {
    final _$result = _$v ??
        _$AuthUser._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'AuthUser', 'id'),
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'AuthUser', 'email'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
