import 'package:flutter/material.dart';
import 'package:real_estate_app/ui.dart';
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
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
                  child: Row(
                    children: [
                      AppIconButton(icon: Icons.menu),
                      Spacer(),
                      Align(
                        child: AppIconButton(
                          icon: Icons.notifications_outlined,
                        ),
                      ),
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
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: AppText(
                              text: "Made for You Explore Properties",
                              appTextVariant: AppTextVariant.large,
                            ),
                            flex: 3,
                          ),
                          Expanded(child: AppIconButton(icon: Icons.search)),
                        ],
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
                          image: AssetImage("lib/assets/villa1.jpeg"),
                        ),
                        SizedBox(width: 10),
                        AppChip(
                          title: "Apartment",
                          appChipVariant: AppChipVariant.large,
                          image: AssetImage("lib/assets/villa1.jpeg"),
                        ),
                        SizedBox(width: 10),
                        AppChip(
                          title: "2 Baths",
                          appChipVariant: AppChipVariant.large,
                          image: AssetImage("lib/assets/villa1.jpeg"),
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
      ],
    );
  }
}
