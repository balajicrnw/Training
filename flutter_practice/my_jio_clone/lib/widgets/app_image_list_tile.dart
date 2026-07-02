import '../ui.dart';

class AppImageListTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String? image;
  final String? subtitle;
  const AppImageListTile({
    super.key,
    required this.icon,
    required this.title,
    this.image,
    this.subtitle,
  });

  @override
  State<AppImageListTile> createState() => _AppImageListTileState();
}

class _AppImageListTileState extends State<AppImageListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.grey),
        color: widget.image != null
            ? AppColors.white
            : const Color.fromARGB(157, 231, 235, 247),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(widget.icon, color: AppColors.darkBlue, size: 32),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.medium(text: widget.title, isBold: true),
                    widget.subtitle != null
                        ? AppText.small(text: widget.subtitle!)
                        : SizedBox.shrink(),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            widget.image != null
                ? Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(widget.image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
