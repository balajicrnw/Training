import 'dart:convert';
import '../dummy_server/hospitals_list.dart';
import '../shared/hospital_model.dart';
import '../shared/serializers.dart';

class HospitalsService {
  static List<HospitalModel> getHospitals() {
    final jsonData = jsonDecode(HospitalsList.list) as List<dynamic>;

    return jsonData
        .map((h) => serializers.deserializeWith(HospitalModel.serializer, h)!)
        .toList();
  }
}
