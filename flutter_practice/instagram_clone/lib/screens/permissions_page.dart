import 'package:instagram_clone/widgets/ui.dart';

class PermissionsPage extends StatefulWidget {
  const PermissionsPage({super.key});

  @override
  State<PermissionsPage> createState() => _PermissionsPageState();
}

class _PermissionsPageState extends State<PermissionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomAppBar.permissions(),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: AppSettingsList(
              list: [
                AppListTile(text: "Camera", trailing: "Allowed"),
                AppListTile(text: "Contacts", trailing: "Allowed"),
                AppListTile(text: "Location services", trailing: "Not allowed"),
                AppListTile(text: "Microphone", trailing: "Allowed"),
                AppListTile(text: "Notifications", trailing: "Allowed"),
              ],
              title: "Your preferences",
              divider: false,
            ),
          ),
        ],
      ),
    );
  }
}
