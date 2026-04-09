import 'package_size.dart';

class OrderItem {
  final String name;
  final double price;
  final PackageSize size;

  OrderItem({
    required this.name,
    required this.price,
    required this.size,
  });
}