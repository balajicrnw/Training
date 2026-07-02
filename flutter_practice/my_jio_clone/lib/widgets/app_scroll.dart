import 'package:my_jio_clone/ui.dart';

class AppScroll extends StatefulWidget {
  final Widget widget;
  AppScroll({super.key, required this.widget});

  @override
  State<AppScroll> createState() => _AppScrollState();

  factory AppScroll.profileScroll() {
    return AppScroll(
      widget: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            left: 8.0,
            right: 8.0,
            bottom: 8.0,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                AppProfile(
                  text: "Google Gemini",
                  imgUrl:
                      "https://static.vecteezy.com/system/resources/previews/055/687/055/large_2x/rectangle-gemini-google-icon-symbol-logo-free-png.png",
                ),
                AppProfile(
                  text: "Google Gemini",
                  imgUrl:
                      "https://static.vecteezy.com/system/resources/previews/055/687/055/large_2x/rectangle-gemini-google-icon-symbol-logo-free-png.png",
                ),
                AppProfile(
                  text: "Google Gemini",
                  imgUrl:
                      "https://static.vecteezy.com/system/resources/previews/055/687/055/large_2x/rectangle-gemini-google-icon-symbol-logo-free-png.png",
                ),
                AppProfile(
                  text: "Google Gemini",
                  imgUrl:
                      "https://static.vecteezy.com/system/resources/previews/055/687/055/large_2x/rectangle-gemini-google-icon-symbol-logo-free-png.png",
                ),
                AppProfile(
                  text: "Google Gemini",
                  imgUrl:
                      "https://static.vecteezy.com/system/resources/previews/055/687/055/large_2x/rectangle-gemini-google-icon-symbol-logo-free-png.png",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  factory AppScroll.scroll({
    required List<String> urls,
    required double height,
    required double width,
    required String title,
    required String subtitle,
  }) {
    return AppScroll(
      widget: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.large(text: title, isBold: true),
                  AppText.small(
                    text: subtitle,
                    color: AppColors.black,
                    isBold: true,
                  ),
                ],
              ),
              Spacer(),
              AppText.medium(
                text: "View all",
                isBold: true,
                color: AppColors.darkBlue,
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                urls.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                  child: AppImage.scroller(
                    imageUrl: urls[index],
                    height: height,
                    width: width,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AppScrollState extends State<AppScroll> {
  @override
  Widget build(BuildContext context) {
    return widget.widget;
  }
}
