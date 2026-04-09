
import 'package:design_patterns/visitor_pattern/core/order_item_visitor.dart';
import 'package:design_patterns/visitor_pattern/domain/order_item.dart';

class ClothingItem extends OrderItem {
  ClothingItem(double price) : super(price);

  @override
  void accept(OrderItemVisitor visitor) {
    visitor.visitClothing(this);
  }
}