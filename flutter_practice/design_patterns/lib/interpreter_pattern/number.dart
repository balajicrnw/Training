import 'expression.dart';

class Number implements Expression {
  final int value;

  Number(this.value);

  @override
  int interpret() => value;
}