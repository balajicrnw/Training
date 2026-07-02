import 'package:instagram_clone/widgets/ui.dart';

class AppListTile extends StatelessWidget {
  final String text;
  final IconData? leading;
  final String? trailing;
  final String? subtitle;
  final VoidCallback? onTap;
  const AppListTile({
    super.key,
    required this.text,
    this.trailing,
    this.leading,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: leading != null ? Icon(leading, color: AppColors.white) : null,
      title: AppText.small(text: text),
      subtitle: subtitle != null ? AppText.grey(text: subtitle!) : null,
      trailing: trailing != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText.grey(text: trailing!),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios_rounded),
              ],
            )
          : Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}
