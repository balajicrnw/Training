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
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.grey),
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 8, bottom: 2, left: 14),

            child: Row(
              children: [
                Row(
                  children: [
                    AppText(
                      text: "Apartment 65",
                      appTextVariant: AppTextVariant.medium,
                    ),
                    SizedBox(width: 144),

                    AppIconButton(
                      icon: Icons.arrow_outward,
                      variant: AppIconButtonVariant.transparent,
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
              left: 14,
              right: 8,
              top: 1,
              bottom: 10,
            ),
            child: Row(
              children: [
                AppText(
                  text: r"$ 36,000",
                  appTextVariant: AppTextVariant.large,
                ),
                SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: AppText(
                    text: "Sq ft",
                    appTextVariant: AppTextVariant.greytxt,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(width: 16),
              AppChip(title: "4 Rooms", appChipVariant: AppChipVariant.medium),
              SizedBox(width: 5),
              AppChip(title: "110 sqm", appChipVariant: AppChipVariant.medium),
              SizedBox(width: 5),
              AppChip(
                title: "Furnished",
                appChipVariant: AppChipVariant.medium,
              ),
              SizedBox(width: 12),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
