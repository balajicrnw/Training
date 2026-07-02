import 'package:my_jio_clone/ui.dart';

class AppButton extends StatefulWidget {
  const AppButton({super.key, required this.widget});
  final Widget widget;

  factory AppButton.blue({required String text}) {
    return AppButton(
      widget: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: AppText.medium(text: text, color: AppColors.white),
      ),
    );
  }
  factory AppButton.white({required String text}) {
    return AppButton(
      widget: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
            side: BorderSide(color: AppColors.grey),
          ),
        ),
        child: AppText.medium(
          text: text,
          color: AppColors.darkBlue,
          isBold: true,
        ),
      ),
    );
  }

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return widget.widget;
  }
}
