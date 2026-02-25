library jobs;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'jobs.g.dart';

abstract class Jobs implements Built<Jobs, JobsBuilder> {
  int get id;
  String get jobTitle;
  String get companyName;

  Jobs._();

  factory Jobs([void Function(JobsBuilder) updates]) = _$Jobs;

  static Serializer<Jobs> get serializer => _$jobsSerializer;
}