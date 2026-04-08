class Order {
  final String item;
  final double amount;
  final bool inStock;
  final bool paymentDone;

  Order({
    required this.item,
    required this.amount,
    required this.inStock,
    required this.paymentDone,
  });
}