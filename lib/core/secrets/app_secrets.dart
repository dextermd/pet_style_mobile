class AppSecrets {
  //static const baseUrl = 'http://192.168.18.127:3000'; // RD Home
  static const String baseUrl = 'http://192.168.94.23:3000'; // RD Office
  
  //static const String wsBaseUrl = 'http://192.168.18.127:3002'; // RD Home
  static const String wsBaseUrl = 'http://192.168.94.23:3002'; // RD Offi§ce

  // Auth
  static const String loginUrl = "$baseUrl/api/auth/login";
  static const String registerUrl = "$baseUrl/api/auth/register";
  static const String googleSignInUrl = "$baseUrl/api/auth/google";
  static const String refreshTokenUrl = "$baseUrl/api/auth/refresh";

  // Users
  static const String meUrl = "$baseUrl/api/users/me";
  static const String usersUrl = "$baseUrl/api/users";

  // Pets
  static const String petsUrl = "$baseUrl/api/pets";

  // Appointments
  static const String availableDaysOfWeekUrl =
      "$baseUrl/api/appointments/available-days-of-week";
  static const String availableSlotsUrl =
      "$baseUrl/api/appointments/available-slots";
}
