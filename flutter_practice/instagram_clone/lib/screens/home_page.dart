import 'package:instagram_clone/widgets/ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustomAppBar.home(),
        AppScroll(users: mockData),
        AppPost.home(posts: posts),
      ],
    );
  }
}
