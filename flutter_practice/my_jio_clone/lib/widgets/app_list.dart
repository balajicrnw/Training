import '../ui.dart';

class AppList extends StatefulWidget {
  final List<Widget> widgets;
  final String? title;
  const AppList({super.key, required this.widgets, this.title});

  @override
  State<AppList> createState() => _AppListState();
}

class _AppListState extends State<AppList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title != null
            ? Text(
                widget.title!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              )
            : const SizedBox.shrink(),
        ...widget.widgets,
      ],
    );
  }
}

class AppListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final trailing;
  final leading;
  final imgUrl;

  const AppListTile({
    super.key,
    required this.title,
    this.subtitle,

    this.trailing,
    this.leading,
    this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: AppText.medium(text: title, isBold: true),
      subtitle: subtitle != null ? AppText.small(text: subtitle!) : null,
      trailing: trailing ?? null,
      leading: leading ?? null,
      contentPadding: EdgeInsets.zero,
    );
  }
}
