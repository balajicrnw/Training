import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'enums.dart';

class AppText extends StatelessWidget {
  final String text;
  final AppTextVariant appTextVariant;

  const AppText({super.key, required this.text, required this.appTextVariant});

  @override
  Widget build(BuildContext context) {
    switch (appTextVariant) {
      case AppTextVariant.small:
        return Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: const Color.fromARGB(255, 56, 55, 55),
            fontWeight: FontWeight.w500,
          ),
        );
      case AppTextVariant.medium:
        return Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 17,
            color: const Color.fromARGB(255, 40, 39, 39),
            fontWeight: FontWeight.w500,
          ),
        );
      case AppTextVariant.large:
        return Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 26,
            color: const Color.fromARGB(255, 34, 34, 34),
            fontWeight: FontWeight.w500,
            height: 1.3,
          ),
        );
      case AppTextVariant.greytxt:
        return Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            height: 0.8,
          ),
        );
      case AppTextVariant.middle:
        return Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: const Color.fromARGB(255, 56, 55, 55),
            fontWeight: FontWeight.bold,
            height: 0.8,
          ),
        );
    }
  }
}
