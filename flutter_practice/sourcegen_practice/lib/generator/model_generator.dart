import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../annotations/model.dart';

class ModelGenerator extends GeneratorForAnnotation<Model> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final classElement = element as ClassElement;

    final className = classElement.displayName;

    final fields = classElement.fields.where((f) => !f.isStatic);

    final buffer = StringBuffer();

    // toJson
    buffer.writeln('''
extension ${className}Json on $className {

Map<String, dynamic> toJson() {
  return {
''');

    for (final field in fields) {
      buffer.writeln("'${field.name}': ${field.name},");
    }

    buffer.writeln('''
  };
}
''');

    // fromJson
    buffer.writeln('''
static $className fromJson(
  Map<String, dynamic> json,
) {
  return $className(
''');

    for (final field in fields) {
      buffer.writeln("${field.name}: json['${field.name}'],");
    }

    buffer.writeln('''
  );
}
}
''');

    return buffer.toString();
  }
}
