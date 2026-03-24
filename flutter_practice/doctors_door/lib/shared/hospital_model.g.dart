// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<HospitalModel> _$hospitalModelSerializer =
    _$HospitalModelSerializer();

class _$HospitalModelSerializer implements StructuredSerializer<HospitalModel> {
  @override
  final Iterable<Type> types = const [HospitalModel, _$HospitalModel];
  @override
  final String wireName = 'HospitalModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    HospitalModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'address',
      serializers.serialize(
        object.address,
        specifiedType: const FullType(String),
      ),
      'rating',
      serializers.serialize(
        object.rating,
        specifiedType: const FullType(double),
      ),
      'imageUrl',
      serializers.serialize(
        object.imageUrl,
        specifiedType: const FullType(String),
      ),
      'description',
      serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      ),
    ];

    return result;
  }

  @override
  HospitalModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HospitalModelBuilder();

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
        case 'address':
          result.address =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'rating':
          result.rating =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )!
                  as double;
          break;
        case 'imageUrl':
          result.imageUrl =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'description':
          result.description =
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

class _$HospitalModel extends HospitalModel {
  @override
  final String name;
  @override
  final String address;
  @override
  final double rating;
  @override
  final String imageUrl;
  @override
  final String description;

  factory _$HospitalModel([void Function(HospitalModelBuilder)? updates]) =>
      (HospitalModelBuilder()..update(updates))._build();

  _$HospitalModel._({
    required this.name,
    required this.address,
    required this.rating,
    required this.imageUrl,
    required this.description,
  }) : super._();
  @override
  HospitalModel rebuild(void Function(HospitalModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HospitalModelBuilder toBuilder() => HospitalModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HospitalModel &&
        name == other.name &&
        address == other.address &&
        rating == other.rating &&
        imageUrl == other.imageUrl &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HospitalModel')
          ..add('name', name)
          ..add('address', address)
          ..add('rating', rating)
          ..add('imageUrl', imageUrl)
          ..add('description', description))
        .toString();
  }
}

class HospitalModelBuilder
    implements Builder<HospitalModel, HospitalModelBuilder> {
  _$HospitalModel? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  double? _rating;
  double? get rating => _$this._rating;
  set rating(double? rating) => _$this._rating = rating;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  HospitalModelBuilder();

  HospitalModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _address = $v.address;
      _rating = $v.rating;
      _imageUrl = $v.imageUrl;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HospitalModel other) {
    _$v = other as _$HospitalModel;
  }

  @override
  void update(void Function(HospitalModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HospitalModel build() => _build();

  _$HospitalModel _build() {
    final _$result =
        _$v ??
        _$HospitalModel._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'HospitalModel',
            'name',
          ),
          address: BuiltValueNullFieldError.checkNotNull(
            address,
            r'HospitalModel',
            'address',
          ),
          rating: BuiltValueNullFieldError.checkNotNull(
            rating,
            r'HospitalModel',
            'rating',
          ),
          imageUrl: BuiltValueNullFieldError.checkNotNull(
            imageUrl,
            r'HospitalModel',
            'imageUrl',
          ),
          description: BuiltValueNullFieldError.checkNotNull(
            description,
            r'HospitalModel',
            'description',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
