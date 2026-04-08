import 'dart:collection';
import 'expression.dart';
import 'number.dart';
import 'add.dart';
import 'multiply.dart';

class Parser {
  static Expression build(String input) {
    final stack = Queue<Expression>();
    final tokens = input.trim().split(" ");

    for (final token in tokens) {
      if (token == "+") {
        final right = stack.removeLast();
        final left = stack.removeLast();
        stack.addLast(Add(left, right));
      } else if (token == "*") {
        final right = stack.removeLast();
        final left = stack.removeLast();
        stack.addLast(Multiply(left, right));
      } else {
        stack.addLast(Number(int.parse(token)));
      }
    }

    return stack.single;
  }
}