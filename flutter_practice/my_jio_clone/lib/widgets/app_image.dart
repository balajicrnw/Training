import 'package:flutter/material.dart';

class AppImage extends StatefulWidget {
  const AppImage({super.key, required this.widget});
  final Widget widget;

  @override
  State<AppImage> createState() => _AppImageState();

  factory AppImage.scroller({
    required String imageUrl,
    required double height,
    required double width,
  }) {
    return AppImage(
      widget: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          imageUrl,
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  factory AppImage.banner({required String imageUrl}) {
    return AppImage(
      widget: Container(
        height: 130,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

class _AppImageState extends State<AppImage> {
  @override
  Widget build(BuildContext context) {
    return widget.widget;
  }
}
