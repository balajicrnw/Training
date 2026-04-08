import 'package:design_patterns/chain_of_responsibility/handler.dart';
import 'package:design_patterns/chain_of_responsibility/order.dart';

class StockHandler extends Handler {
  @override
  bool handle(Order order) {
    if (!order.inStock) {
      print("❌ Stock failed");
      return false;
    }

    print("✅ Stock OK");

    return next?.handle(order) ?? true;
  }
}