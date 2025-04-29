class ApiEndpoints {
  static const String baseUrl = 'http://128.140.39.237/api/v1';

  // Doctor endpoints
  static const String doctors = '/doctors/';
  static const String register = '/doctors/register/';
  static const String me = '/doctors/me/';

  // Appointment endpoints
  static String appointments(String doctorId) => '/doctors/$doctorId/appointments/';
  static String pastAppointments(String doctorId) => '/doctors/$doctorId/appointments/past/';
  static String todayAppointments(String doctorId) => '/doctors/$doctorId/appointments/today/';
  static String upcomingAppointments(String doctorId) => '/doctors/$doctorId/appointments/upcoming/';
  static String appointment(String doctorId, String appointmentId) => '/doctors/$doctorId/appointments/$appointmentId/';
  static String cancelAppointment(String doctorId, String appointmentId) => '/doctors/$doctorId/appointments/$appointmentId/cancel/';
  static String completeAppointment(String doctorId, String appointmentId) => '/doctors/$doctorId/appointments/$appointmentId/complete/';
  static String confirmAppointment(String doctorId, String appointmentId) => '/doctors/$doctorId/appointments/$appointmentId/confirm/';
  static String noShowAppointment(String doctorId, String appointmentId) => '/doctors/$doctorId/appointments/$appointmentId/no_show/';
  static String rescheduleAppointment(String doctorId, String appointmentId) => '/doctors/$doctorId/appointments/$appointmentId/reschedule/';

  // Schedule endpoints
  static String schedules(String doctorId) => '/doctors/$doctorId/schedules/';
  static String schedule(String doctorId, String scheduleId) => '/doctors/$doctorId/schedules/$scheduleId/';
  static String schedulesByClinic(String doctorId) => '/doctors/$doctorId/schedules/by_clinic/';
  static String schedulesByDoctor(String doctorId) => '/doctors/$doctorId/schedules/by_doctor/';

  // Time slots endpoints
  static String timeSlots(String doctorId) => '/doctors/$doctorId/time-slots/';
  static String availableTimeSlots(String doctorId) => '/doctors/$doctorId/time-slots/available/';
  static String generateTimeSlots(String doctorId) => '/doctors/$doctorId/time-slots/generate/';
  static String timeSlot(String doctorId, String timeSlotId) => '/doctors/$doctorId/time-slots/$timeSlotId/';

  // Doctor profile related endpoints
  static String certifications(String doctorId) => '/doctors/$doctorId/certifications/';
  static String certification(String doctorId, String certificationId) => '/doctors/$doctorId/certifications/$certificationId/';
  static String education(String doctorId) => '/doctors/$doctorId/education/';
  static String educationItem(String doctorId, String educationId) => '/doctors/$doctorId/education/$educationId/';
  static String workExperience(String doctorId) => '/doctors/$doctorId/work-experience/';
  static String workExperienceItem(String doctorId, String workExperienceId) => '/doctors/$doctorId/work-experience/$workExperienceId/';

  // Insurance endpoints
  static String addInsurance(String doctorId) => '/doctors/$doctorId/add_insurance/';
  static String removeInsurance(String doctorId) => '/doctors/$doctorId/remove_insurance/';
}