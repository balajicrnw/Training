import 'package:my_jio_clone/ui.dart';

class AppProfile extends StatefulWidget {
  const AppProfile({super.key, this.imgUrl, this.icon, required this.text});
  final String? imgUrl;
  final IconData? icon;
  final String text;

  @override
  State<AppProfile> createState() => _AppProfileState();
}

class _AppProfileState extends State<AppProfile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: widget.imgUrl != null
                ? BoxDecoration(
                    border: Border.all(color: AppColors.grey),
                    image: DecorationImage(
                      image: NetworkImage(widget.imgUrl!),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                  )
                : BoxDecoration(
                    color: AppColors.lightBlue,
                    shape: BoxShape.circle,
                  ),
            child: widget.icon != null
                ? Icon(widget.icon, color: AppColors.darkBlue)
                : null,
          ),
          widget.imgUrl != null
              ? Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(color: AppColors.black),
                    ),
                  ),
                )
              : AppText.small(text: widget.text),
        ],
      ),
    );
  }
}
