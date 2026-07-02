import 'package:instagram_clone/widgets/ui.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustomAppBar.message(),
        AppSearch(text: "Search or ask Meta AI"),
        AppScroll(users: mockData),
        AppList(user: mockData),
      ],
    );
  }
}
