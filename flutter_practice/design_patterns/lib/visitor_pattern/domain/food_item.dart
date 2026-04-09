import 'package:design_patterns/visitor_pattern/domain/order_item.dart';
import 'package:design_patterns/visitor_pattern/core/order_item_visitor.dart';
class FoodItem extends OrderItem {
  FoodItem(double price) : super(price);

  @override
  void accept(OrderItemVisitor visitor) {
    visitor.visitFood(this);
  }
}