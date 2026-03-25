import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/appointments_provider.dart';
import '../../shared/appointment_model.dart';
import 'package:intl/intl.dart';

class AppointmentsPage extends ConsumerStatefulWidget {
  const AppointmentsPage({super.key});

  @override
  ConsumerState<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends ConsumerState<AppointmentsPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<AppointmentModel> _localList = [];

  @override
  Widget build(BuildContext context) {
    ref.listen<List<AppointmentModel>>(appointmentsProvider, (previous, next) {
      if (previous == null) return;
      
      if (next.length > previous.length) {
        for (int i = 0; i < next.length; i++) {
          if (i >= previous.length || next[i].id != previous[i].id) {
            _localList.insert(i, next[i]);
            _listKey.currentState?.insertItem(i);
            break; 
          }
        }
      } else if (next.length < previous.length) {
        for (int i = 0; i < previous.length; i++) {
          if (i >= next.length || previous[i].id != next[i].id) {
            final removedItem = previous[i];
            _localList.removeAt(i);
            _listKey.currentState?.removeItem(
              i,
              (context, animation) => _buildItem(removedItem, animation, i, isRemoving: true),
            );
            break;
          }
        }
      }
    });

    final appointments = ref.watch(appointmentsProvider);
    if (_localList.isEmpty && appointments.isNotEmpty) {
      _localList.addAll(appointments);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Appointments"),
        backgroundColor: Colors.teal,
      ),
      body: appointments.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "No appointments booked yet.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : AnimatedList(
              key: _listKey,
              initialItemCount: _localList.length,
              itemBuilder: (context, index, animation) {
                return _buildItem(_localList[index], animation, index);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/bookAppointment'),
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildItem(AppointmentModel appointment, Animation<double> animation, int index, {bool isRemoving = false}) {
    return SlideTransition(
      position: animation.drive(Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeOut))),
      child: FadeTransition(
        opacity: animation,
        child: isRemoving
          ? _buildCard(appointment)
          : Dismissible(
              key: Key(appointment.id),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                _removeAppointment(appointment, index);
              },
              child: _buildCard(appointment),
            ),
      ),
    );
  }

  Widget _buildCard(AppointmentModel appointment) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.teal.withOpacity(0.1),
          child: const Icon(Icons.medical_services, color: Colors.teal),
        ),
        title: Text(
          appointment.doctorName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(appointment.hospitalName),
            const SizedBox(height: 4),
            Text(
              DateFormat('EEE, MMM d, yyyy - hh:mm a').format(appointment.appointmentDate),
              style: const TextStyle(color: Colors.teal, fontSize: 12),
            ),
            if (appointment.notes != null && appointment.notes!.isNotEmpty)
              Text(
                "Note: ${appointment.notes}",
                style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }

  void _removeAppointment(AppointmentModel appointment, int index) {
    ref.read(appointmentsProvider.notifier).removeAppointment(appointment.id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Cancelled appointment with ${appointment.doctorName}"),
        action: SnackBarAction(
          label: "UNDO",
          textColor: Colors.tealAccent,
          onPressed: () {
            ref.read(appointmentsProvider.notifier).insertAppointment(index, appointment);
          },
        ),
      ),
    );
  }
}
