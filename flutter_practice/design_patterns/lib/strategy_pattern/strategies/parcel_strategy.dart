import 'package:design_patterns/strategy_pattern/models/package_size.dart';

import '../models/order.dart';
import '../models/order_item.dart';
import 'shipping_strategy.dart';

class ParcelStrategy implements ShippingStrategy {
  @override
  String get label => "Parcel Delivery";

  @override
  double calculate(Order order) {
    return order.items.fold(0, (sum, item) {
      return sum + _cost(item);
    });
  }

  double _cost(OrderItem item) {
    switch (item.size) {
      case PackageSize.s:
        return 2;
      case PackageSize.m:
        return 4;
      case PackageSize.l:
        return 6;
    }
  }
}