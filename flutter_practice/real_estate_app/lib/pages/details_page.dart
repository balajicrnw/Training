import 'package:flutter/material.dart';
import 'package:real_estate_app/widgets/app_details_card.dart';
import 'package:real_estate_app/widgets/app_dropdown.dart';
import 'package:real_estate_app/widgets/app_icon_button.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.asset("lib/assets/villa1.jpeg"),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(height: 50, width: 250, child: AppDropdown()),
            ),
            AppIconButton(icon: Icons.add_location),
            SizedBox(width: 5),
            AppIconButton(icon: Icons.arrow_outward),
          ],
        ),
        SizedBox(height: 5),
        SizedBox(width: 330, child: AppDetailsCard()),
      ],
    );
  }
}
