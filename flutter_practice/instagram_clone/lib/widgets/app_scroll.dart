import 'package:instagram_clone/widgets/ui.dart';

class AppScroll extends StatefulWidget {
  final List<User> users;
  const AppScroll({super.key, required this.users});

  @override
  State<AppScroll> createState() => _AppScrollState();
}

class _AppScrollState extends State<AppScroll> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 12),
            ...widget.users.map((e) => ScrollTile(user: e)).toList(),
          ],
        ),
      ),
    );
  }
}

class ScrollTile extends StatelessWidget {
  final User user;
  const ScrollTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          AppProfile(user: user, height: 72, width: 72),
          AppText.small(text: user.userName),
        ],
      ),
    );
  }
}
