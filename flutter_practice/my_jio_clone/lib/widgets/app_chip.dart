import '../ui.dart';

class AppChip extends StatefulWidget {
  final String text;

  const AppChip({super.key, required this.text});

  @override
  State<AppChip> createState() => _AppChipState();
}

class _AppChipState extends State<AppChip> {
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: AppText.medium(text: widget.text),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
        side: BorderSide(color: AppColors.black),
      ),
    );
  }
}
