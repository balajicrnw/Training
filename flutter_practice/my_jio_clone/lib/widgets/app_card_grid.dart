import 'package:flutter/material.dart';

import '../ui.dart';

class AppCardGrid extends StatefulWidget {
  const AppCardGrid({super.key});

  @override
  State<AppCardGrid> createState() => _AppCardGridState();
}

class _AppCardGridState extends State<AppCardGrid> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightBlue,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 16.0,
            left: 16,
            right: 16,
            top: 8,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: AppCard.trailingImage(
                      title: "Mobile",
                      icon: Icons.sim_card_rounded,
                      subtitle: "True 5g speeds",
                    ),
                  ),
                  SizedBox(width: 8),

                  Expanded(
                    child: AppCard.trailingImage(
                      title: "Home",
                      icon: Icons.home,
                      subtitle: "Fiber & AirFiber",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: AppCard.topImage(
                      title: "Finance",
                      icon: Icons.attach_money_rounded,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: AppCard.topImage(
                      title: "JioTunes",
                      icon: Icons.music_note,
                    ),
                  ),
                  SizedBox(width: 8),

                  Expanded(
                    child: AppCard.topImage(
                      title: "Shopping",
                      icon: Icons.shopping_cart,
                    ),
                  ),
                  SizedBox(width: 8),

                  Expanded(
                    child: AppCard.topImage(
                      title: "AiCloud",
                      icon: Icons.cloud,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: AppCard.topImage(
                      title: "Finance",
                      icon: Icons.attach_money_rounded,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: AppCard.topImage(
                      title: "JioTunes",
                      icon: Icons.music_note,
                    ),
                  ),
                  SizedBox(width: 8),

                  Expanded(
                    child: AppCard.topImage(
                      title: "Shopping",
                      icon: Icons.shopping_cart,
                    ),
                  ),
                  SizedBox(width: 8),

                  Expanded(
                    child: AppCard.topImage(
                      title: "AiCloud",
                      icon: Icons.cloud,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
