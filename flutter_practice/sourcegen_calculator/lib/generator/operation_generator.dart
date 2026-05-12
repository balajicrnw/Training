import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../annotations/operation.dart';

class OperationGenerator extends GeneratorForAnnotation<Operation> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final symbols = annotation
        .read('symbols')
        .listValue
        .map((e) => e.toStringValue())
        .whereType<String>();

    final buffer = StringBuffer();

    for (final symbol in symbols) {
      final methodName = _methodName(symbol);

      buffer.writeln('''
String ${methodName}Expression(int a, int b) {
  return '\$a $symbol \$b = \${a $symbol b}';
}
''');
    }

    return buffer.toString();
  }

  String _methodName(String symbol) {
    if (symbol == '+') return 'add';

    if (symbol == '-') return 'subtract';

    if (symbol == '*') return 'multiply';

    if (symbol == '/') return 'divide';

    return 'operation';
  }
}
