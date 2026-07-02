import 'package:instagram_clone/widgets/ui.dart';

class AppSettingsList extends StatelessWidget {
  const AppSettingsList({
    super.key,
    required this.list,
    required this.title,
    this.divider = true,
  });
  final List<AppListTile> list;
  final String title;
  final bool divider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 16.0),
          child: AppText.grey(text: title),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) {
            return list[index];
          },
        ),
        divider
            ? Divider(color: AppColors.divider, thickness: 5)
            : const SizedBox(),
      ],
    );
  }
}
