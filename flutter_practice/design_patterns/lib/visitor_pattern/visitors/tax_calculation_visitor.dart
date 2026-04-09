import 'package:design_patterns/visitor_pattern/core/order_item_visitor.dart';
import 'package:design_patterns/visitor_pattern/domain/clothing_item.dart';
import 'package:design_patterns/visitor_pattern/domain/electronics_item.dart';
import 'package:design_patterns/visitor_pattern/domain/food_item.dart';

class TaxVisitor implements OrderItemVisitor {
  double tax = 0;

  @override
  void visitElectronics(ElectronicsItem item) {
    tax += item.price * 0.18;
  }

  @override
  void visitClothing(ClothingItem item) {
    tax += item.price * 0.05;
  }

  @override
  void visitFood(FoodItem item) {
    tax += item.price * 0.02;
  }

  void printTax() {
    print("Total Tax: ₹$tax");
  }
}