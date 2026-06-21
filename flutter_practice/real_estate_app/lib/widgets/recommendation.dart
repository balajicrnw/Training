import 'package:flutter/material.dart';
import 'package:real_estate_app/widgets/app_card.dart';

import '../ui.dart';

class Recommendation extends StatefulWidget {
  const Recommendation({super.key});

  @override
  State<Recommendation> createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              AppText(
                text: "Recomment For You",
                appTextVariant: AppTextVariant.medium,
              ),
              SizedBox(height: 8),
            ],
          ),
        ),

        AppCard(image: AssetImage("lib/assets/villa1.jpeg")),
        SizedBox(height: 2),
        AppCard(image: AssetImage("lib/assets/villa1.jpeg")),
        SizedBox(height: 2),
        AppCard(image: AssetImage("lib/assets/villa1.jpeg")),
        SizedBox(height: 2),
        AppCard(image: AssetImage("lib/assets/villa1.jpeg")),
        SizedBox(height: 2),
      ],
    );
  }
}
