import 'package:instagram_clone/widgets/ui.dart';

class AppText extends StatelessWidget {
  final String text;
  const AppText({super.key, required this.text, required this.style});

  final TextStyle style;

  factory AppText.title({required String text}) {
    return AppText(
      text: text,
      style: GoogleFonts.pacifico(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: AppColors.white,
      ),
    );
  }

  factory AppText.tiny({required String text}) {
    return AppText(
      text: text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w200,
        color: AppColors.white,
      ),
    );
  }

  factory AppText.tinyGrey({required String text}) {
    return AppText(
      text: text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w200,
        color: AppColors.grey,
      ),
    );
  }

  factory AppText.tinyBlue({required String text}) {
    return AppText(
      text: text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w200,
        color: AppColors.blue,
      ),
    );
  }

  factory AppText.large({required String text}) {
    return AppText(
      text: text,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
    );
  }

  factory AppText.extraLarge({required String text}) {
    return AppText(
      text: text,
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
    );
  }

  factory AppText.small({required String text}) {
    return AppText(
      text: text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: AppColors.white,
      ),
    );
  }

  factory AppText.medium({required String text}) {
    return AppText(
      text: text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: AppColors.white,
      ),
    );
  }

  factory AppText.grey({required String text}) {
    return AppText(
      text: text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: AppColors.grey,
      ),
    );
  }

  factory AppText.blue({required String text}) {
    return AppText(
      text: text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: AppColors.blue,
      ),
    );
  }

  factory AppText.red({required String text}) {
    return AppText(
      text: text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: AppColors.red,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Text(text, style: style);
  }
}
