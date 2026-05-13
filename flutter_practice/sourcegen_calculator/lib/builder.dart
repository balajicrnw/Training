import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:sourcegen_calculator/generator/operation_generator%201.dart';

import 'generator/operation_generator.dart';

Builder sharedBuilder(BuilderOptions options) {
  return SharedPartBuilder([
    OperationGenerator(),
    OperationGenerator1(),
  ], 'sourcegen_calculator');
}
