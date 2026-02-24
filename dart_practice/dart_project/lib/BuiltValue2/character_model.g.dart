// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Characters> _$charactersSerializer = _$CharactersSerializer();

class _$CharactersSerializer implements StructuredSerializer<Characters> {
  @override
  final Iterable<Type> types = const [Characters, _$Characters];
  @override
  final String wireName = 'Characters';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    Characters object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'species',
      serializers.serialize(
        object.species,
        specifiedType: const FullType(String),
      ),
    ];

    return result;
  }

  @override
  Characters deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CharactersBuilder();

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
        case 'id':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'species':
          result.species =
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

class _$Characters extends Characters {
  @override
  final String name;
  @override
  final int id;
  @override
  final String species;

  factory _$Characters([void Function(CharactersBuilder)? updates]) =>
      (CharactersBuilder()..update(updates))._build();

  _$Characters._({required this.name, required this.id, required this.species})
    : super._();
  @override
  Characters rebuild(void Function(CharactersBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CharactersBuilder toBuilder() => CharactersBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Characters &&
        name == other.name &&
        id == other.id &&
        species == other.species;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, species.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Characters')
          ..add('name', name)
          ..add('id', id)
          ..add('species', species))
        .toString();
  }
}

class CharactersBuilder implements Builder<Characters, CharactersBuilder> {
  _$Characters? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _species;
  String? get species => _$this._species;
  set species(String? species) => _$this._species = species;

  CharactersBuilder();

  CharactersBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _id = $v.id;
      _species = $v.species;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Characters other) {
    _$v = other as _$Characters;
  }

  @override
  void update(void Function(CharactersBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Characters build() => _build();

  _$Characters _build() {
    final _$result =
        _$v ??
        _$Characters._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'Characters',
            'name',
          ),
          id: BuiltValueNullFieldError.checkNotNull(id, r'Characters', 'id'),
          species: BuiltValueNullFieldError.checkNotNull(
            species,
            r'Characters',
            'species',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
