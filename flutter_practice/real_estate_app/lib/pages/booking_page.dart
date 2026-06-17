import 'package:flutter/material.dart';
import 'package:real_estate_app/widgets/app_calander.dart';
import 'package:real_estate_app/widgets/app_icon_button.dart';
import 'package:real_estate_app/widgets/app_text.dart';
import 'package:real_estate_app/widgets/enums.dart';

class BookingPage extends StatefulWidget {
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              AppIconButton(icon: Icons.arrow_back_ios_new),
              SizedBox(width: 50),
              AppText(
                text: "Book Summary",
                appTextVariant: AppTextVariant.medium,
              ),
              SizedBox(width: 48),
              AppIconButton(icon: Icons.share),
            ],
          ),
        ),
        Stack(
          children: [
            Container(
              width: 320,
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset("lib/assets/villa1.jpeg", fit: BoxFit.cover),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(width: 320, height: 300, child: AppCalander()),
      ],
    );
  }
}
