import 'order_state.dart';
import '../context/order_context.dart';

class CancelledState implements OrderState {
  @override
  void next(OrderContext context) {}

  @override
  void cancel(OrderContext context) {}

  @override
  String get name => "Cancelled";

  @override
  String get message => "Order has been cancelled.";
}