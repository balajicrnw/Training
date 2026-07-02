import 'package:instagram_clone/widgets/ui.dart';

class AppSearch extends StatefulWidget {
  final String text;
  final borderSide;
  AppSearch({super.key, this.text = "Search", this.borderSide = 32});

  @override
  State<AppSearch> createState() => _AppSearchState();
}

class _AppSearchState extends State<AppSearch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(top: 2, bottom: 2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderSide),
            borderSide: BorderSide.none,
          ),
          fillColor: AppColors.buttonGrey,
          filled: true,
          prefixIcon: Icon(Icons.search, color: AppColors.white, size: 24),
          hintText: widget.text,
          hintStyle: TextStyle(color: AppColors.grey, fontSize: 18),
        ),
      ),
    );
  }
}
