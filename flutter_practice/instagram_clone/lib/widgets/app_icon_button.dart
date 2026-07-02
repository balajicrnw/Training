import 'package:instagram_clone/widgets/ui.dart';

class AppIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool selected;
  final size;
  AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.selected = false,
    this.size = 26,
  });

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: widget.size,
      padding: EdgeInsets.zero,
      icon: Icon(
        widget.icon,
        color: widget.selected ? AppColors.white : AppColors.grey,
      ),
      onPressed: () {
        widget.onPressed();
      },
    );
  }
}
