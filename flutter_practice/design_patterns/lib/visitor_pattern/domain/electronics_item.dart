import 'package:design_patterns/visitor_pattern/domain/order_item.dart';
import 'package:design_patterns/visitor_pattern/core/order_item_visitor.dart';

class ElectronicsItem extends OrderItem {
  ElectronicsItem(double price) : super(price);

  @override
  void accept(OrderItemVisitor visitor) {
    visitor.visitElectronics(this);
  }
}