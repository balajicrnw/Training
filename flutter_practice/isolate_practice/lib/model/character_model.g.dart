// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CharacterModel> _$characterModelSerializer =
    _$CharacterModelSerializer();

class _$CharacterModelSerializer
    implements StructuredSerializer<CharacterModel> {
  @override
  final Iterable<Type> types = const [CharacterModel, _$CharacterModel];
  @override
  final String wireName = 'CharacterModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    CharacterModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'role',
      serializers.serialize(object.role, specifiedType: const FullType(String)),
      'gender',
      serializers.serialize(
        object.gender,
        specifiedType: const FullType(String),
      ),
    ];

    return result;
  }

  @override
  CharacterModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CharacterModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'role':
          result.role =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'gender':
          result.gender =
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

class _$CharacterModel extends CharacterModel {
  @override
  final String name;
  @override
  final String role;
  @override
  final String gender;

  factory _$CharacterModel([void Function(CharacterModelBuilder)? updates]) =>
      (CharacterModelBuilder()..update(updates))._build();

  _$CharacterModel._({
    required this.name,
    required this.role,
    required this.gender,
  }) : super._();
  @override
  CharacterModel rebuild(void Function(CharacterModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CharacterModelBuilder toBuilder() => CharacterModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CharacterModel &&
        name == other.name &&
        role == other.role &&
        gender == other.gender;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, gender.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CharacterModel')
          ..add('name', name)
          ..add('role', role)
          ..add('gender', gender))
        .toString();
  }
}

class CharacterModelBuilder
    implements Builder<CharacterModel, CharacterModelBuilder> {
  _$CharacterModel? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  String? _gender;
  String? get gender => _$this._gender;
  set gender(String? gender) => _$this._gender = gender;

  CharacterModelBuilder();

  CharacterModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _role = $v.role;
      _gender = $v.gender;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CharacterModel other) {
    _$v = other as _$CharacterModel;
  }

  @override
  void update(void Function(CharacterModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CharacterModel build() => _build();

  _$CharacterModel _build() {
    final _$result =
        _$v ??
        _$CharacterModel._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'CharacterModel',
            'name',
          ),
          role: BuiltValueNullFieldError.checkNotNull(
            role,
            r'CharacterModel',
            'role',
          ),
          gender: BuiltValueNullFieldError.checkNotNull(
            gender,
            r'CharacterModel',
            'gender',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
