import 'package:my_jio_clone/widgets/app_scroll.dart';

import '../ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 74),
              AppImage.banner(
                imageUrl:
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPq9IvbB042Nq5cnQQFUEdGyHrPVnWPV3I51BPis9BmRb2stPwyho3XQQ3&s=10",
              ),
            ],
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.65,
            minChildSize: 0.65,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(color: AppColors.white),
                child: ListView(
                  controller: scrollController,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        color: AppColors.lightBlue,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Container(
                          width: 80,
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    AppCardGrid(),
                    SizedBox(height: 16),
                    AppCard.currentPlan(),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.large(
                            text: "What's new",
                            isBold: true,
                            color: Colors.black,
                          ),
                          SizedBox(height: 8),
                          AppScroll.profileScroll(),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    AppCard.quickLinks(),

                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppScroll.scroll(
                        urls: entertainmentUrls,
                        height: 300,
                        width: 300,
                        title: "Entertainment",
                        subtitle: "Top Movies",
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppScroll.scroll(
                        urls: finaceUrls,
                        height: 300,
                        width: 300,
                        title: "Finance",
                        subtitle: "Your financial companion",
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppScroll.scroll(
                        urls: urls,
                        height: 200,
                        width: 150,
                        title: "Gaming",
                        subtitle: "Top Game",
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.extraLarge(
                            text: "With love,",
                            color: const Color.fromARGB(175, 158, 158, 158),
                            isBold: true,
                          ),
                          AppText.extraLarge(
                            text: "from Jio.",
                            color: const Color.fromARGB(175, 158, 158, 158),
                            isBold: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          CustomAppBar.home(),
        ],
      ),
    );
  }
}
