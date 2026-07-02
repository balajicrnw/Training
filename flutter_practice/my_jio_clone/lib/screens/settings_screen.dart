import 'package:flutter/material.dart';
import 'package:my_jio_clone/ui.dart';
import 'package:my_jio_clone/widgets/app_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          CustomAppBar.settings(),
          SizedBox(height: 24),
          AppListTile(
            title: "Batman",
            subtitle: "9876543210 | Prepaid 5G",
            leading: CircleAvatar(child: Icon(Icons.person)),
          ),
          Divider(color: const Color.fromARGB(234, 236, 236, 236)),
          SizedBox(height: 8),
          AppList(
            widgets: [
              AppListTile(
                title: "Mobile settings",
                subtitle: "9876543210 | Batman",
                leading: Icon(Icons.tablet_android_rounded),
                trailing: AppText.medium(
                  text: "Switch Account",
                  color: AppColors.darkBlue,
                  isBold: true,
                ),
              ),

              AppListTile(
                title: "Other mini app settings",
                leading: Icon(Icons.settings),
              ),
              AppListTile(
                title: "Linked account",
                leading: Icon(Icons.person_add_sharp),
              ),
              AppListTile(
                title: "App theme",
                leading: Icon(Icons.copy_rounded),
              ),
            ],
          ),
          SizedBox(height: 16),
          AppList(
            title: "More from Jio",
            widgets: [
              SizedBox(height: 8),
              AppListTile(title: "JioTunes", leading: Icon(Icons.music_note)),
              AppListTile(title: "Coupons", leading: Icon(Icons.discount)),
              AppListTile(title: "Get Jio SIM", leading: Icon(Icons.sim_card)),
              AppListTile(title: "Get Jio Home", leading: Icon(Icons.home)),
            ],
          ),
          SizedBox(height: 16),
          AppList(
            title: "Help & Support",
            widgets: [
              SizedBox(height: 8),
              AppListTile(
                title: "JioCare: Help & support",
                leading: Icon(Icons.person_4),
              ),
              AppListTile(
                title: "About MyJio",
                leading: Icon(Icons.phone_android),
              ),
            ],
          ),
          SizedBox(height: 8),
          AppButton.white(text: "Logout"),
        ],
      ),
    );
  }
}
