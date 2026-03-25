import '../model/pc.dart';

/// Abstract builder — defines the steps for constructing a PC.
abstract class PCBuilderBase {
  void buildCPU();
  void buildGPU();
  void buildRAM();
  void buildStorage();
  void buildCooling(); // optional step
  PC getResult();
}
