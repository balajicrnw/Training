import 'package:flutter/material.dart';
import 'package:real_estate_app/ui.dart';
import 'package:real_estate_app/widgets/app_area.dart';

class AppCarousel extends StatefulWidget {
  @override
  State<AppCarousel> createState() => _AppCarouselState();
}

class _AppCarouselState extends State<AppCarousel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 200,
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Image.asset("lib/assets/villa3.jpg", fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Row(
              children: [
                AppIconButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  variant: AppIconButtonVariant.transparentBorder,
                ),
                Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 14),
                    AppText(
                      text: "Aradhaya Homes",
                      appTextVariant: AppTextVariant.medium,
                    ),
                    SizedBox(height: 5),
                    AppText(
                      text: "Avadi, Chennai-600071",
                      appTextVariant: AppTextVariant.middle,
                    ),
                    SizedBox(height: 8),
                    AppTrailing(),
                  ],
                ),
                Spacer(),
                AppIconButton(
                  icon: Icons.arrow_forward_ios,
                  variant: AppIconButtonVariant.transparentBorder,
                ),
              ],
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Row(
              children: [
                AppChip(
                  title: "Batman",
                  designation: "Owner",
                  appChipVariant: AppChipVariant.infoChip,
                  image: AssetImage("lib/assets/batman.jpg"),
                ),
              ],
            ),
          ),
          Positioned(bottom: 20, right: 20, child: AppArea()),
        ],
      ),
    );
  }
}
