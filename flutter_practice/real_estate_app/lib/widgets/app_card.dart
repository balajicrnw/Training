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
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: 320,
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            image: DecorationImage(
                              image: image,
                              fit: BoxFit.cover,
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
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
                  const SizedBox(width: 50, height: 10),
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
