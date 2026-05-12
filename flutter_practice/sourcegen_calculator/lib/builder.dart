import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generator/operation_generator.dart';

Builder operationBuilder(BuilderOptions options) {
  return PartBuilder([OperationGenerator()], '.g.dart');
}
