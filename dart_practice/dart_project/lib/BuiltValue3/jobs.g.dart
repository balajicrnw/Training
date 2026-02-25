// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Jobs> _$jobsSerializer = _$JobsSerializer();

class _$JobsSerializer implements StructuredSerializer<Jobs> {
  @override
  final Iterable<Type> types = const [Jobs, _$Jobs];
  @override
  final String wireName = 'Jobs';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    Jobs object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'jobTitle',
      serializers.serialize(
        object.jobTitle,
        specifiedType: const FullType(String),
      ),
      'companyName',
      serializers.serialize(
        object.companyName,
        specifiedType: const FullType(String),
      ),
    ];

    return result;
  }

  @override
  Jobs deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = JobsBuilder();

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
        case 'jobTitle':
          result.jobTitle =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'companyName':
          result.companyName =
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

class _$Jobs extends Jobs {
  @override
  final int id;
  @override
  final String jobTitle;
  @override
  final String companyName;

  factory _$Jobs([void Function(JobsBuilder)? updates]) =>
      (JobsBuilder()..update(updates))._build();

  _$Jobs._({
    required this.id,
    required this.jobTitle,
    required this.companyName,
  }) : super._();
  @override
  Jobs rebuild(void Function(JobsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  JobsBuilder toBuilder() => JobsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Jobs &&
        id == other.id &&
        jobTitle == other.jobTitle &&
        companyName == other.companyName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, jobTitle.hashCode);
    _$hash = $jc(_$hash, companyName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Jobs')
          ..add('id', id)
          ..add('jobTitle', jobTitle)
          ..add('companyName', companyName))
        .toString();
  }
}

class JobsBuilder implements Builder<Jobs, JobsBuilder> {
  _$Jobs? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _jobTitle;
  String? get jobTitle => _$this._jobTitle;
  set jobTitle(String? jobTitle) => _$this._jobTitle = jobTitle;

  String? _companyName;
  String? get companyName => _$this._companyName;
  set companyName(String? companyName) => _$this._companyName = companyName;

  JobsBuilder();

  JobsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _jobTitle = $v.jobTitle;
      _companyName = $v.companyName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Jobs other) {
    _$v = other as _$Jobs;
  }

  @override
  void update(void Function(JobsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Jobs build() => _build();

  _$Jobs _build() {
    final _$result =
        _$v ??
        _$Jobs._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Jobs', 'id'),
          jobTitle: BuiltValueNullFieldError.checkNotNull(
            jobTitle,
            r'Jobs',
            'jobTitle',
          ),
          companyName: BuiltValueNullFieldError.checkNotNull(
            companyName,
            r'Jobs',
            'companyName',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
