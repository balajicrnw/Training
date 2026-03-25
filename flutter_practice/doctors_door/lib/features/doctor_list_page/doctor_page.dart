import 'package:flutter/material.dart';
import 'package:doctors_door/core/doctors_service.dart';
import 'package:doctors_door/shared/doctor_model.dart';
import 'package:doctors_door/shared/web_safe_image.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late List<DoctorModel> _doctors;

  @override
  void initState() {
    super.initState();
    _doctors = List.from(DoctorsService.getDoctors());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctors"),
        backgroundColor: Colors.teal,
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _doctors.length,
        itemBuilder: (context, index, animation) {
          return _buildItem(_doctors[index], animation, index);
        },
      ),
    );
  }

  Widget _buildItem(DoctorModel doctor, Animation<double> animation, int index) {
    return SlideTransition(
      position: animation.drive(Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeOut))),
      child: FadeTransition(
        opacity: animation,
        child: _buildCard(doctor),
      ),
    );
  }

  Widget _buildCard(DoctorModel doctor) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ExpansionTile(
        leading: ClipOval(
          child: WebSafeImage(
            imageUrl: "https://api.dicebear.com/7.x/avataaars/png?seed=${doctor.name}",
            width: 40,
            height: 40,
            fit: BoxFit.cover,
            errorWidget: const Icon(Icons.person, color: Colors.teal),
          ),
        ),
        title: Text(doctor.name),
        subtitle: Text("${doctor.qualification} - ${doctor.hospital}"),
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        childrenPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        expandedAlignment: Alignment.centerLeft,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Age: ${doctor.age}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Available Dates:",
                style: TextStyle(fontWeight: FontWeight.bold),
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
  }
}
