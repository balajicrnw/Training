import 'package:instagram_clone/widgets/ui.dart';

class AppList extends StatelessWidget {
  const AppList({super.key, required this.user});
  final List<User> user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.small(text: "Messages"),
              AppText.blue(text: "Requests"),
            ],
          ),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: user.length,
          itemBuilder: (context, index) {
            return AppListCard(user: user[index]);
          },
        ),
      ],
    );
  }
}

class AppListCard extends StatelessWidget {
  final User user;

  const AppListCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: AppProfile(user: user, height: 48, width: 48),
        title: AppText.medium(text: user.userName),
        subtitle: AppText.grey(text: "Active 7h ago"),
      ),
    );
  }
}
