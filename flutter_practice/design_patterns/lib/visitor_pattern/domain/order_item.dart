import 'package:design_patterns/visitor_pattern/core/order_item_visitor.dart';

abstract class OrderItem {
  double price;
  OrderItem(this.price);

  void accept(OrderItemVisitor visitor);
}