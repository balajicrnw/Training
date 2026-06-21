import 'package:flutter/material.dart';
import 'package:real_estate_app/ui.dart';
import 'package:real_estate_app/widgets/app_chip.dart';

class AppCard extends StatelessWidget {
  final ImageProvider image;

  const AppCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: AppColors.white,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: AppColors.grey),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: 312,
                  height: 154,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 1,
                            top: 1,
                            bottom: 1,
                            right: 1,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              image: DecorationImage(
                                image: image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 3,
                          left: 3,
                          child: AppChip(
                            title: "Best Deal",
                            appChipVariant: AppChipVariant.medium,
                          ),
                        ),
                        Positioned(
                          right: 3,
                          top: 3,
                          child: AppIconButton(
                            icon: Icons.favorite_border_outlined,
                            variant: AppIconButtonVariant.background,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              child: Row(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Column(
                    children: [
                      AppText(
                        text: "Aaradhya Homes",
                        appTextVariant: AppTextVariant.medium,
                      ),
                    ],
                  ),
                  const SizedBox(width: 40, height: 10),
                  AppChip(
                    title: r'$440,000',
                    appChipVariant: AppChipVariant.priceChip,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Wrap(
                spacing: 2,
                runSpacing: 2,
                children: [
                  AppChip(
                    title: "Ananda",
                    appChipVariant: AppChipVariant.small,
                    iconData: Icons.location_on_outlined,
                  ),
                  AppChip(
                    title: "4.5",
                    appChipVariant: AppChipVariant.small,
                    iconData: Icons.star_outline,
                  ),
                  AppChip(
                    title: "4 Beds",
                    appChipVariant: AppChipVariant.small,
                    iconData: Icons.bed_outlined,
                  ),
                  AppChip(
                    title: "2 Baths",
                    appChipVariant: AppChipVariant.small,
                    iconData: Icons.bathtub_outlined,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
