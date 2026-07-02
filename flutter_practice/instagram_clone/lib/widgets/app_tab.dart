import 'package:instagram_clone/widgets/ui.dart';

class AppTab extends StatefulWidget {
  const AppTab({super.key});
  @override
  State<AppTab> createState() => _AppTabState();
}

class _AppTabState extends State<AppTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            TabBar(
              indicatorColor: AppColors.transparent,
              unselectedLabelColor: AppColors.grey,
              labelColor: AppColors.white,
              tabs: [
                Tab(icon: Icon(Icons.grid_on_outlined)),
                Tab(icon: Icon(Icons.video_collection_outlined)),
                Tab(icon: Icon(Icons.repeat_outlined)),
                Tab(icon: Icon(Icons.person_pin_outlined)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AppImageGrid(postlist: postMock),
                  AppImageGrid(postlist: reelMock),
                  AppImageGrid(postlist: repostMock),
                  AppImageGrid(postlist: taggedMock),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
