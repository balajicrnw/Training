import 'component.dart';

class PC {
  final String type;
  final Component cpu;
  final Component gpu;
  final Component ram;
  final Component storage;
  final Component? cooling; // optional

  const PC({
    required this.type,
    required this.cpu,
    required this.gpu,
    required this.ram,
    required this.storage,
    this.cooling,
  });

  double get totalPrice =>
      cpu.price +
      gpu.price +
      ram.price +
      storage.price +
      (cooling?.price ?? 0);

  List<Component> get components => [
        cpu,
        gpu,
        ram,
        storage,
        if (cooling != null) cooling!,
      ];
}
