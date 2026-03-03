// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<LocalUser> _$localUserSerializer = _$LocalUserSerializer();

class _$LocalUserSerializer implements StructuredSerializer<LocalUser> {
  @override
  final Iterable<Type> types = const [LocalUser, _$LocalUser];
  @override
  final String wireName = 'LocalUser';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    LocalUser object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'email',
      serializers.serialize(
        object.email,
        specifiedType: const FullType(String),
      ),
    ];

    return result;
  }

  @override
  LocalUser deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LocalUserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'email':
          result.email =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
      }
    }

    return result.build();
  }
}

class _$LocalUser extends LocalUser {
  @override
  final int id;
  @override
  final String email;

  factory _$LocalUser([void Function(LocalUserBuilder)? updates]) =>
      (LocalUserBuilder()..update(updates))._build();

  _$LocalUser._({required this.id, required this.email}) : super._();
  @override
  LocalUser rebuild(void Function(LocalUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LocalUserBuilder toBuilder() => LocalUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LocalUser && id == other.id && email == other.email;
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
    return (newBuiltValueToStringHelper(r'LocalUser')
          ..add('id', id)
          ..add('email', email))
        .toString();
  }
}

class LocalUserBuilder implements Builder<LocalUser, LocalUserBuilder> {
  _$LocalUser? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  LocalUserBuilder();

  LocalUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LocalUser other) {
    _$v = other as _$LocalUser;
  }

  @override
  void update(void Function(LocalUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LocalUser build() => _build();

  _$LocalUser _build() {
    final _$result =
        _$v ??
        _$LocalUser._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'LocalUser', 'id'),
          email: BuiltValueNullFieldError.checkNotNull(
            email,
            r'LocalUser',
            'email',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
