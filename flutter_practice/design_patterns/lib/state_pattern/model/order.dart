class Order {
  final String id;
  final String productName;
  final double price;
  final int quantity;

  Order({
    required this.id,
    required this.productName,
    required this.price,
    required this.quantity,
  });

  double get total => price * quantity;
}