import 'package:instagram_clone/widgets/ui.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppSearch(text: "Search with Meta AI"),
          AppImageGrid(postlist: mockPost),
        ],
      ),
    );
  }
}
