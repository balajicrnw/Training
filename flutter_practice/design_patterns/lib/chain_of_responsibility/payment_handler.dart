import 'package:design_patterns/chain_of_responsibility/handler.dart';
import 'package:design_patterns/chain_of_responsibility/order.dart';

class PaymentHandler extends Handler {
  @override
  bool handle(Order order) {
    if (!order.paymentDone) {
      print("❌ Payment failed");
      return false;
    }

    print("💰 Payment OK");

    return next?.handle(order) ?? true;
  }
}