// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DoctorModel> _$doctorModelSerializer = _$DoctorModelSerializer();

class _$DoctorModelSerializer implements StructuredSerializer<DoctorModel> {
  @override
  final Iterable<Type> types = const [DoctorModel, _$DoctorModel];
  @override
  final String wireName = 'DoctorModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    DoctorModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'qualification',
      serializers.serialize(
        object.qualification,
        specifiedType: const FullType(String),
      ),
      'age',
      serializers.serialize(object.age, specifiedType: const FullType(int)),
      'hospital',
      serializers.serialize(
        object.hospital,
        specifiedType: const FullType(String),
      ),
      'dates',
      serializers.serialize(
        object.dates,
        specifiedType: const FullType(BuiltList, const [
          const FullType(DateTime),
        ]),
      ),
    ];

    return result;
  }

  @override
  DoctorModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DoctorModelBuilder();

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
        case 'qualification':
          result.qualification =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'age':
          result.age =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'hospital':
          result.hospital =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'dates':
          result.dates.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(DateTime),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$DoctorModel extends DoctorModel {
  @override
  final String name;
  @override
  final String qualification;
  @override
  final int age;
  @override
  final String hospital;
  @override
  final BuiltList<DateTime> dates;

  factory _$DoctorModel([void Function(DoctorModelBuilder)? updates]) =>
      (DoctorModelBuilder()..update(updates))._build();

  _$DoctorModel._({
    required this.name,
    required this.qualification,
    required this.age,
    required this.hospital,
    required this.dates,
  }) : super._();
  @override
  DoctorModel rebuild(void Function(DoctorModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DoctorModelBuilder toBuilder() => DoctorModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DoctorModel &&
        name == other.name &&
        qualification == other.qualification &&
        age == other.age &&
        hospital == other.hospital &&
        dates == other.dates;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, qualification.hashCode);
    _$hash = $jc(_$hash, age.hashCode);
    _$hash = $jc(_$hash, hospital.hashCode);
    _$hash = $jc(_$hash, dates.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DoctorModel')
          ..add('name', name)
          ..add('qualification', qualification)
          ..add('age', age)
          ..add('hospital', hospital)
          ..add('dates', dates))
        .toString();
  }
}

class DoctorModelBuilder implements Builder<DoctorModel, DoctorModelBuilder> {
  _$DoctorModel? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _qualification;
  String? get qualification => _$this._qualification;
  set qualification(String? qualification) =>
      _$this._qualification = qualification;

  int? _age;
  int? get age => _$this._age;
  set age(int? age) => _$this._age = age;

  String? _hospital;
  String? get hospital => _$this._hospital;
  set hospital(String? hospital) => _$this._hospital = hospital;

  ListBuilder<DateTime>? _dates;
  ListBuilder<DateTime> get dates => _$this._dates ??= ListBuilder<DateTime>();
  set dates(ListBuilder<DateTime>? dates) => _$this._dates = dates;

  DoctorModelBuilder();

  DoctorModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _qualification = $v.qualification;
      _age = $v.age;
      _hospital = $v.hospital;
      _dates = $v.dates.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DoctorModel other) {
    _$v = other as _$DoctorModel;
  }

  @override
  void update(void Function(DoctorModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DoctorModel build() => _build();

  _$DoctorModel _build() {
    _$DoctorModel _$result;
    try {
      _$result =
          _$v ??
          _$DoctorModel._(
            name: BuiltValueNullFieldError.checkNotNull(
              name,
              r'DoctorModel',
              'name',
            ),
            qualification: BuiltValueNullFieldError.checkNotNull(
              qualification,
              r'DoctorModel',
              'qualification',
            ),
            age: BuiltValueNullFieldError.checkNotNull(
              age,
              r'DoctorModel',
              'age',
            ),
            hospital: BuiltValueNullFieldError.checkNotNull(
              hospital,
              r'DoctorModel',
              'hospital',
            ),
            dates: dates.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'dates';
        dates.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'DoctorModel',
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
