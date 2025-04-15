// lib/features/appointments/domain/usecases/load_appointments_usecase.dart

import '../entities/appointment_entity.dart';

class LoadAppointmentsUseCase {
  Future<Map<String, List<AppointmentEntity>>> call() async {
    // Dummy data – replace with actual API or DB
    await Future.delayed(const Duration(milliseconds: 500));

    return {
      'upcoming': [],
      'completed': [],
      'cancelled': [],
    };
  }
}
