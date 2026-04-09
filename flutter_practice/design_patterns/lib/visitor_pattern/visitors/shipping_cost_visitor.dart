import 'package:design_patterns/visitor_pattern/core/order_item_visitor.dart';
import 'package:design_patterns/visitor_pattern/domain/clothing_item.dart';
import 'package:design_patterns/visitor_pattern/domain/electronics_item.dart';
import 'package:design_patterns/visitor_pattern/domain/food_item.dart';

class ShippingCostVisitor implements OrderItemVisitor {
  double totalShipping = 0;

  @override
  void visitElectronics(ElectronicsItem item) {
    totalShipping += 50; // heavy item
  }

  @override
  void visitClothing(ClothingItem item) {
    totalShipping += 20;
  }

  @override
  void visitFood(FoodItem item) {
    totalShipping += 10;
  }
}