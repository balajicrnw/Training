import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:sourcegen_practice/annotations/auto_model.dart';

class AutoModelGenerator extends GeneratorForAnnotation<AutoModel> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final className = element.displayName;

    final fields = annotation.read('fields').listValue;

    final buffer = StringBuffer();

    // Class start
    buffer.writeln('''
class _$className {
''');

    // Fields
    for (final field in fields) {
      final value = field.toStringValue()!;

      final parts = value.split(' ');

      final type = parts[0];
      final name = parts[1];

      buffer.writeln('final $type $name;');
    }

    // Constructor
    buffer.writeln('''
_$className({
''');

    for (final field in fields) {
      final value = field.toStringValue()!;

      final name = value.split(' ')[1];

      buffer.writeln('required this.$name,');
    }

    buffer.writeln('''
});
''');

    // toJson
    buffer.writeln('''
Map<String, dynamic> toJson() {
  return {
''');

    for (final field in fields) {
      final value = field.toStringValue()!;

      final name = value.split(' ')[1];

      buffer.writeln("'$name': $name,");
    }

    buffer.writeln('''
  };
}
''');

    // fromJson
    buffer.writeln('''
factory _$className.fromJson(
  Map<String, dynamic> json,
) {
  return _$className(
''');

    for (final field in fields) {
      final value = field.toStringValue()!;

      final name = value.split(' ')[1];

      buffer.writeln("$name: json['$name'],");
    }

    buffer.writeln('''
  );
}
''');

    buffer.writeln('}');

    return buffer.toString();
  }
}
