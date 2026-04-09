import 'order_state.dart';
import '../context/order_context.dart';
import 'shipped_state.dart';
import 'cancelled_state.dart';

class PaidState implements OrderState {
  @override
  void next(OrderContext context) {
    context.setState(ShippedState());
  }

  @override
  void cancel(OrderContext context) {
    context.setState(CancelledState());
  }

  @override
  String get name => "Paid";

  @override
  String get message => "Payment received. Preparing shipment.";
}