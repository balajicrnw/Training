import "package:my_jio_clone/widgets/app_button.dart";
import "package:my_jio_clone/widgets/app_icon.dart";

import "../ui.dart";

class AppCard extends StatefulWidget {
  final Widget widget;
  const AppCard({super.key, required this.widget});

  factory AppCard.plan({
    required int price,
    required String validity,
    required String data,
    Widget? addOns,
    String? specialTag,
  }) {
    return AppCard(
      widget: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                specialTag != null
                    ? Container(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        decoration: BoxDecoration(
                          color: AppColors.lightOrange,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: Center(
                          child: AppText.small(
                            text: specialTag,
                            color: AppColors.orange,
                            isBold: true,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                Text(
                  "TRUE 5G",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.red,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.large(text: "₹$price", isBold: true),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.tiny(text: "Validity"),
                          AppText.tiny(text: validity, isBold: true),
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.tiny(text: "Data"),
                          AppText.tiny(text: data, isBold: true),
                        ],
                      ),
                      AppIcon(icons: Icons.arrow_forward_ios_rounded, size: 12),
                    ],
                  ),
                  Divider(color: AppColors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: addOns ?? AppText.small(text: "+2 more OTT"),
                      ),
                      AppButton.blue(text: "Buy"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  factory AppCard.trailingImage({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return AppCard(
      widget: SizedBox(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.small(text: title, isBold: true),
                    AppText.tiny(text: subtitle),
                  ],
                ),
                Container(
                  child: Icon(icon, size: 40, color: AppColors.darkBlue),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  factory AppCard.topImage({required String title, required IconData icon}) {
    return AppCard(
      widget: SizedBox(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.white,
          ),

          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                child: Container(
                  child: Icon(icon, size: 32, color: AppColors.darkBlue),
                ),
              ),

              AppText.small(text: title, isBold: true),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  factory AppCard.currentPlan() {
    return AppCard(
      widget: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(175, 232, 239, 255),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.tablet_android_rounded,
                      size: 24,
                      color: AppColors.darkBlue,
                    ),
                    SizedBox(width: 16),
                    AppText.medium(text: "Mobile prepaid 9876543210"),
                  ],
                ),
                Icon(Icons.arrow_forward_ios_rounded, size: 16),
              ],
            ),
            SizedBox(height: 16),

            IntrinsicHeight(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppText.small(
                            text: "Unlimited True 5G",
                            isBold: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.info_rounded,
                              size: 16,
                              color: const Color.fromARGB(156, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          AppText.large(text: "2", isBold: true),
                          SizedBox(width: 4),
                          AppText.tiny(text: "GB", isBold: true),
                        ],
                      ),
                      AppText.tiny(
                        text: "left of 2 GB",
                        color: const Color.fromARGB(255, 93, 93, 93),
                        isBold: true,
                      ),
                      AppText.tiny(
                        text: "Renews in 12 hours",
                        color: const Color.fromARGB(255, 93, 93, 93),
                        isBold: true,
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  VerticalDivider(thickness: 1, color: AppColors.grey),
                  SizedBox(width: 16),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppText.tiny(
                        text: "Plan expiring",
                        color: AppColors.orange,
                        isBold: true,
                      ),
                      AppText.medium(
                        text: "₹349",
                        color: AppColors.orange,
                        isBold: true,
                      ),
                      AppText.tiny(
                        text: "2 days left",
                        color: AppColors.orange,
                        isBold: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(color: AppColors.grey),
            AppText.medium(text: "Repeat your plan", isBold: true),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),

                color: AppColors.white,
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppText.medium(text: "Rs 349"),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.info_rounded,
                              size: 16,
                              color: const Color.fromARGB(156, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                      AppText.small(
                        text: "Data",
                        color: const Color.fromARGB(255, 158, 158, 158),
                        isBold: true,
                      ),
                      AppText.small(text: "2 GB/Day"),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox.shrink(),
                      AppText.small(
                        text: "Validity",
                        color: const Color.fromARGB(255, 158, 158, 158),
                        isBold: true,
                      ),
                      AppText.small(text: "28 days"),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 14.0),
                    child: AppButton.blue(text: "Recharge"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.grey),
              ),

              child: AppText.medium(
                text: "Explore all plans",
                isBold: true,
                color: AppColors.darkBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  factory AppCard.quickLinks() {
    return AppCard(
      widget: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.large(text: "Quick links", isBold: true),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey),
                borderRadius: BorderRadius.circular(16),
              ),
              child: GridView.builder(
                shrinkWrap: true,

                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.2,
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    child: AppProfile(
                      text: "Maching number",
                      icon: Icons.sim_card,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  @override
  Widget build(BuildContext context) {
    return widget.widget;
  }
}
