import 'expression.dart';

class Add implements Expression {
  final Expression left;
  final Expression right;

  Add(this.left, this.right);

  @override
  int interpret() {
    return left.interpret() + right.interpret();
  }
}