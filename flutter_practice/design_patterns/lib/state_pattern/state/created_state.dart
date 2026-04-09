import 'order_state.dart';
import '../context/order_context.dart';
import 'paid_state.dart';
import 'cancelled_state.dart';

class CreatedState implements OrderState {
  @override
  void next(OrderContext context) {
    context.setState(PaidState());
  }

  @override
  void cancel(OrderContext context) {
    context.setState(CancelledState());
  }

  @override
  String get name => "Created";

  @override
  String get message => "Order created. Waiting for payment.";
}