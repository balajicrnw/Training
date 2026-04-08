import 'package:design_patterns/command_pattern/cart.dart';
import 'command.dart';

class AddItemCommand implements Command {
  final Cart cart;
  final String item;

  AddItemCommand(this.cart, this.item);

  @override
  void execute() {
    cart.addItem(item);
  }

  @override
  void undo() {
    cart.removeItem(item);
  }
}