import 'package:instagram_clone/widgets/ui.dart';

class AppChart extends StatefulWidget {
  const AppChart({super.key});

  @override
  State<AppChart> createState() => _AppChartState();
}

class _AppChartState extends State<AppChart> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AppChartRow(text: "Wed", value: 45),
          AppChartRow(text: "Thu", value: 130),
          AppChartRow(text: "Fri", value: 70),
          AppChartRow(text: "Sat", value: 50),
          AppChartRow(text: "Sun", value: 10),
          AppChartRow(text: "Mon", value: 100),
          AppChartRow(text: "Today", value: 5),
        ],
      ),
    );
  }
}

class AppChartRow extends StatelessWidget {
  const AppChartRow({super.key, required this.text, required this.value});
  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.purple,
          ),
          width: 46,
          height: value,
        ),
        AppText.tinyGrey(text: text),
      ],
    );
  }
}
