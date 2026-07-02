import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/widgets/app_button.dart';
import 'package:instagram_clone/widgets/app_profile.dart';
import 'package:instagram_clone/widgets/app_text.dart';

class AppProfileView extends StatefulWidget {
  const AppProfileView({super.key, required this.user});
  final User user;
  @override
  State<AppProfileView> createState() => _AppProfileViewState();
}

class _AppProfileViewState extends State<AppProfileView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              AppProfile(user: widget.user, width: 80, height: 80),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.small(text: widget.user.userName),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      AppStats(text: "posts", value: "12"),
                      SizedBox(width: 12),
                      AppStats(
                        text: "followers",
                        value: widget.user.followers.toString(),
                      ),
                      SizedBox(width: 12),
                      AppStats(
                        text: "following",
                        value: widget.user.following.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8),

        Row(
          children: [
            SizedBox(width: 16),
            AppText.small(text: "Time is Precious Dont waste it"),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: AppButton.outlined(
                  text: "Edit Profile",
                  onPressed: () {},
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: AppButton.outlined(
                  text: "Share Profile",
                  onPressed: () {},
                ),
              ),
              SizedBox(width: 8),
              AppButton.icon(icon: Icons.person_add, onPressed: () {}),
            ],
          ),
        ),
      ],
    );
  }
}

class AppStats extends StatelessWidget {
  final String text;
  final String value;
  const AppStats({super.key, required this.text, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.small(text: value),
          AppText.small(text: text),
        ],
      ),
    );
  }
}
