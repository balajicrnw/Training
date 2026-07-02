import 'package:instagram_clone/widgets/ui.dart';

class AppImageGrid extends StatefulWidget {
  const AppImageGrid({super.key, required this.postlist});
  final List<AppPost> postlist;

  @override
  State<AppImageGrid> createState() => _AppImageGridState();
}

class _AppImageGridState extends State<AppImageGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.postlist.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(1.0),
          child: widget.postlist[index],
        );
      },
    );
  }
}
