import 'package:design_patterns/chain_of_responsibility/handler.dart';
import 'package:design_patterns/chain_of_responsibility/order.dart';

class DeliveryHandler extends Handler {
  @override
  bool handle(Order order) {
    print("🚚 Delivery scheduled");
    return true;
  }
}