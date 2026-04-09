import '../models/order.dart';
import 'shipping_strategy.dart';

class PickupStrategy implements ShippingStrategy {
  @override
  String get label => "Store Pickup";

  @override
  double calculate(Order order) => 0;
}