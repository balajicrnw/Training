import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../shared/appointment_model.dart';
import 'package:uuid/uuid.dart';

final appointmentsProvider = NotifierProvider<AppointmentsNotifier, List<AppointmentModel>>(() {
  return AppointmentsNotifier();
});

class AppointmentsNotifier extends Notifier<List<AppointmentModel>> {
  @override
  List<AppointmentModel> build() {
    return [];
  }

  void addAppointment(AppointmentModel appointment) {
    state = [...state, appointment];
  }

  void removeAppointment(String id) {
    state = state.where((a) => a.id != id).toList();
  }

  void insertAppointment(int index, AppointmentModel appointment) {
    final newList = List<AppointmentModel>.from(state);
    newList.insert(index, appointment);
    state = newList;
  }
}
