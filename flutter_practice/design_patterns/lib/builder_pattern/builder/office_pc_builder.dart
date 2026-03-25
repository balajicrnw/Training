import 'pc_builder_base.dart';
import '../model/pc.dart';
import '../model/component.dart';

/// Concrete builder that assembles a budget-friendly office PC.
class OfficePCBuilder implements PCBuilderBase {
  late Component _cpu;
  late Component _gpu;
  late Component _ram;
  late Component _storage;

  @override
  void buildCPU() {
    _cpu = const Component(name: 'CPU', spec: 'Intel Core i5-13400', price: 219);
  }

  @override
  void buildGPU() {
    _gpu = const Component(name: 'GPU', spec: 'Intel UHD 730 (Integrated)', price: 0);
  }

  @override
  void buildRAM() {
    _ram = const Component(name: 'RAM', spec: '16 GB DDR4 3200 MHz', price: 49);
  }

  @override
  void buildStorage() {
    _storage = const Component(name: 'Storage', spec: '512 GB NVMe SSD', price: 59);
  }

  @override
  void buildCooling() {
    // Office PC uses stock cooler — no extra cooling needed
  }

  @override
  PC getResult() => PC(
        type: 'Office PC',
        cpu: _cpu,
        gpu: _gpu,
        ram: _ram,
        storage: _storage,
      );
}
