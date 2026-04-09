import '../models/order.dart';
import 'shipping_strategy.dart';

class PriorityStrategy implements ShippingStrategy {
  @override
  String get label => "Fast Delivery";

  @override
  double calculate(Order order) => 9.99;
}