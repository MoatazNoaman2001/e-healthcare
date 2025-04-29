import 'dart:developer';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/endpoints.dart';
import '../../../../core/utils/typedefs.dart';
import '../../domain/entities/doctor.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/entities/schedule.dart';
import '../models/doctor_model.dart';
import '../models/appointment_model.dart';
import '../models/schedule_model.dart';

abstract class DoctorRemoteDataSource {
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

class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  final ApiClient _apiClient;

  DoctorRemoteDataSourceImpl(this._apiClient);

  @override
  ResultFuture<Doctor> getMyProfile() async {
    return await _apiClient.request<Doctor>(
      endpoint: ApiEndpoints.me,
      method: RequestMethod.get,
      fromJson: (json) => DoctorModel.fromJson(json),
    );
  }

  @override
  ResultFuture<Doctor> getDoctorProfile(String doctorId) async {
    return await _apiClient.request<Doctor>(
      endpoint: '${ApiEndpoints.doctors}$doctorId/',
      method: RequestMethod.get,
      fromJson: (json) => DoctorModel.fromJson(json),
    );
  }

  @override
  ResultFuture<Doctor> updateDoctorProfile(Doctor doctor) async {
    final doctorModel = doctor as DoctorModel;
    return await _apiClient.request<Doctor>(
      endpoint: '${ApiEndpoints.doctors}${doctor.id}/',
      method: RequestMethod.patch,
      data: doctorModel.toJson(),
      fromJson: (json) => DoctorModel.fromJson(json),
    );
  }

  @override
  ResultFuture<Doctor> registerDoctor(Doctor doctor, String password) async {
    final doctorModel = doctor as DoctorModel;
    var data = doctorModel.toJson();
    data['password'] = password;

    return await _apiClient.request<Doctor>(
      endpoint: ApiEndpoints.register,
      method: RequestMethod.post,
      data: data,
      fromJson: (json) => DoctorModel.fromJson(json),
    );
  }

  @override
  ResultFuture<List<Appointment>> getAppointments(String doctorId) async {
    return await _apiClient.request<List<Appointment>>(
      endpoint: ApiEndpoints.appointments(doctorId),
      method: RequestMethod.get,
      fromJson: (json) {
        final List<dynamic> appointmentList = json;
        return appointmentList
            .map((appointment) => AppointmentModel.fromJson(appointment))
            .toList();
      },
    );
  }

  @override
  ResultFuture<List<Appointment>> getPastAppointments(String doctorId) async {
    log('Getting past appointments for doctor $doctorId');
    return await _apiClient.request<List<Appointment>>(
      endpoint: ApiEndpoints.pastAppointments(doctorId),
      method: RequestMethod.get,
      fromJson: (json) {
        final List<dynamic> appointmentList = json;
        return appointmentList
            .map((appointment) => AppointmentModel.fromJson(appointment))
            .toList();
      },
    );
  }

  @override
  ResultFuture<List<Appointment>> getTodayAppointments(String doctorId) async {
    return await _apiClient.request<List<Appointment>>(
      endpoint: ApiEndpoints.todayAppointments(doctorId),
      method: RequestMethod.get,
      fromJson: (json) {
        final List<dynamic> appointmentList = json;
        return appointmentList
            .map((appointment) => AppointmentModel.fromJson(appointment))
            .toList();
      },
    );
  }

  @override
  ResultFuture<List<Appointment>> getUpcomingAppointments(
      String doctorId) async {
    return await _apiClient.request<List<Appointment>>(
      endpoint: ApiEndpoints.upcomingAppointments(doctorId),
      method: RequestMethod.get,
      fromJson: (json) {
        final List<dynamic> appointmentList = json;
        return appointmentList
            .map((appointment) => AppointmentModel.fromJson(appointment))
            .toList();
      },
    );
  }

  @override
  ResultFuture<Appointment> getAppointment(String doctorId,
      String appointmentId) async {
    return await _apiClient.request<Appointment>(
      endpoint: ApiEndpoints.appointment(doctorId, appointmentId),
      method: RequestMethod.get,
      fromJson: (json) => AppointmentModel.fromJson(json),
    );
  }

  @override
  ResultFuture<Appointment> createAppointment(String doctorId,
      Appointment appointment) async {
    final appointmentModel = appointment as AppointmentModel;
    return await _apiClient.request<Appointment>(
      endpoint: ApiEndpoints.appointments(doctorId),
      method: RequestMethod.post,
      data: appointmentModel.toJson(),
      fromJson: (json) => AppointmentModel.fromJson(json),
    );
  }

  @override
  ResultFuture<Appointment> updateAppointment(String doctorId, Appointment appointment) async {
    final appointmentModel = appointment as AppointmentModel;
    return await _apiClient.request<Appointment>(
      endpoint: ApiEndpoints.appointment(doctorId, appointment.id),
      method: RequestMethod.patch,
      data: appointmentModel.toJson(),
      fromJson: (json) => AppointmentModel.fromJson(json),
    );
  }

