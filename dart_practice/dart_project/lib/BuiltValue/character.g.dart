// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Character> _$characterSerializer = _$CharacterSerializer();

class _$CharacterSerializer implements StructuredSerializer<Character> {
  @override
  final Iterable<Type> types = const [Character, _$Character];
  @override
  final String wireName = 'Character';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    Character object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'fullName',
      serializers.serialize(
        object.fullName,
        specifiedType: const FullType(String),
      ),
      'nickname',
      serializers.serialize(
        object.nickname,
        specifiedType: const FullType(String),
      ),
      'hogwartsHouse',
      serializers.serialize(
        object.hogwartsHouse,
        specifiedType: const FullType(String),
      ),
      'interpretedBy',
      serializers.serialize(
        object.interpretedBy,
        specifiedType: const FullType(String),
      ),
      'children',
      serializers.serialize(
        object.children,
        specifiedType: const FullType(BuiltList, const [
          const FullType(String),
        ]),
      ),
      'image',
      serializers.serialize(
        object.image,
        specifiedType: const FullType(String),
      ),
      'birthdate',
      serializers.serialize(
        object.birthdate,
        specifiedType: const FullType(String),
      ),
      'index',
      serializers.serialize(object.index, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  Character deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CharacterBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'fullName':
          result.fullName =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'nickname':
          result.nickname =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'hogwartsHouse':
          result.hogwartsHouse =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'interpretedBy':
          result.interpretedBy =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'children':
          result.children.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(String),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'image':
          result.image =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'birthdate':
          result.birthdate =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'index':
          result.index =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
      }
    }

    return result.build();
  }
}

class _$Character extends Character {
  @override
  final String fullName;
  @override
  final String nickname;
  @override
  final String hogwartsHouse;
  @override
  final String interpretedBy;
  @override
  final BuiltList<String> children;
  @override
  final String image;
  @override
  final String birthdate;
  @override
  final int index;

  factory _$Character([void Function(CharacterBuilder)? updates]) =>
      (CharacterBuilder()..update(updates))._build();

  _$Character._({
    required this.fullName,
    required this.nickname,
    required this.hogwartsHouse,
    required this.interpretedBy,
    required this.children,
    required this.image,
    required this.birthdate,
    required this.index,
  }) : super._();
  @override
  Character rebuild(void Function(CharacterBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CharacterBuilder toBuilder() => CharacterBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Character &&
        fullName == other.fullName &&
        nickname == other.nickname &&
        hogwartsHouse == other.hogwartsHouse &&
        interpretedBy == other.interpretedBy &&
        children == other.children &&
        image == other.image &&
        birthdate == other.birthdate &&
        index == other.index;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, fullName.hashCode);
    _$hash = $jc(_$hash, nickname.hashCode);
    _$hash = $jc(_$hash, hogwartsHouse.hashCode);
    _$hash = $jc(_$hash, interpretedBy.hashCode);
    _$hash = $jc(_$hash, children.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, birthdate.hashCode);
    _$hash = $jc(_$hash, index.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Character')
          ..add('fullName', fullName)
          ..add('nickname', nickname)
          ..add('hogwartsHouse', hogwartsHouse)
          ..add('interpretedBy', interpretedBy)
          ..add('children', children)
          ..add('image', image)
          ..add('birthdate', birthdate)
          ..add('index', index))
        .toString();
  }
}

class CharacterBuilder implements Builder<Character, CharacterBuilder> {
  _$Character? _$v;

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

  String? _nickname;
  String? get nickname => _$this._nickname;
  set nickname(String? nickname) => _$this._nickname = nickname;

  String? _hogwartsHouse;
  String? get hogwartsHouse => _$this._hogwartsHouse;
  set hogwartsHouse(String? hogwartsHouse) =>
      _$this._hogwartsHouse = hogwartsHouse;

  String? _interpretedBy;
  String? get interpretedBy => _$this._interpretedBy;
  set interpretedBy(String? interpretedBy) =>
      _$this._interpretedBy = interpretedBy;

  ListBuilder<String>? _children;
  ListBuilder<String> get children =>
      _$this._children ??= ListBuilder<String>();
  set children(ListBuilder<String>? children) => _$this._children = children;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  String? _birthdate;
  String? get birthdate => _$this._birthdate;
  set birthdate(String? birthdate) => _$this._birthdate = birthdate;

  int? _index;
  int? get index => _$this._index;
  set index(int? index) => _$this._index = index;

  CharacterBuilder();

  CharacterBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fullName = $v.fullName;
      _nickname = $v.nickname;
      _hogwartsHouse = $v.hogwartsHouse;
      _interpretedBy = $v.interpretedBy;
      _children = $v.children.toBuilder();
      _image = $v.image;
      _birthdate = $v.birthdate;
      _index = $v.index;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Character other) {
    _$v = other as _$Character;
  }

  @override
  void update(void Function(CharacterBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Character build() => _build();

  _$Character _build() {
    _$Character _$result;
    try {
      _$result =
          _$v ??
          _$Character._(
            fullName: BuiltValueNullFieldError.checkNotNull(
              fullName,
              r'Character',
              'fullName',
            ),
            nickname: BuiltValueNullFieldError.checkNotNull(
              nickname,
              r'Character',
              'nickname',
            ),
            hogwartsHouse: BuiltValueNullFieldError.checkNotNull(
              hogwartsHouse,
              r'Character',
              'hogwartsHouse',
            ),
            interpretedBy: BuiltValueNullFieldError.checkNotNull(
              interpretedBy,
              r'Character',
              'interpretedBy',
            ),
            children: children.build(),
            image: BuiltValueNullFieldError.checkNotNull(
              image,
              r'Character',
              'image',
            ),
            birthdate: BuiltValueNullFieldError.checkNotNull(
              birthdate,
              r'Character',
              'birthdate',
            ),
            index: BuiltValueNullFieldError.checkNotNull(
              index,
              r'Character',
              'index',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'children';
        children.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'Character',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
