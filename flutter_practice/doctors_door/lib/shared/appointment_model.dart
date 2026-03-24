library appointment_model;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'appointment_model.g.dart';

abstract class AppointmentModel implements Built<AppointmentModel, AppointmentModelBuilder> {
  String get id;
  String get doctorName;
  String get hospitalName;
  DateTime get appointmentDate;
  String? get notes;

  AppointmentModel._();
  factory AppointmentModel([void Function(AppointmentModelBuilder) updates]) = _$AppointmentModel;

  static Serializer<AppointmentModel> get serializer => _$appointmentModelSerializer;
}
