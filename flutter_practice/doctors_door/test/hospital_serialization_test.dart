import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:doctors_door/shared/hospital_model.dart';
import 'package:doctors_door/shared/serializers.dart';
import 'package:doctors_door/dummy_server/hospitals_list.dart';

void main() {
  test('HospitalModel deserialization test', () {
    final jsonData = jsonDecode(HospitalsList.list) as List<dynamic>;
    
    expect(() {
      for (var h in jsonData) {
        serializers.deserializeWith(HospitalModel.serializer, h);
      }
    }, returnsNormally);

    final firstHospital = serializers.deserializeWith(HospitalModel.serializer, jsonData[0]);
    expect(firstHospital, isNotNull);
    expect(firstHospital!.name, 'City General Hospital');
    expect(firstHospital.rating, 4.5);
  });
}
