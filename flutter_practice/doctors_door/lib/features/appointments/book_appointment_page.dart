import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../core/doctors_service.dart';
import '../../core/appointments_provider.dart';
import '../../shared/doctor_model.dart';
import '../../shared/appointment_model.dart';

class BookAppointmentPage extends ConsumerStatefulWidget {
  const BookAppointmentPage({super.key});

  @override
  ConsumerState<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends ConsumerState<BookAppointmentPage> {
  final _formKey = GlobalKey<FormState>();
  late List<DoctorModel> allDoctors;
  DoctorModel? selectedDoctor;
  DateTime? selectedDate;
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    allDoctors = DoctorsService.getDoctors();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final nextWeek = now.add(const Duration(days: 7));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Appointment"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Doctor",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<DoctorModel>(
                isExpanded: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.person),
                ),
                hint: const Text("Choose a doctor"),
                value: selectedDoctor,
                items: allDoctors.map((doc) {
                  return DropdownMenuItem(
                    value: doc,
                    child: Text(
                      "${doc.name} (${doc.qualification})",
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDoctor = value;
                    selectedDate = null; // Reset date if doctor changes
                  });
                },
                validator: (value) => value == null ? "Please select a doctor" : null,
              ),
              if (selectedDoctor != null) ...[
                const SizedBox(height: 24),
                Text(
                  "Hospital: ${selectedDoctor!.hospital}",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blueGrey),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Available Slots",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: selectedDoctor!.dates.map((date) {
                    final isAvailable = date.isAfter(now) && date.isBefore(nextWeek);
                    final isSelected = selectedDate == date;

                    return ChoiceChip(
                      label: Text(
                        "${date.day}/${date.month} ${date.hour}:${date.minute.toString().padLeft(2, '0')}",
                      ),
                      selected: isSelected,
                      onSelected: isAvailable
                          ? (selected) {
                              setState(() {
                                selectedDate = selected ? date : null;
                              });
                            }
                          : null,
                      selectedColor: Colors.teal.withOpacity(0.2),
                      checkmarkColor: Colors.teal,
                      labelStyle: TextStyle(
                        color: isAvailable ? (isSelected ? Colors.teal : Colors.black) : Colors.grey,
                      ),
                    );
                  }).toList(),
                ),
              ],
              const SizedBox(height: 24),
              const Text(
                "Additional Notes",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Reason for visit, symptoms, etc.",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _bookAppointment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Confirm Booking", style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _bookAppointment() {
    if (_formKey.currentState!.validate() && selectedDate != null) {
      final appointment = AppointmentModel((b) => b
        ..id = const Uuid().v4()
        ..doctorName = selectedDoctor!.name
        ..hospitalName = selectedDoctor!.hospital
        ..appointmentDate = selectedDate!
        ..notes = _notesController.text
      );

      ref.read(appointmentsProvider.notifier).addAppointment(appointment);
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Appointment booked successfully!")),
      );
    } else if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an available slot")),
      );
    }
  }
}
