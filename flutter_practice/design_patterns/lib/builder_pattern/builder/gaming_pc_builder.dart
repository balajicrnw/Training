import 'pc_builder_base.dart';
import '../model/pc.dart';
import '../model/component.dart';

/// Concrete builder that assembles a high-end gaming PC.
class GamingPCBuilder implements PCBuilderBase {
  late Component _cpu;
  late Component _gpu;
  late Component _ram;
  late Component _storage;
  Component? _cooling;

  @override
  void buildCPU() {
    _cpu = const Component(name: 'CPU', spec: 'AMD Ryzen 9 7950X', price: 699);
  }

  @override
  void buildGPU() {
    _gpu = const Component(name: 'GPU', spec: 'NVIDIA RTX 4090', price: 1599);
  }

  @override
  void buildRAM() {
    _ram = const Component(name: 'RAM', spec: '64 GB DDR5 6000 MHz', price: 249);
  }

  @override
  void buildStorage() {
    _storage = const Component(name: 'Storage', spec: '2 TB NVMe Gen 4 SSD', price: 179);
  }

  @override
  void buildCooling() {
    _cooling = const Component(name: 'Cooling', spec: '360mm AIO Liquid Cooler', price: 149);
  }

  @override
  PC getResult() => PC(
        type: 'Gaming PC',
        cpu: _cpu,
        gpu: _gpu,
        ram: _ram,
        storage: _storage,
        cooling: _cooling,
      );
}
