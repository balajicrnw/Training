// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<MedicineModel> _$medicineModelSerializer =
    _$MedicineModelSerializer();

class _$MedicineModelSerializer implements StructuredSerializer<MedicineModel> {
  @override
  final Iterable<Type> types = const [MedicineModel, _$MedicineModel];
  @override
  final String wireName = 'MedicineModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    MedicineModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'type',
      serializers.serialize(object.type, specifiedType: const FullType(String)),
      'price',
      serializers.serialize(
        object.price,
        specifiedType: const FullType(double),
      ),
      'description',
      serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      ),
      'imageUrl',
      serializers.serialize(
        object.imageUrl,
        specifiedType: const FullType(String),
      ),
    ];

    return result;
  }

  @override
  MedicineModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MedicineModelBuilder();

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
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'name':
          result.name =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'type':
          result.type =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'price':
          result.price =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )!
                  as double;
          break;
        case 'description':
          result.description =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'imageUrl':
          result.imageUrl =
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

class _$MedicineModel extends MedicineModel {
  @override
  final String id;
  @override
  final String name;
  @override
  final String type;
  @override
  final double price;
  @override
  final String description;
  @override
  final String imageUrl;

  factory _$MedicineModel([void Function(MedicineModelBuilder)? updates]) =>
      (MedicineModelBuilder()..update(updates))._build();

  _$MedicineModel._({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.description,
    required this.imageUrl,
  }) : super._();
  @override
  MedicineModel rebuild(void Function(MedicineModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MedicineModelBuilder toBuilder() => MedicineModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MedicineModel &&
        id == other.id &&
        name == other.name &&
        type == other.type &&
        price == other.price &&
        description == other.description &&
        imageUrl == other.imageUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MedicineModel')
          ..add('id', id)
          ..add('name', name)
          ..add('type', type)
          ..add('price', price)
          ..add('description', description)
          ..add('imageUrl', imageUrl))
        .toString();
  }
}

class MedicineModelBuilder
    implements Builder<MedicineModel, MedicineModelBuilder> {
  _$MedicineModel? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  double? _price;
  double? get price => _$this._price;
  set price(double? price) => _$this._price = price;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  MedicineModelBuilder();

  MedicineModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _type = $v.type;
      _price = $v.price;
      _description = $v.description;
      _imageUrl = $v.imageUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MedicineModel other) {
    _$v = other as _$MedicineModel;
  }

  @override
  void update(void Function(MedicineModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MedicineModel build() => _build();

  _$MedicineModel _build() {
    final _$result =
        _$v ??
        _$MedicineModel._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'MedicineModel', 'id'),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'MedicineModel',
            'name',
          ),
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'MedicineModel',
            'type',
          ),
          price: BuiltValueNullFieldError.checkNotNull(
            price,
            r'MedicineModel',
            'price',
          ),
          description: BuiltValueNullFieldError.checkNotNull(
            description,
            r'MedicineModel',
            'description',
          ),
          imageUrl: BuiltValueNullFieldError.checkNotNull(
            imageUrl,
            r'MedicineModel',
            'imageUrl',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
