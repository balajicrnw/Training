import 'package:instagram_clone/widgets/ui.dart';

class AppNavbar extends StatefulWidget {
  final User user;
  AppNavbar({super.key, required this.user});

  @override
  State<AppNavbar> createState() => _AppNavbarState();
}

class _AppNavbarState extends State<AppNavbar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      Center(child: HomePage()),
      Center(child: ReelsPage()),
      Center(child: ChatPage()),
      Center(child: ExplorePage()),
      Center(child: ProfilePage()),
    ];
    return Scaffold(
      backgroundColor: AppColors.black,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: AppColors.black,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_collection_outlined),
            activeIcon: Icon(Icons.video_collection),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.send_outlined),
            activeIcon: Icon(Icons.send),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),

          BottomNavigationBarItem(
            icon: AppProfile(user: widget.user),
            label: "",
          ),
        ],
      ),
    );
  }
}
