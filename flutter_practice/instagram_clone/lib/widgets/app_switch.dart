import 'package:instagram_clone/widgets/ui.dart';

class AppSwitch extends StatefulWidget {
  const AppSwitch({super.key});

  @override
  State<AppSwitch> createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _value,
      onChanged: (v) {},
      inactiveTrackColor: AppColors.transparent,
    );
  }
}
