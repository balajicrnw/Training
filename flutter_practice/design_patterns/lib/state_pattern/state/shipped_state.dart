import 'order_state.dart';
import '../context/order_context.dart';
import '../state/delivered_state.dart';

class ShippedState implements OrderState {
  @override
  void next(OrderContext context) {
    context.setState(DeliveredState());
  }

  @override
  void cancel(OrderContext context) {
    print("Cannot cancel after shipping");
  }

  @override
  String get name => "Shipped";

  @override
  String get message => "Order shipped. On the way!";
}