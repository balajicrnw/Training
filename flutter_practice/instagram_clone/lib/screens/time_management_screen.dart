import 'package:instagram_clone/widgets/ui.dart';

class TimeManagementScreen extends StatefulWidget {
  const TimeManagementScreen({super.key});

  @override
  State<TimeManagementScreen> createState() => _TimeManagementScreenState();
}

class _TimeManagementScreenState extends State<TimeManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar.timeManagement(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.extraLarge(text: "2h 40m"),
                AppText.medium(text: "Daily average"),
                AppText.tinyGrey(
                  text:
                      "Average time that you spent per day using Instagram on this device in the last week. Learn more about",
                ),
                AppText.tinyBlue(text: "balancing your time online"),
              ],
            ),
          ),

          AppChart(),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Divider(color: AppColors.divider, thickness: 5),
          ),

          AppSettingsList(
            list: [
              AppListTile(text: "Daily limit", trailing: "Off"),
              AppListTile(text: "Sleep mode", trailing: "Off"),
            ],
            title: "Manage your time",
            divider: false,
          ),

          Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
