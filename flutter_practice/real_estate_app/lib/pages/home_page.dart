import 'package:flutter/material.dart';
import 'package:real_estate_app/ui.dart';
import 'package:real_estate_app/widgets/app_bottom_navigator.dart';
import 'package:real_estate_app/widgets/recommendation.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      AppIconButton(icon: Icons.menu),
                      Spacer(),
                      Align(child: AppIconButton(icon: Icons.notifications)),
                      SizedBox(width: 10),
                      AppIconButton(icon: Icons.person),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      AppText(
                        text: "Made for You",
                        appTextVariant: AppTextVariant.large,
                      ),

                      AppText(
                        text: "Explore Properties",
                        appTextVariant: AppTextVariant.large,
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 50,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        AppChip(
                          title: "All",
                          appChipVariant: AppChipVariant.selectedChip,
                        ),
                        SizedBox(width: 10),
                        AppChip(
                          title: "House",
                          appChipVariant: AppChipVariant.large,
                          iconData: Icons.star,
                        ),
                        SizedBox(width: 10),
                        AppChip(
                          title: "Apartment",
                          appChipVariant: AppChipVariant.large,
                          iconData: Icons.bed,
                        ),
                        SizedBox(width: 10),
                        AppChip(
                          title: "2 Baths",
                          appChipVariant: AppChipVariant.large,
                          iconData: Icons.bathroom,
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ),
                ),
                Recommendation(),
              ],
            ),
          ],
        ),

        Positioned(
          bottom: 10,
          right: 100,
          child: AppBottomNavigator(selected: 1),
        ),
      ],
    );
  }
}
