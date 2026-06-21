import 'package:flutter/material.dart';
import 'package:real_estate_app/ui.dart';
import 'package:real_estate_app/widgets/app_carousel.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AppCarousel(),
        const SizedBox(height: 12),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 26, right: 18, bottom: 12),
              child: Row(
                children: [
                  SizedBox(height: 46, width: 230, child: AppDropdown()),
                  SizedBox(width: 8),
                  AppIconButton(
                    icon: Icons.add_location,
                    variant: AppIconButtonVariant.transparent,
                  ),
                  SizedBox(width: 8),
                  AppIconButton(
                    icon: Icons.arrow_outward,
                    variant: AppIconButtonVariant.transparent,
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(height: 5),
            SizedBox(width: 330, child: AppDetailsCard()),
            SizedBox(height: 5),
            SizedBox(width: 330, child: AppDetailsCard()),
            SizedBox(height: 5),
            SizedBox(width: 330, child: AppDetailsCard()),
          ],
        ),
      ],
    );
  }
}
