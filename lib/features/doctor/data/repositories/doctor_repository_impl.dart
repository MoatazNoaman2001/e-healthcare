import '../../../../core/utils/typedefs.dart';
import '../../domain/entities/doctor.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/entities/schedule.dart';
import '../../domain/repositories/doctor_repository.dart';
import '../datasources/doctor_remote_datasource.dart';


class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorRemoteDataSource _remoteDataSource;

  DoctorRepositoryImpl(this._remoteDataSource);

  @override
  ResultFuture<Doctor> getMyProfile() async {
    return await _remoteDataSource.getMyProfile();
  }

  @override
  ResultFuture<Doctor> getDoctorProfile(String doctorId) async {
    return await _remoteDataSource.getDoctorProfile(doctorId);
  }

  @override
  ResultFuture<Doctor> updateDoctorProfile(Doctor doctor) async {
    return await _remoteDataSource.updateDoctorProfile(doctor);
  }

  @override
  ResultFuture<Doctor> registerDoctor(Doctor doctor, String password) async {
    return await _remoteDataSource.registerDoctor(doctor, password);
  }

  @override
  ResultFuture<List<Appointment>> getAppointments(String doctorId) async {
    return await _remoteDataSource.getAppointments(doctorId);
  }

  @override
  ResultFuture<List<Appointment>> getPastAppointments(String doctorId) async {
    return await _remoteDataSource.getPastAppointments(doctorId);
  }

  @override
  ResultFuture<List<Appointment>> getTodayAppointments(String doctorId) async {
    return await _remoteDataSource.getTodayAppointments(doctorId);
  }

  @override
  ResultFuture<List<Appointment>> getUpcomingAppointments(String doctorId) async {
    return await _remoteDataSource.getUpcomingAppointments(doctorId);
  }

  @override
  ResultFuture<Appointment> getAppointment(String doctorId, String appointmentId) async {
    return await _remoteDataSource.getAppointment(doctorId, appointmentId);
  }

  @override
  ResultFuture<Appointment> createAppointment(String doctorId, Appointment appointment) async {
    return await _remoteDataSource.createAppointment(doctorId, appointment);
  }

  @override
  ResultFuture<Appointment> updateAppointment(String doctorId, Appointment appointment) async {
    return await _remoteDataSource.updateAppointment(doctorId, appointment);
  }

  @override
  ResultVoid deleteAppointment(String doctorId, String appointmentId) async {
    return await _remoteDataSource.deleteAppointment(doctorId, appointmentId);
  }

  @override
  ResultFuture<Appointment> cancelAppointment(String doctorId, String appointmentId) async {
    return await _remoteDataSource.cancelAppointment(doctorId, appointmentId);
  }

  @override
  ResultFuture<Appointment> completeAppointment(String doctorId, String appointmentId) async {
    return await _remoteDataSource.completeAppointment(doctorId, appointmentId);
  }

  @override
  ResultFuture<Appointment> confirmAppointment(String doctorId, String appointmentId) async {
    return await _remoteDataSource.confirmAppointment(doctorId, appointmentId);
  }

  @override
  ResultFuture<Appointment> markNoShow(String doctorId, String appointmentId) async {
    return await _remoteDataSource.markNoShow(doctorId, appointmentId);
  }

  @override
  ResultFuture<Appointment> rescheduleAppointment(String doctorId, String appointmentId, DateTime newStartTime, DateTime newEndTime) async {
    return await _remoteDataSource.rescheduleAppointment(doctorId, appointmentId, newStartTime, newEndTime);
  }

  @override
  ResultFuture<List<Schedule>> getSchedules(String doctorId) async {
    return await _remoteDataSource.getSchedules(doctorId);
  }

  @override
  ResultFuture<List<Schedule>> getSchedulesByClinic(String doctorId) async {
    return await _remoteDataSource.getSchedulesByClinic(doctorId);
  }

  @override
  ResultFuture<List<Schedule>> getSchedulesByDoctor(String doctorId) async {
    return await _remoteDataSource.getSchedulesByDoctor(doctorId);
  }

  @override
  ResultFuture<Schedule> getSchedule(String doctorId, String scheduleId) async {
    return await _remoteDataSource.getSchedule(doctorId, scheduleId);
  }

  @override
  ResultFuture<Schedule> createSchedule(String doctorId, Schedule schedule) async {
    return await _remoteDataSource.createSchedule(doctorId, schedule);
  }

  @override
  ResultFuture<Schedule> updateSchedule(String doctorId, Schedule schedule) async {
    return await _remoteDataSource.updateSchedule(doctorId, schedule);
  }

  @override
  ResultVoid deleteSchedule(String doctorId, String scheduleId) async {
    return await _remoteDataSource.deleteSchedule(doctorId, scheduleId);
  }
}