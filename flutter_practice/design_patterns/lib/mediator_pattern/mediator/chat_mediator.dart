import '../model/message.dart';

abstract class ChatMediator {
  void sendMessage(String msg, String sender);
  void addMessage(Message message);
}