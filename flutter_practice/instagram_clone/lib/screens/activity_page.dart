import 'package:instagram_clone/widgets/ui.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar.activity(),
            SizedBox(height: 24),
            Column(
              children: [
                AppText.large(text: "One place to manage"),
                AppText.large(text: "your activity"),
                SizedBox(height: 8),
                AppText.grey(text: "View and manage your interactions,"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText.grey(text: "content and activity."),
                    AppText.blue(text: "Learn more"),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            AppSettingsList(
              list: [
                AppListTile(
                  leading: Icons.favorite_border_rounded,
                  text: "Likes",
                ),
                AppListTile(
                  leading: Icons.chat_bubble_outline,
                  text: "Comments",
                ),
                AppListTile(leading: Icons.repeat, text: "Reposts"),
                AppListTile(leading: Icons.person_pin_outlined, text: "Tags"),
                AppListTile(leading: Icons.gif, text: "Sticker responses"),
                AppListTile(leading: Icons.sell, text: "Reviews"),
              ],

              title: "Interactions",
            ),

            AppSettingsList(
              list: [
                AppListTile(leading: Icons.delete, text: "Recently deleted"),
                AppListTile(leading: Icons.alarm, text: "Archived"),
              ],

              title: "Removed and archived content",
            ),
            AppSettingsList(
              list: [
                AppListTile(
                  leading: Icons.favorite_border_rounded,
                  text: "Likes",
                ),
                AppListTile(
                  leading: Icons.chat_bubble_outline,
                  text: "Comments",
                ),
                AppListTile(leading: Icons.repeat, text: "Reposts"),
                AppListTile(leading: Icons.person_pin_outlined, text: "Tags"),
                AppListTile(leading: Icons.gif, text: "Sticker responses"),
                AppListTile(leading: Icons.sell, text: "Reviews"),
              ],

              title: "Interactions",
            ),

            AppSettingsList(
              list: [
                AppListTile(leading: Icons.delete, text: "Recently deleted"),
                AppListTile(leading: Icons.alarm, text: "Archived"),
              ],

              title: "Removed and archived content",
            ),
          ],
        ),
      ),
    );
  }
}
