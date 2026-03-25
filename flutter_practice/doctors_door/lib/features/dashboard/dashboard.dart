import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/tooltip_overlay.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Flag to ensure we only show the onboarding once per app session
  static bool _hasShownOnboarding = false;

  final List<GlobalKey> _cardKeys = List.generate(6, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasShownOnboarding) {
        _hasShownOnboarding = true;
        _showOnboarding();
      }
    });
  }

  void _showOnboarding() {
    final steps = [
      TooltipStep(
        targetKey: _cardKeys[0],
        title: "Hospitals",
        description: "Browse and discover our network of partner hospitals.",
      ),
      TooltipStep(
        targetKey: _cardKeys[1],
        title: "Doctors",
        description: "Find specialists and book consultations easily.",
      ),
      TooltipStep(
        targetKey: _cardKeys[2],
        title: "Appointments",
        description: "Manage your upcoming and past medical appointments.",
      ),
      TooltipStep(
        targetKey: _cardKeys[3],
        title: "Pharmacy",
        description: "Order medicines online with fast home delivery.",
      ),
      TooltipStep(
        targetKey: _cardKeys[4],
        title: "Reports",
        description: "Access your lab results and medical history securely.",
      ),
      TooltipStep(
        targetKey: _cardKeys[5],
        title: "Emergency",
        description: "Get immediate medical assistance when you need it most.",
      ),
    ];

    OverlayHelper.show(context, steps);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.teal,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 2;
          if (constraints.maxWidth > 600) crossAxisCount = 3;
          if (constraints.maxWidth > 900) crossAxisCount = 4;

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              return buildCard(context, index);
            },
          );
        },
      ),
    );
  }

  Widget buildCard(BuildContext context, int index) {
    final items = [
      {"title": "Hospitals", "icon": Icons.local_hospital, "route": "/hospitalsList"},
      {"title": "Doctors", "icon": Icons.person, "route": "/doctorsList"},
      {"title": "Appointments", "icon": Icons.calendar_today, "route": "/appointments"},
      {"title": "Pharmacy", "icon": Icons.local_pharmacy, "route": "/pharmacy"},
      {"title": "Reports", "icon": Icons.description, "route": "/reports"},
      {"title": "Emergency", "icon": Icons.warning, "route": "/emergency"},
    ];

    return Card(
      key: _cardKeys[index],
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          final route = items[index]["route"] as String;
          if (route.isNotEmpty) {
            GoRouter.of(context).push(route);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              items[index]["icon"] as IconData,
              size: 40,
              color: Colors.teal,
            ),
            const SizedBox(height: 10),
            Text(
              items[index]["title"] as String,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}