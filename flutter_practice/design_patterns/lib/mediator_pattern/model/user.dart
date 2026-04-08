import '../mediator/chat_mediator.dart';
import 'message.dart';

class User {
  final String name;
  late ChatMediator mediator;

  User(this.name);

  void setMediator(ChatMediator mediator) {
    this.mediator = mediator;
  }

  void sendMessage(String msg) {
    mediator.sendMessage(msg, name);
  }

  void receiveMessage(Message message) {
    print("${message.sender} → ${name}: ${message.text}");
  }
}