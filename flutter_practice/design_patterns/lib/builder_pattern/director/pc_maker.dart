import '../builder/pc_builder_base.dart';
import '../model/pc.dart';

/// Director — knows the exact sequence of build steps.
/// It is decoupled from which concrete builder is used.
class PCMaker {
  final PCBuilderBase _builder;

  PCMaker(this._builder);

  PC buildFullPC() {
    _builder.buildCPU();
    _builder.buildGPU();
    _builder.buildRAM();
    _builder.buildStorage();
    _builder.buildCooling();
    return _builder.getResult();
  }
}
