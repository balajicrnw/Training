import 'package:flutter/material.dart';
import 'package:real_estate_app/widgets/enums.dart';

class AppChip extends StatelessWidget {
  final String title;
  final AppChipVariant appChipVariant;
  IconData? iconData;

  AppChip({
    super.key,
    required this.title,
    required this.appChipVariant,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    switch (appChipVariant) {
      case AppChipVariant.small:
        return Chip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          labelPadding: const EdgeInsets.symmetric(horizontal: 4),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(iconData, size: 20),
              SizedBox(width: 4),
              Text(title, style: TextStyle(fontSize: 10)),
            ],
          ),
        );
      case AppChipVariant.medium:
        return Chip(
          padding: EdgeInsets.all(14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      case AppChipVariant.large:
        return Chip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(iconData, size: 20),
              Text(title, style: TextStyle(fontSize: 15)),
            ],
          ),
        );
      case AppChipVariant.priceChip:
        return Chip(
          backgroundColor: Color(0xFFfdffe5),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
    }
  }
}
