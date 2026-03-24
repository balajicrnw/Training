import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:doctors_door/shared/doctor_model.dart';
import 'package:doctors_door/shared/serializers.dart';
import 'package:doctors_door/dummy_server/doctors_list.dart';

void main() {
  test('DoctorModel deserialization test', () {
    final jsonData = jsonDecode(DoctorsList.list) as List<dynamic>;
    
    expect(() {
      for (var d in jsonData) {
        serializers.deserializeWith(DoctorModel.serializer, d);
      }
    }, returnsNormally);

    final firstDoctor = serializers.deserializeWith(DoctorModel.serializer, jsonData[0]);
    expect(firstDoctor, isNotNull);
    expect(firstDoctor!.name, 'Dr. Kumar');
    expect(firstDoctor.dates.length, 2);
    expect(firstDoctor.dates[0], DateTime.parse('2026-03-25T10:00:00').toUtc());
  });
}
