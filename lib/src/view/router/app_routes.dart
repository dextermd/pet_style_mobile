class AppRoutes {
  static const String onboarding = 'onboarding';
  static const String onboardingPath = '/onboarding';

  static const String splash = 'splash';
  static const String splashPath = '/splash';

  static const String signIn = 'sign_in';
  static const String signInPath = '/sign_in';

  static const String signUp = 'sign_up';
  static const String signUpPath = '$signInPath/$signUp';

  static const String noInternet = 'no_internet';
  static const String noInternetPath = '/no_internet';

  // ------------------ Authenticated Routes ------------------
  static const String home = 'home';
  static const String homePath = '/home';

  static const String petForm = 'pet_form';
  static const String petFormPath = '$homePath/$petForm';

  static const String appointment = 'appointment';
  static const String appointmentPath = '$homePath/$appointment';

  static const String phoneVerification = 'phone_verification';
  static const String phoneVerificationPath = '$appointmentPath/$phoneVerification';

  static const String otpCode = 'otp_code';
  static const String otpCodePath = '$phoneVerificationPath/$otpCode';

  static const String schedule = 'schedule';
  static const String schedulePath = '/schedule';

  static const String editSchedule = 'edit_schedule';
  static const String editSchedulePath = '$schedulePath/$editSchedule';

  static const String chat = 'chat';
  static const String chatPath = '/chat';

  static const String setting = 'setting';
  static const String settingPath = '/setting';

}
