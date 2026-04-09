import 'order_state.dart';
import '../context/order_context.dart';

class DeliveredState implements OrderState {
  @override
  void next(OrderContext context) {}

  @override
  void cancel(OrderContext context) {
    print("Cannot cancel delivered order");
  }

  @override
  String get name => "Delivered";

  @override
  String get message => "Order delivered successfully.";
}