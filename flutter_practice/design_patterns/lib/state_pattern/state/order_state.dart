import '../context/order_context.dart';

abstract class OrderState {
  void next(OrderContext context);
  void cancel(OrderContext context);

  String get name;
  String get message;
}