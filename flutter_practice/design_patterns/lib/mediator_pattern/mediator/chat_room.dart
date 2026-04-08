import 'chat_mediator.dart';
import '../model/message.dart';
import '../model/user.dart';

class ChatRoom implements ChatMediator {
  final List<User> users = [];
  final List<Message> messages = [];

  void addUser(User user) {
    users.add(user);
  }

  @override
  void sendMessage(String msg, String sender) {
    Message message = Message(sender, msg);
    addMessage(message);

    for (var user in users) {
      if (user.name != sender) {
        user.receiveMessage(message);
      }
    }
  }

  @override
  void addMessage(Message message) {
    messages.add(message);
  }
}