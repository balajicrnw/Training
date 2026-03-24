import 'dart:convert';
import '../shared/medicine_model.dart';
import '../shared/serializers.dart';
import '../dummy_server/medicines_list.dart';

class PharmacyService {
  static List<MedicineModel> getMedicines() {
    return medicinesList.map((m) {
      return serializers.deserializeWith(MedicineModel.serializer, m)!;
    }).toList();
  }
}
