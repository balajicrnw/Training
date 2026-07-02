import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/widgets/ui.dart';

class CustomAppBar extends StatefulWidget {
  final Widget widget;
  final VoidCallback? onPressed;

  const CustomAppBar({super.key, required this.widget, this.onPressed});
  factory CustomAppBar.message() {
    return CustomAppBar(
      widget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Spacer(),
            AppText.medium(text: "batman2004"),
            AppIconButton(
              icon: Icons.arrow_drop_down_rounded,
              onPressed: () {},
            ),
            SizedBox(width: 64),
            AppIconButton(icon: Icons.edit_square, onPressed: () {}),
          ],
        ),
      ),
    );
  }

  factory CustomAppBar.activity() {
    return CustomAppBar(
      widget: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          children: [
            AppIconButton(
              icon: Icons.arrow_back,
              onPressed: () {},
              selected: true,
            ),
            SizedBox(width: 16),
            AppText.medium(text: "Your activity"),
          ],
        ),
      ),
    );
  }

  factory CustomAppBar.permissions() {
    return CustomAppBar(
      widget: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          children: [
            AppIconButton(
              icon: Icons.arrow_back,
              onPressed: () {},
              selected: true,
            ),
            SizedBox(width: 16),
            AppText.medium(text: "Device permissions"),
          ],
        ),
      ),
    );
  }

  factory CustomAppBar.privacy() {
    return CustomAppBar(
      widget: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          children: [
            AppIconButton(
              icon: Icons.arrow_back,
              onPressed: () {},
              selected: true,
            ),
            SizedBox(width: 24),
            AppText.medium(text: "Account privacy"),
          ],
        ),
      ),
    );
  }

  factory CustomAppBar.saved() {
    return CustomAppBar(
      widget: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          children: [
            AppIconButton(
              icon: Icons.arrow_back,
              onPressed: () {},
              selected: true,
            ),
            SizedBox(width: 16),
            AppText.medium(text: "Saved"),
            Spacer(),
            AppIconButton(icon: Icons.add, onPressed: () {}, selected: true),
          ],
        ),
      ),
    );
  }
  factory CustomAppBar.home() {
    return CustomAppBar(
      widget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppIconButton(
              icon: Icons.add,
              onPressed: () {},
              selected: true,
              size: 32,
            ),
            SizedBox(width: 8),
            Row(
              children: [
                AppText.title(text: "Instagram"),
                Column(
                  children: [
                    SizedBox(height: 16),
                    AppIconButton(
                      icon: Icons.keyboard_arrow_down_outlined,
                      onPressed: () {},
                      size: 16,
                      selected: true,
                    ),
                  ],
                ),
              ],
            ),
            AppIconButton(
              icon: Icons.favorite_outline_rounded,
              onPressed: () {},
              selected: true,
              size: 32,
            ),
          ],
        ),
      ),
    );
  }

  factory CustomAppBar.profile({required VoidCallback onPressed}) {
    return CustomAppBar(
      widget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppIconButton(
              icon: Icons.add,
              onPressed: () {},
              size: 32,
              selected: true,
            ),
            Spacer(),
            Row(
              children: [
                AppText.medium(text: "batman2004"),

                AppIconButton(
                  icon: Icons.keyboard_arrow_down_outlined,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(width: 8),
            AppIconButton(
              icon: Icons.facebook_outlined,
              onPressed: () {},
              selected: true,
              size: 32,
            ),
            SizedBox(width: 8),
            AppIconButton(
              icon: Icons.menu_outlined,
              onPressed: () => onPressed(),
              selected: true,
              size: 32,
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  factory CustomAppBar.timeManagement() {
    return CustomAppBar(
      widget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppIconButton(
              icon: Icons.arrow_back_rounded,
              onPressed: () {},
              selected: true,
            ),
            SizedBox(width: 16),
            AppText.medium(text: "Time Management"),
            Spacer(),
            AppIconButton(
              icon: Icons.info_outline,
              onPressed: () {},
              size: 32,
              selected: true,
            ),
          ],
        ),
      ),
    );
  }

  factory CustomAppBar.settings({required VoidCallback onPressed}) {
    return CustomAppBar(
      widget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            AppIconButton(icon: Icons.arrow_back_rounded, onPressed: onPressed),
            SizedBox(width: 18),
            AppText.medium(text: "Settings and activity"),
          ],
        ),
      ),
    );
  }

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(child: widget.widget);
  }
}
