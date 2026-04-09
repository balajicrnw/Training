import 'order_item.dart';

class Order {
  List<OrderItem> items = [];

  double get total =>
      items.fold(0, (sum, item) => sum + item.price);
}