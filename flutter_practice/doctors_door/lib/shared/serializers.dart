library serializers;

import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'doctor_model.dart';

import 'appointment_model.dart';
import 'hospital_model.dart';
import 'medicine_model.dart';

part 'serializers.g.dart';

@SerializersFor([
  DoctorModel,
  HospitalModel,
  AppointmentModel,
  MedicineModel,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..add(Iso8601DateTimeSerializer())
      ..addPlugin(StandardJsonPlugin()))
    .build();