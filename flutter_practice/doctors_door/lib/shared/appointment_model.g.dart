// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AppointmentModel> _$appointmentModelSerializer =
    _$AppointmentModelSerializer();

class _$AppointmentModelSerializer
    implements StructuredSerializer<AppointmentModel> {
  @override
  final Iterable<Type> types = const [AppointmentModel, _$AppointmentModel];
  @override
  final String wireName = 'AppointmentModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    AppointmentModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'doctorName',
      serializers.serialize(
        object.doctorName,
        specifiedType: const FullType(String),
      ),
      'hospitalName',
      serializers.serialize(
        object.hospitalName,
        specifiedType: const FullType(String),
      ),
      'appointmentDate',
      serializers.serialize(
        object.appointmentDate,
        specifiedType: const FullType(DateTime),
      ),
    ];
    Object? value;
    value = object.notes;
    if (value != null) {
      result
        ..add('notes')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  AppointmentModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AppointmentModelBuilder();

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
        case 'doctorName':
          result.doctorName =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'hospitalName':
          result.hospitalName =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'appointmentDate':
          result.appointmentDate =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(DateTime),
                  )!
                  as DateTime;
          break;
        case 'notes':
          result.notes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$AppointmentModel extends AppointmentModel {
  @override
  final String id;
  @override
  final String doctorName;
  @override
  final String hospitalName;
  @override
  final DateTime appointmentDate;
  @override
  final String? notes;

  factory _$AppointmentModel([
    void Function(AppointmentModelBuilder)? updates,
  ]) => (AppointmentModelBuilder()..update(updates))._build();

  _$AppointmentModel._({
    required this.id,
    required this.doctorName,
    required this.hospitalName,
    required this.appointmentDate,
    this.notes,
  }) : super._();
  @override
  AppointmentModel rebuild(void Function(AppointmentModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppointmentModelBuilder toBuilder() =>
      AppointmentModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppointmentModel &&
        id == other.id &&
        doctorName == other.doctorName &&
        hospitalName == other.hospitalName &&
        appointmentDate == other.appointmentDate &&
        notes == other.notes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, doctorName.hashCode);
    _$hash = $jc(_$hash, hospitalName.hashCode);
    _$hash = $jc(_$hash, appointmentDate.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AppointmentModel')
          ..add('id', id)
          ..add('doctorName', doctorName)
          ..add('hospitalName', hospitalName)
          ..add('appointmentDate', appointmentDate)
          ..add('notes', notes))
        .toString();
  }
}

class AppointmentModelBuilder
    implements Builder<AppointmentModel, AppointmentModelBuilder> {
  _$AppointmentModel? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _doctorName;
  String? get doctorName => _$this._doctorName;
  set doctorName(String? doctorName) => _$this._doctorName = doctorName;

  String? _hospitalName;
  String? get hospitalName => _$this._hospitalName;
  set hospitalName(String? hospitalName) => _$this._hospitalName = hospitalName;

  DateTime? _appointmentDate;
  DateTime? get appointmentDate => _$this._appointmentDate;
  set appointmentDate(DateTime? appointmentDate) =>
      _$this._appointmentDate = appointmentDate;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  AppointmentModelBuilder();

  AppointmentModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _doctorName = $v.doctorName;
      _hospitalName = $v.hospitalName;
      _appointmentDate = $v.appointmentDate;
      _notes = $v.notes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppointmentModel other) {
    _$v = other as _$AppointmentModel;
  }

  @override
  void update(void Function(AppointmentModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AppointmentModel build() => _build();

  _$AppointmentModel _build() {
    final _$result =
        _$v ??
        _$AppointmentModel._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'AppointmentModel',
            'id',
          ),
          doctorName: BuiltValueNullFieldError.checkNotNull(
            doctorName,
            r'AppointmentModel',
            'doctorName',
          ),
          hospitalName: BuiltValueNullFieldError.checkNotNull(
            hospitalName,
            r'AppointmentModel',
            'hospitalName',
          ),
          appointmentDate: BuiltValueNullFieldError.checkNotNull(
            appointmentDate,
            r'AppointmentModel',
            'appointmentDate',
          ),
          notes: notes,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
