import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:real_estate_app/ui.dart';

class BookingPage extends StatefulWidget {
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                SizedBox(width: 10),
                AppIconButton(
                  icon: Icons.arrow_back_ios_new,
                  variant: AppIconButtonVariant.background,
                ),
                Spacer(),
                AppText(
                  text: "Book Summary",
                  appTextVariant: AppTextVariant.medium,
                ),
                Spacer(),
                AppIconButton(
                  icon: Icons.share,
                  variant: AppIconButtonVariant.background,
                ),
                SizedBox(width: 10),
              ],
            ),
          ),

          Center(
            child: SizedBox(
              width: 320,
              height: 220,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: 320,
                      height: 220,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          "lib/assets/villa1.jpeg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          height: 110,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.black.withOpacity(0.35),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.15),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Premium Stay",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkYellow,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "Azure Skyline Loft",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4, width: 0),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: AppColors.darkYellow,
                                      size: 24,
                                    ),
                                    Text(
                                      "Manhattan, New York",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(width: 320, height: 300, child: AppCalander()),
          SizedBox(height: 10),
          AppButton(text: "Confirm Booking"),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
