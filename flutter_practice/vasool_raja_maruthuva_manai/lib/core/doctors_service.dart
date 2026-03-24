import 'dart:convert';
import '../dummy_server/doctors_list.dart';
import '../shared/doctor_model.dart'; 
import '../shared/serializers.dart'; 

class DoctorsService {
  static List<DoctorModel> getDoctors() {
    final jsonData = jsonDecode(DoctorsList.list) as List<dynamic>;

    return jsonData.map((d) => serializers.deserializeWith(DoctorModel.serializer,d,)!).toList();
  }
}