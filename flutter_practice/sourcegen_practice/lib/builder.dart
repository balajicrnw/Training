import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:sourcegen_practice/generator/auto_model_generator.dart';

import 'generator/hello_generator.dart';
import 'generator/model_generator.dart';

Builder sharedBuilder(BuilderOptions options) {
  return SharedPartBuilder([
    HelloGenerator(),
    ModelGenerator(),
    AutoModelGenerator(),
  ], 'sourcegen_practice');
}
