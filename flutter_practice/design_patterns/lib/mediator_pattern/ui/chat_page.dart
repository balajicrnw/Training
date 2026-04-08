import 'package:flutter/material.dart';
import '../mediator/chat_room.dart';
import '../model/user.dart';
import '../model/message.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatRoom chatRoom;

  late User balaji;
  late User bob;
  late User john;

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    chatRoom = ChatRoom();

    balaji = User("Balaji")..setMediator(chatRoom);
    bob = User("Bob")..setMediator(chatRoom);
    john = User("John")..setMediator(chatRoom);

    chatRoom.addUser(balaji);
    chatRoom.addUser(bob);
    chatRoom.addUser(john);
  }

  void sendMessage(User user) {
    if (controller.text.isEmpty) return;

    setState(() {
      user.sendMessage(controller.text);
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mediator Pattern Chat")),
      body: Column(
        children: [
          // CHAT AREA (REAL UI)
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: chatRoom.messages.length,
              itemBuilder: (context, index) {
                Message msg = chatRoom.messages[index];

                return Align(
                  alignment: msg.sender == "Balaji"
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: msg.sender == "Balaji"
                          ? Colors.blue[200]
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("${msg.sender}: ${msg.text}"),
                  ),
                );
              },
            ),
          ),

          // INPUT BOX
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Type message...",
              ),
            ),
          ),

          // BUTTON ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => sendMessage(balaji),
                child: Text("Balaji"),
              ),
              ElevatedButton(
                onPressed: () => sendMessage(bob),
                child: Text("Bob"),
              ),
              ElevatedButton(
                onPressed: () => sendMessage(john),
                child: Text("John"),
              ),
            ],
          ),

          SizedBox(height: 10),
        ],
      ),
    );
  }
}