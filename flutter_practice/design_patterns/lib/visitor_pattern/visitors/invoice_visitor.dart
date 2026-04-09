import 'package:design_patterns/visitor_pattern/core/order_item_visitor.dart';
import 'package:design_patterns/visitor_pattern/domain/clothing_item.dart';
import 'package:design_patterns/visitor_pattern/domain/electronics_item.dart';
import 'package:design_patterns/visitor_pattern/domain/food_item.dart';

class InvoiceVisitor implements OrderItemVisitor {
  double total = 0;

  @override
  void visitElectronics(ElectronicsItem item) {
    total += item.price;
  }

  @override
  void visitClothing(ClothingItem item) {
    total += item.price;
  }

  @override
  void visitFood(FoodItem item) {
    total += item.price;
  }

  void printInvoice() {
    print("Total Invoice: ₹$total");
  }
}