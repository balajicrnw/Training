import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../annotations/auto_hello.dart';

class HelloGenerator extends GeneratorForAnnotation<AutoHello> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final className = element.displayName;

    return '''
String hello$className() {
  return "Hello from $className using SourceGen 🚀";
}
''';
  }
}
