import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../annotations/operation1.dart';

class OperationGenerator1 extends Generator {
  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    final buffer = StringBuffer();

    final checker = TypeChecker.any([TypeChecker.typeNamed(Operation1)]);

    for (final classElement in library.classes) {
      final annotations = checker.annotationsOf(classElement);

      for (final annotation in annotations) {
        final reader = ConstantReader(annotation);

        final symbol = reader.peek('symbol')?.stringValue ?? '+';

        final methodName = _methodName(symbol);

        buffer.writeln('''
String ${methodName}Expression1(int a, int b) {
  return '\$a $symbol \$b = \${a $symbol b}';
}
''');
      }
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
