import 'package:instagram_clone/widgets/ui.dart';

class AppProfile extends StatefulWidget {
  final User user;
  final double width;
  final double height;
  const AppProfile({
    super.key,
    required this.user,
    this.width = 29,
    this.height = 29,
  });

  @override
  State<AppProfile> createState() => _AppProfileState();
}

class _AppProfileState extends State<AppProfile> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: widget.width + (widget.width * 0.08),
          height: widget.height + (widget.height * 0.08),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [AppColors.orange, AppColors.red, AppColors.purple],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
        ),
        Container(
          width: widget.width + (widget.width * 0.01),
          height: widget.height + (widget.width * 0.01),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.black,
          ),
        ),
        ClipOval(
          child: Image.network(
            widget.user.profileImage,

            width: widget.width - 6,
            height: widget.height - 6,
            fit: BoxFit.cover,

            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Container(
                    width: widget.width - 6,
                    height: widget.height - 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.grey,
                    ),
                    child: Icon(Icons.person, size: 24, color: AppColors.white),
                  );
                },
          ),
        ),
      ],
    );
  }
}
