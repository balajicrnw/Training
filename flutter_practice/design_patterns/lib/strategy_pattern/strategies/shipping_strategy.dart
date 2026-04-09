import '../models/order.dart';

abstract class ShippingStrategy {
  String get label;
  double calculate(Order order);
}