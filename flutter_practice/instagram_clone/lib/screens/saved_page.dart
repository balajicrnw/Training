import 'package:instagram_clone/widgets/ui.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomAppBar.saved(),
              AppChipList(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.small(text: "Reels and posts"),
                    AppText.blue(text: "Manage"),
                  ],
                ),
              ),
              AppImageGrid(postlist: mockPost),
            ],
          ),
        ),
      ),
    );
  }
}
