import 'package:instagram_clone/widgets/ui.dart';

class AppChipList extends StatefulWidget {
  const AppChipList({super.key});

  @override
  State<AppChipList> createState() => _AppChipListState();
}

class _AppChipListState extends State<AppChipList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,

      child: Row(
        children: [
          AppChip(text: "All"),
          AppChip(text: "Collections"),
          AppChip(text: "Reels"),
          AppChip(text: "Tagged"),
          AppChip(text: "Tagged"),
          AppChip(text: "Tagged"),
          AppChip(text: "All"),
          AppChip(text: "Posts"),
          AppChip(text: "Reels"),
          AppChip(text: "Tagged"),
          AppChip(text: "Tagged"),
          AppChip(text: "Tagged"),
        ],
      ),
    );
  }
}
