import 'package:design_patterns/state_pattern/state/created_state.dart';

import '../model/order.dart';
import '../state/order_state.dart';


class OrderContext {
  final Order order;
  late OrderState _state;

  OrderContext(this.order) {
    _state = CreatedState();
  }

  void setState(OrderState state) {
    _state = state;
  }

  void next() => _state.next(this);
  void cancel() => _state.cancel(this);

  String get stateName => _state.name;
  String get message => _state.message;
}
