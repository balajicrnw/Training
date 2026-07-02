import 'package:my_jio_clone/ui.dart';
import 'package:my_jio_clone/widgets/app_image_list_tile.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          CustomAppBar.notifications(),
          SizedBox(height: 32),
          Row(
            children: [
              AppChip(text: "All"),
              SizedBox(width: 8),
              AppChip(text: "Promotions"),
              SizedBox(width: 8),
              AppChip(text: "Utilities"),
            ],
          ),
          SizedBox(height: 16),
          AppImage.banner(
            imageUrl:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPq9IvbB042Nq5cnQQFUEdGyHrPVnWPV3I51BPis9BmRb2stPwyho3XQQ3&s=10",
          ),
          SizedBox(height: 16),

          AppImageListTile(
            icon: Icons.monetization_on_rounded,
            title: "OTT Pass",
            image:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlCyNvBZcYzLorFOgJzfdSXaFwUN6gYWtsrlW_FNu4tXqa3Z3MLtz2Huv5y1ifK2iiDe1x_71iLI4U4gAj_Fwur-N4L7RaF1kx0qTBiQ&s=10",
          ),
          SizedBox(height: 16),

          AppImageListTile(
            icon: Icons.sim_card,
            title: "Matching numbers",
            subtitle: "Matching number for your family & friends",
          ),
          SizedBox(height: 16),

          AppImageListTile(
            icon: Icons.monetization_on_rounded,
            title: "OTT Pass",
            image:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlCyNvBZcYzLorFOgJzfdSXaFwUN6gYWtsrlW_FNu4tXqa3Z3MLtz2Huv5y1ifK2iiDe1x_71iLI4U4gAj_Fwur-N4L7RaF1kx0qTBiQ&s=10",
          ),

          SizedBox(height: 16),

          AppImageListTile(
            icon: Icons.savings,
            title: "A rish first strategy fund",
            subtitle: "Multi-strategy investing powered by risk-first.",
          ),

          SizedBox(height: 16),

          AppImageListTile(
            icon: Icons.music_note,
            title: "Let your callers hear",
            subtitle: "set a FREE JioTune now",
          ),

          SizedBox(height: 16),

          AppImageListTile(
            icon: Icons.sim_card,
            title: "Matching numbers",
            subtitle: "Matching number for your family",
          ),
        ],
      ),
    );
  }
}
