class AppSecrets {
  static const baseUrl = 'http://192.168.18.127:3000'; // RD Home
  //static const String baseUrl = 'http://192.168.94.20:3000'; // RD Office

  static const String wsBaseUrl = 'http://192.168.18.127:3002'; // RD Home
  //static const String wsBaseUrl = 'http://192.168.94.20:3002'; // RD Offi§ce

  // Auth
  static const String loginUrl = "$baseUrl/api/auth/login";
  static const String registerUrl = "$baseUrl/api/auth/register";
  static const String googleSignInUrl = "$baseUrl/api/auth/google";
  static const String refreshTokenUrl = "$baseUrl/api/auth/refresh";

  // Users
  static const String meUrl = "$baseUrl/api/users/me";
  static const String usersUrl = "$baseUrl/api/users";
  static const String checkPhone = "$baseUrl/api/users/check-phone";
  static const String updatePhone = "$baseUrl/api/users/update-phone";

  // Pets
  static const String petsUrl = "$baseUrl/api/pets";

  // Appointments
  static const String appointmentUrl = "$baseUrl/api/appointments";
  static const String availableDaysOfWeekUrl =
      "$baseUrl/api/appointments/available-days-of-week";
  static const String availableSlotsUrl =
      "$baseUrl/api/appointments/available-slots";
  static const String createAppointmentUrl =
      "$baseUrl/api/appointments/create-appointment";
  static const String checkAppointmentUrl =
      "$baseUrl/api/appointments/check-appointment-by-date-and-pet-id";
  static const String appointmentsByUserUrl =
      "$baseUrl/api/appointments/appointments-by-user";
  static const String activeAppointmentsByUserUrl =
      "$baseUrl/api/appointments/active-appointments-by-user";
  static const String cancelAppointmentUrl =
      "$baseUrl/api/appointments/cancel-appointment";
  static const String isAvailableEditAppointmentUrl =
      "$baseUrl/api/appointments/is-available-edit-appointment";

  // Otp
  static const String sendSmsUrl = "$baseUrl/api/otp/send-sms";
  static const String verifyOtpUrl = "$baseUrl/api/otp/verify-sms";
}
