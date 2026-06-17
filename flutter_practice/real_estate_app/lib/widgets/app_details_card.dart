import 'package:flutter/material.dart';
import 'package:real_estate_app/ui.dart';
import 'package:real_estate_app/widgets/app_text.dart';
import 'package:real_estate_app/widgets/enums.dart';

class AppDetailsCard extends StatefulWidget {
  const AppDetailsCard({super.key});

  @override
  State<AppDetailsCard> createState() => _AppDetailsCardState();
}

class _AppDetailsCardState extends State<AppDetailsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color.fromARGB(255, 209, 209, 209)),
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),

            child: Row(
              children: [
                Row(
                  children: [
                    AppText(
                      text: "Apartment 65",
                      appTextVariant: AppTextVariant.medium,
                    ),
                    SizedBox(width: 146),

                    AppIconButton(icon: Icons.arrow_outward),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppText(
              text: r"$ 36,000",
              appTextVariant: AppTextVariant.large,
            ),
          ),
          Row(
            children: [
              SizedBox(width: 10),
              AppChip(title: "4 Rooms", appChipVariant: AppChipVariant.medium),
              SizedBox(width: 10),
              AppChip(title: "110 sqm", appChipVariant: AppChipVariant.medium),
              SizedBox(width: 10),
              AppChip(
                title: "Furnished",
                appChipVariant: AppChipVariant.medium,
              ),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
