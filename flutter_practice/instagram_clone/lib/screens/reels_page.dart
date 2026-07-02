import 'package:instagram_clone/widgets/ui.dart';

class ReelsPage extends StatelessWidget {
  const ReelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPost.full(post: posts);
  }
}