  @override
  ResultVoid deleteAppointment(String doctorId, String appointmentId) async {
    return await _apiClient.request<void>(
      endpoint: ApiEndpoints.appointment(doctorId, appointmentId),
      method: RequestMethod.delete,
    );
  }

  @override
  ResultFuture<Appointment> cancelAppointment(String doctorId, String appointmentId) async {
    return await _apiClient.request<Appointment>(
      endpoint: ApiEndpoints.cancelAppointment(doctorId, appointmentId),
      method: RequestMethod.post,
      fromJson: (json) => AppointmentModel.fromJson(json),
    );
  }

  @override
  ResultFuture<Appointment> completeAppointment(String doctorId, String appointmentId) async {
    return await _apiClient.request<Appointment>(
      endpoint: ApiEndpoints.completeAppointment(doctorId, appointmentId),
      method: RequestMethod.post,
      fromJson: (json) => AppointmentModel.fromJson(json),
    );
  }

  @override
  ResultFuture<Appointment> confirmAppointment(String doctorId, String appointmentId) async {
    return await _apiClient.request<Appointment>(
      endpoint: ApiEndpoints.confirmAppointment(doctorId, appointmentId),
      method: RequestMethod.post,
      fromJson: (json) => AppointmentModel.fromJson(json),
    );
  }

  @override
  ResultFuture<Appointment> markNoShow(String doctorId, String appointmentId) async {
    return await _apiClient.request<Appointment>(
      endpoint: ApiEndpoints.noShowAppointment(doctorId, appointmentId),
      method: RequestMethod.post,
      fromJson: (json) => AppointmentModel.fromJson(json),
    );
  }

  @override
  ResultFuture<Appointment> rescheduleAppointment(String doctorId, String appointmentId, DateTime newStartTime, DateTime newEndTime) async {
    return await _apiClient.request<Appointment>(
      endpoint: ApiEndpoints.rescheduleAppointment(doctorId, appointmentId),
      method: RequestMethod.post,
      data: {
        'start_time': newStartTime.toIso8601String(),
        'end_time': newEndTime.toIso8601String(),
      },
      fromJson: (json) => AppointmentModel.fromJson(json),
    );
  }
  @override
  ResultFuture<List<Schedule>> getSchedules(String doctorId) async {
    return await _apiClient.request<List<Schedule>>(
      endpoint: ApiEndpoints.schedules(doctorId),
      method: RequestMethod.get,
      fromJson: (json) {
        final List<dynamic> scheduleList = json;
        return scheduleList
            .map((schedule) => ScheduleModel.fromJson(schedule))
            .toList();
      },
    );
  }

  @override
  ResultFuture<List<Schedule>> getSchedulesByClinic(String doctorId) async {
    return await _apiClient.request<List<Schedule>>(
      endpoint: ApiEndpoints.schedulesByClinic(doctorId),
      method: RequestMethod.get,
      fromJson: (json) {
        final List<dynamic> scheduleList = json;
        return scheduleList
            .map((schedule) => ScheduleModel.fromJson(schedule))
            .toList();
      },
    );
  }

  @override
  ResultFuture<List<Schedule>> getSchedulesByDoctor(String doctorId) async {
    return await _apiClient.request<List<Schedule>>(
      endpoint: ApiEndpoints.schedulesByDoctor(doctorId),
      method: RequestMethod.get,
      fromJson: (json) {
        final List<dynamic> scheduleList = json;
        return scheduleList
            .map((schedule) => ScheduleModel.fromJson(schedule))
            .toList();
      },
    );
  }

  @override
  ResultFuture<Schedule> getSchedule(String doctorId, String scheduleId) async {
    return await _apiClient.request<Schedule>(
      endpoint: ApiEndpoints.schedule(doctorId, scheduleId),
      method: RequestMethod.get,
      fromJson: (json) => ScheduleModel.fromJson(json),
    );
  }

  @override
  ResultFuture<Schedule> createSchedule(String doctorId, Schedule schedule) async {
    final scheduleModel = schedule as ScheduleModel;
    return await _apiClient.request<Schedule>(
      endpoint: ApiEndpoints.schedules(doctorId),
      method: RequestMethod.post,
      data: scheduleModel.toJson(),
      fromJson: (json) => ScheduleModel.fromJson(json),
    );
  }

  @override
  ResultFuture<Schedule> updateSchedule(String doctorId, Schedule schedule) async {
    final scheduleModel = schedule as ScheduleModel;
    return await _apiClient.request<Schedule>(
      endpoint: ApiEndpoints.schedule(doctorId, schedule.id),
      method: RequestMethod.patch,
      data: scheduleModel.toJson(),
      fromJson: (json) => ScheduleModel.fromJson(json),
    );
  }

  @override
  ResultVoid deleteSchedule(String doctorId, String scheduleId) async {
    return await _apiClient.request<void>(
      endpoint: ApiEndpoints.schedule(doctorId, scheduleId),
      method: RequestMethod.delete,
    );
  }
}