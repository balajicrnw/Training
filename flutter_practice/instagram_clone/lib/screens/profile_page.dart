import 'package:instagram_clone/screens/settings_page.dart';
import 'package:instagram_clone/widgets/ui.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: CustomAppBar.profile(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
              },
            ),
          ),
          SliverToBoxAdapter(child: AppProfileView(user: mockData[0])),
        ];
      },
      body: const AppTab(),
    );
  }
}
