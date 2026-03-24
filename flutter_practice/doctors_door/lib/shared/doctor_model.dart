library doctor_model;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'doctor_model.g.dart';

abstract class DoctorModel implements Built<DoctorModel, DoctorModelBuilder> {
  String get name;
  String get qualification;
  int get age;
  String get hospital;
  BuiltList<DateTime> get dates;

  DoctorModel._();
  factory DoctorModel([void Function(DoctorModelBuilder) updates]) = _$DoctorModel;

  static Serializer<DoctorModel> get serializer => _$doctorModelSerializer;
}