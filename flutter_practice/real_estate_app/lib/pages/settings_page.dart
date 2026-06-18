import 'package:flutter/material.dart';
import 'package:real_estate_app/ui.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 450,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: "Settings",
                    appTextVariant: AppTextVariant.large,
                  ),
                  AppText(
                    text: "Manage your account",
                    appTextVariant: AppTextVariant.medium,
                  ),
                  SizedBox(height: 5),
                  AppSearchBar(),
                  SizedBox(height: 24),
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          spreadRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              radius: 24,
                              child: Icon(Icons.person),
                            ),
                            title: Text("Batman"),
                            subtitle: Text("batman123@gmail.com"),
                            trailing: Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                            ),
                            onTap: () {},
                          ),
                          Divider(height: 24, thickness: 0.5),
                          ListTile(
                            leading: Icon(Icons.mail),
                            title: Text("batman_47"),
                            trailing: Icon(Icons.qr_code, color: Colors.grey),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          spreadRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.lock_person),
                            title: Text("Security"),
                            trailing: Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                            ),
                            onTap: () {},
                          ),
                          Divider(height: 24, thickness: 0.5),
                          ListTile(
                            leading: Icon(Icons.notifications),
                            title: Text("Notifications"),
                            trailing: Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                            ),
                            onTap: () {},
                          ),
                          Divider(height: 24, thickness: 0.5),
                          ListTile(
                            leading: Icon(Icons.translate),
                            title: Text("Language"),
                            trailing: Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          spreadRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.face),
                            title: Text("UseFaceID"),
                            trailing: Switch(
                              value: true,
                              activeTrackColor: Color(0xfff7fd8e),
                              onChanged: (value) {},
                            ),
                            onTap: () {},
                          ),
                          Divider(height: 24, thickness: 0.5),
                          ListTile(
                            leading: Icon(Icons.dark_mode),
                            title: Text("Dark Mode"),
                            trailing: Switch(
                              value: false,
                              onChanged: (value) {},
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          spreadRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.logout),
                            title: Text(
                              "Logout",
                              style: TextStyle(color: Colors.red),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
