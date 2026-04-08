import 'package:design_patterns/command_pattern/cart.dart';
import 'package:design_patterns/command_pattern/command.dart';

class RemoveItemCommand implements Command {
  final Cart cart;
  final String item;

  RemoveItemCommand(this.cart, this.item);

  @override
  void execute() {
    cart.removeItem(item);
  }

  @override
  void undo() {
    cart.addItem(item);
  }
}