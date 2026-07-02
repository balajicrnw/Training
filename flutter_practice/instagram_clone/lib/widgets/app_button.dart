import 'package:instagram_clone/widgets/ui.dart';

class AppButton extends StatefulWidget {
  final String? text;
  final VoidCallback onPressed;
  final ButtonStyle? style;
  final IconData? icon;

  AppButton({
    super.key,
    this.text,
    this.icon,
    required this.onPressed,
    this.style,
  });

  factory AppButton.outlined({
    required String text,
    required VoidCallback onPressed,
  }) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.buttonGrey,
        foregroundColor: AppColors.white,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  factory AppButton.transparent({
    required String text,
    required VoidCallback onPressed,
  }) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(color: AppColors.white),
      ),
    );
  }

  factory AppButton.icon({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return AppButton(
      icon: icon,
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonGrey,
        elevation: 0,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide.none,
      ),
    );
  }
  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: widget.style,
      child: widget.icon != null
          ? Icon(widget.icon, color: AppColors.white)
          : Text(widget.text ?? "", style: TextStyle(color: AppColors.white)),
    );
  }
}
