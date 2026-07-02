import 'package:instagram_clone/widgets/ui.dart';

class AppChip extends StatefulWidget {
  const AppChip({super.key, required this.text});
  final String text;

  @override
  State<AppChip> createState() => _AppChipState();
}

class _AppChipState extends State<AppChip> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            right: 12.0,
            left: 12.0,
            top: 8,
            bottom: 8,
          ),
          child: AppText.tiny(text: widget.text),
        ),
      ),
    );
  }
}
