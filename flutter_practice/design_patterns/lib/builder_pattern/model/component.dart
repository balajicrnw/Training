class Component {
  final String name;
  final String spec;
  final double price;

  const Component({
    required this.name,
    required this.spec,
    required this.price,
  });

  @override
  String toString() => '$name: $spec (\$$price)';
}
