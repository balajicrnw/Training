import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

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

          if (constraints.maxWidth > 600) {
            crossAxisCount = 3;
          }
          if (constraints.maxWidth > 900) {
            crossAxisCount = 4;
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              return buildCard(index);
            },
          );
        },
      ),
    );
  }

  Widget buildCard(int index) {
    final items = [
      {"title": "Hospitals", "icon": Icons.local_hospital},
      {"title": "Doctors", "icon": Icons.person},
      {"title": "Appointments", "icon": Icons.calendar_today},
      {"title": "Pharmacy", "icon": Icons.local_pharmacy},
      {"title": "Reports", "icon": Icons.description},
      {"title": "Emergency", "icon": Icons.warning},
    ];

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {},
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