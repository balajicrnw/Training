import '../ui.dart';

class AppIcon extends StatefulWidget {
  const AppIcon({
    super.key,
    required this.icons,
    this.size = 16,
    this.color = AppColors.darkBlue,
  });
  final IconData icons;
  final double? size;
  final Color? color;

  @override
  State<AppIcon> createState() => _AppIconState();
}

class _AppIconState extends State<AppIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(widget.icons, size: widget.size, color: widget.color),
    );
  }
}
