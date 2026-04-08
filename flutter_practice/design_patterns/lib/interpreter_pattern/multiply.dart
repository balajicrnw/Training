import 'expression.dart';

class Multiply implements Expression {
  final Expression left;
  final Expression right;

  Multiply(this.left, this.right);

  @override
  int interpret() {
    return left.interpret() * right.interpret();
  }
}