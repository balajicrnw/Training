import 'package:my_jio_clone/ui.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({super.key});

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar.recharge(),
          TabBar(
            tabAlignment: TabAlignment.start,
            padding: EdgeInsets.zero,
            isScrollable: true,
            labelColor: AppColors.black,
            indicatorColor: AppColors.darkBlue,
            tabs: [
              Tab(text: "Popular"),
              Tab(text: "True 5G"),
              Tab(text: "Youth"),
              Tab(text: "International Roaming"),
              Tab(text: "Data Add-on"),
            ],
          ),

          Expanded(
            child: TabBarView(
              children: [
                ListView(
                  children: [
                    ExpansionTile(
                      trailing: Icon(Icons.add, color: AppColors.darkBlue),
                      title: AppText.medium(text: "Popular Plans"),
                      children: [PlanList(plans: popularPlans)],
                    ),
                    ExpansionTile(
                      trailing: Icon(Icons.add, color: AppColors.darkBlue),
                      title: AppText.medium(text: "Popular Plans"),
                      children: [PlanList(plans: popularPlans)],
                    ),
                    ExpansionTile(
                      trailing: Icon(Icons.add, color: AppColors.darkBlue),
                      title: AppText.medium(text: "Popular Plans"),
                      children: [PlanList(plans: popularPlans)],
                    ),
                  ],
                ),
                ListView(children: [PlanList(plans: true5GPlans)]),
                ListView(children: [PlanList(plans: youthPlans)]),
                ListView(children: [PlanList(plans: popularPlans)]),
                ListView(children: [PlanList(plans: popularPlans)]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
