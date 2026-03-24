library hospital_model;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hospital_model.g.dart';

abstract class HospitalModel implements Built<HospitalModel, HospitalModelBuilder> {
  String get name;
  String get address;
  double get rating;
  String get imageUrl;
  String get description;

  HospitalModel._();
  factory HospitalModel([void Function(HospitalModelBuilder) updates]) = _$HospitalModel;

  static Serializer<HospitalModel> get serializer => _$hospitalModelSerializer;
}
