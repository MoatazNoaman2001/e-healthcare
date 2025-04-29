import 'package:fpdart/fpdart.dart';

import '../../../../core/utils/typedefs.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/entities/doctor.dart';
import '../entities/schedule.dart';

abstract class DoctorRepository {
  // Doctor profile
  ResultFuture<Doctor> getMyProfile();
  ResultFuture<Doctor> getDoctorProfile(String doctorId);
  ResultFuture<Doctor> updateDoctorProfile(Doctor doctor);
  ResultFuture<Doctor> registerDoctor(Doctor doctor, String password);

  // Appointments
  ResultFuture<List<Appointment>> getAppointments(String doctorId);
  ResultFuture<List<Appointment>> getPastAppointments(String doctorId);
  ResultFuture<List<Appointment>> getTodayAppointments(String doctorId);
  ResultFuture<List<Appointment>> getUpcomingAppointments(String doctorId);
  ResultFuture<Appointment> getAppointment(String doctorId, String appointmentId);
  ResultFuture<Appointment> createAppointment(String doctorId, Appointment appointment);
  ResultFuture<Appointment> updateAppointment(String doctorId, Appointment appointment);
  ResultVoid deleteAppointment(String doctorId, String appointmentId);
  ResultFuture<Appointment> cancelAppointment(String doctorId, String appointmentId);
  ResultFuture<Appointment> completeAppointment(String doctorId, String appointmentId);
  ResultFuture<Appointment> confirmAppointment(String doctorId, String appointmentId);
  ResultFuture<Appointment> markNoShow(String doctorId, String appointmentId);
  ResultFuture<Appointment> rescheduleAppointment(String doctorId, String appointmentId, DateTime newStartTime, DateTime newEndTime);

  // Schedule related methods
  ResultFuture<List<Schedule>> getSchedules(String doctorId);
  ResultFuture<List<Schedule>> getSchedulesByClinic(String doctorId);
  ResultFuture<List<Schedule>> getSchedulesByDoctor(String doctorId);
  ResultFuture<Schedule> getSchedule(String doctorId, String scheduleId);
  ResultFuture<Schedule> createSchedule(String doctorId, Schedule schedule);
  ResultFuture<Schedule> updateSchedule(String doctorId, Schedule schedule);
  ResultVoid deleteSchedule(String doctorId, String scheduleId);

}