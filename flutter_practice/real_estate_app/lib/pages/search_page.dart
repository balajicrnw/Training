import 'package:flutter/material.dart';
import 'package:real_estate_app/ui.dart';
import 'package:real_estate_app/widgets/recommendation.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/map.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 16,
          right: 16,
          child: Row(
            children: [
              Expanded(child: AppSearchBar()),
              AppIconButton(icon: Icons.tune),
            ],
          ),
        ),
        Positioned(
          top: 200,
          left: 50,
          right: 50,
          child: Row(
            children: [
              AppChip(
                title: "House Name",
                appChipVariant: AppChipVariant.pinChip,
                image: AssetImage("lib/assets/villa3.jpg"),
              ),
            ],
          ),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.15,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xFFfdffe5), Colors.white],
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 8),
                    Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 12),

                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Recommendation(),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
