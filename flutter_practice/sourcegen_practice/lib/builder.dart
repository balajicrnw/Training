import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generator/hello_generator.dart';

Builder helloBuilder(BuilderOptions options) {
  return PartBuilder([HelloGenerator()], '.g.dart');
}
