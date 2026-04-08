import 'package:design_patterns/command_pattern/command.dart';

class CommandHistory {
  final List<Command> history = [];

  void execute(Command command) {
    command.execute();
    history.add(command);
  }

  void undo() {
    if (history.isNotEmpty) {
      history.removeLast().undo();
    }
  }
}