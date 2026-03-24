library medicine_model;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'medicine_model.g.dart';

abstract class MedicineModel implements Built<MedicineModel, MedicineModelBuilder> {
  String get id;
  String get name;
  String get type; // e.g., 'Tablet', 'Syrup', 'Capsule', 'Cream'
  double get price;
  String get description;
  String get imageUrl;

   MedicineModel._();
  factory MedicineModel([void Function(MedicineModelBuilder) updates]) = _$MedicineModel;

  static Serializer<MedicineModel> get serializer => _$medicineModelSerializer;
}
