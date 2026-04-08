import 'package:design_patterns/chain_of_responsibility/order.dart';

abstract class Handler {
  Handler? next;

  Handler linkWith(Handler nextHandler) {
    next = nextHandler;
    return nextHandler;
  }

  bool handle(Order order);
}