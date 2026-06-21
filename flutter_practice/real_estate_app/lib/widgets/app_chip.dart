import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:real_estate_app/widgets/enums.dart';

import '../ui.dart';

class AppChip extends StatelessWidget {
  final String title;
  String designation;
  final AppChipVariant appChipVariant;
  IconData? iconData;
  ImageProvider? image;

  AppChip({
    super.key,
    required this.title,
    required this.appChipVariant,
    this.iconData,
    this.image,
    this.designation = "",
  });

  @override
  Widget build(BuildContext context) {
    switch (appChipVariant) {
      case AppChipVariant.small:
        return Chip(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: AppColors.grey),
          ),
          labelPadding: const EdgeInsets.symmetric(horizontal: 1),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(iconData, size: 20),
              SizedBox(width: 2),
              Text(
                title,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );
      case AppChipVariant.medium:
        return Chip(
          padding: EdgeInsets.all(14),
          backgroundColor: Colors.white,
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
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1.5),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.navBarBackground),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: image!,
                    height: 35,
                    width: 35,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
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
      case AppChipVariant.selectedChip:
        return Chip(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          backgroundColor: const Color(0xfff7fd8e),
          side: BorderSide(
            style: BorderStyle.none,
            color: Colors.transparent,

            width: 0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      case AppChipVariant.pinChip:
        return Chip(
          side: BorderSide(color: const Color.fromARGB(55, 188, 188, 188)),
          backgroundColor: Color(0xfff7fd8e),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1.5),
          labelPadding: EdgeInsets.only(right: 10),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(image: image!, height: 30, width: 30),
              ),
              SizedBox(width: 6),
              Text(title, style: TextStyle(fontSize: 16)),
            ],
          ),
        );
      case AppChipVariant.infoChip:
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Chip(
            backgroundColor: Color.fromARGB(
              255,
              148,
              147,
              147,
            ).withOpacity(0.3),
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1.5),
            labelPadding: EdgeInsets.only(right: 10),
            label: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(image: image!, height: 30, width: 30),
                  ),
                  SizedBox(width: 6),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(fontSize: 16)),
                      Text(designation, style: TextStyle(fontSize: 10)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }
}
