import 'package:design_patterns/visitor_pattern/domain/clothing_item.dart';
import 'package:design_patterns/visitor_pattern/domain/electronics_item.dart';
import 'package:design_patterns/visitor_pattern/domain/food_item.dart';

abstract class OrderItemVisitor {
  void visitElectronics(ElectronicsItem item);
  void visitClothing(ClothingItem item);
  void visitFood(FoodItem item);
}