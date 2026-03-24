import 'package:flutter_test/flutter_test.dart';
import 'package:doctors_door/core/appointments_provider.dart';
import 'package:doctors_door/shared/appointment_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  test('AppointmentsProvider state test', () {
    final container = ProviderContainer();
    final notifier = container.read(appointmentsProvider.notifier);

    expect(container.read(appointmentsProvider), isEmpty);

    final appointment = AppointmentModel((b) => b
      ..id = '1'
      ..doctorName = 'Dr. Kumar'
      ..hospitalName = 'City General Hospital'
      ..appointmentDate = DateTime(2026, 3, 25)
      ..notes = 'Test note'
    );

    notifier.addAppointment(appointment);
    expect(container.read(appointmentsProvider).length, 1);
    expect(container.read(appointmentsProvider)[0].doctorName, 'Dr. Kumar');

    notifier.removeAppointment('1');
    expect(container.read(appointmentsProvider), isEmpty);

    notifier.insertAppointment(0, appointment);
    expect(container.read(appointmentsProvider).length, 1);
    expect(container.read(appointmentsProvider)[0].id, '1');
  });
}
