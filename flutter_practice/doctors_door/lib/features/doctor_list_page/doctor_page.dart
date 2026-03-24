import 'package:flutter/material.dart';
import 'package:doctors_door/core/doctors_service.dart';
import 'package:doctors_door/shared/doctor_model.dart';

class DoctorPage extends StatefulWidget {
  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  late List<DoctorModel> doctors;

  @override
  void initState() {
    super.initState();
    doctors = DoctorsService.getDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctors"),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ExpansionTile(
              leading: const Icon(Icons.person, color: Colors.teal),
              title: Text(doctor.name ?? "No Name"),
              subtitle: Text(doctor.qualification ?? "General"),
              tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              childrenPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Age: ${doctor.age}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Available Dates:",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    ...doctor.dates.map(
                      (date) => Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          "${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}