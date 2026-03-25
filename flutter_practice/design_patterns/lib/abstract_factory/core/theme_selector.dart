import 'package:flutter/material.dart';

class ThemeSelector extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  const ThemeSelector({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(isDark ? 'Dark Mode' : 'Light Mode'),
      secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
      value: isDark,
      onChanged: onThemeChanged,
    );
  }
}
