import 'package:instagram_clone/widgets/ui.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          CustomAppBar.settings(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          AppSearch(text: "Search", borderSide: 8),
          Stack(
            children: [
              Positioned(
                right: 24,
                top: 6,
                child: AppText.medium(text: "Meta"),
              ),
              AppSettingsList(
                list: [
                  AppListTile(
                    leading: Icons.person_2_outlined,
                    text: "Accounts Center",
                    subtitle:
                        "Password,security,personal details,connected experiences,ad preferences",
                  ),
                ],

                title: "Your account",
              ),
            ],
          ),

          AppSettingsList(
            list: [
              AppListTile(
                leading: Icons.bookmark_outline,
                text: "Saved",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SavedPage()),
                  );
                },
              ),
              AppListTile(leading: Icons.access_time_outlined, text: "Archive"),
              AppListTile(
                leading: Icons.auto_graph_outlined,
                text: "Your activity",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ActivityPage(),
                    ),
                  );
                },
              ),
              AppListTile(
                leading: Icons.notifications_outlined,
                text: "Notifications",
              ),
              AppListTile(
                leading: Icons.access_alarm,
                text: "Time management",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TimeManagementScreen(),
                    ),
                  );
                },
              ),
              AppListTile(
                leading: Icons.tablet_android_rounded,
                text: "Instagram for tablets",
              ),
            ],

            title: "How you use Instagram",
          ),

          AppSettingsList(
            list: [
              AppListTile(leading: Icons.bookmark_outline, text: "Saved"),
              AppListTile(leading: Icons.access_time_outlined, text: "Archive"),
              AppListTile(
                leading: Icons.auto_graph_outlined,
                text: "Your activity",
              ),
              AppListTile(
                leading: Icons.notifications_outlined,
                text: "Notifications",
              ),
              AppListTile(leading: Icons.access_alarm, text: "Time management"),
              AppListTile(
                leading: Icons.tablet_android_rounded,
                text: "Instagram for tablets",
              ),
            ],

            title: "How you use Instagram",
          ),

          AppSettingsList(
            list: [
              AppListTile(leading: Icons.bookmark_outline, text: "Saved"),
              AppListTile(leading: Icons.access_time_outlined, text: "Archive"),
              AppListTile(
                leading: Icons.auto_graph_outlined,
                text: "Your activity",
              ),
              AppListTile(
                leading: Icons.notifications_outlined,
                text: "Notifications",
              ),
              AppListTile(leading: Icons.access_alarm, text: "Time management"),
              AppListTile(
                leading: Icons.tablet_android_rounded,
                text: "Instagram for tablets",
              ),
            ],

            title: "How you use Instagram",
          ),
          AppSettingsList(
            list: [
              AppListTile(leading: Icons.bookmark_outline, text: "Saved"),
              AppListTile(leading: Icons.access_time_outlined, text: "Archive"),
              AppListTile(
                leading: Icons.auto_graph_outlined,
                text: "Your activity",
              ),
              AppListTile(
                leading: Icons.notifications_outlined,
                text: "Notifications",
              ),
              AppListTile(leading: Icons.access_alarm, text: "Time management"),
              AppListTile(
                leading: Icons.tablet_android_rounded,
                text: "Instagram for tablets",
              ),
            ],

            title: "How you use Instagram",
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.grey(text: "Login"),
                SizedBox(height: 24),
                AppText.blue(text: "Add account"),
                SizedBox(height: 24),
                AppText.red(text: "Log out"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
