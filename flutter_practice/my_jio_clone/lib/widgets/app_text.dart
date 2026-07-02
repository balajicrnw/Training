import '../ui.dart';

class AppText extends StatefulWidget {
  final String text;
  final TextStyle style;
  const AppText({super.key, required this.text, required this.style});

  factory AppText.tiny({
    required String text,
    Color color = AppColors.black,
    bool isBold = false,
  }) {
    return AppText(
      text: text,
      style: TextStyle(
        color: color,
        fontSize: 12,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  factory AppText.small({
    required String text,
    Color color = AppColors.black,
    bool isBold = false,
  }) {
    return AppText(
      text: text,
      style: TextStyle(
        color: color,
        fontSize: 12,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  factory AppText.medium({
    required String text,
    Color color = AppColors.black,
    bool isBold = false,
  }) {
    return AppText(
      text: text,
      style: TextStyle(
        color: color,
        fontSize: 16,
        fontWeight: isBold ? FontWeight.w500 : FontWeight.normal,
      ),
    );
  }

  factory AppText.large({
    required String text,
    Color color = AppColors.black,
    bool isBold = false,
  }) {
    return AppText(
      text: text,
      style: TextStyle(
        color: color,
        fontSize: 24,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  factory AppText.extraLarge({
    required String text,
    Color color = AppColors.black,
    bool isBold = false,
  }) {
    return AppText(
      text: text,
      style: TextStyle(
        color: color,
        fontSize: 32,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  @override
  State<AppText> createState() => _AppTextState();
}

class _AppTextState extends State<AppText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: widget.style,
      softWrap: true,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}
