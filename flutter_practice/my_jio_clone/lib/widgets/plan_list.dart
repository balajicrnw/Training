import 'package:my_jio_clone/models/plan.dart';
import 'package:my_jio_clone/ui.dart';

class PlanList extends StatefulWidget {
  const PlanList({super.key, required this.plans});
  final List<Plan> plans;

  @override
  State<PlanList> createState() => _PlanListState();
}

class _PlanListState extends State<PlanList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.plans.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppCard.plan(
            price: widget.plans[index].price,
            validity: widget.plans[index].validity,
            data: widget.plans[index].data,
            specialTag: widget.plans[index].specialTag,
            addOns: widget.plans[index].addOns,
          ),
        );
      },
    );
  }
}
