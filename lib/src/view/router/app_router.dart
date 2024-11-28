import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_style_mobile/core/helpers/log_helper.dart';
import 'package:pet_style_mobile/core/services/storage_services.dart';
import 'package:pet_style_mobile/src/data/model/appointment/appointment.dart';
import 'package:pet_style_mobile/src/view/app/appointment/appointment_screen.dart';
import 'package:pet_style_mobile/src/view/app/auth/sign_in/sign_in_screen.dart';
import 'package:pet_style_mobile/src/view/app/auth/sign_up/sign_up_screen.dart';
import 'package:pet_style_mobile/src/view/app/chat/chat_screen.dart';
import 'package:pet_style_mobile/src/view/app/home/home_screen.dart';
import 'package:pet_style_mobile/src/view/app/menu/bottom_navigation.dart';
import 'package:pet_style_mobile/src/view/app/onboarding/onboarding_screen.dart';
import 'package:pet_style_mobile/src/view/app/otp/otp_code/otp_code_screen.dart';
import 'package:pet_style_mobile/src/view/app/otp/phone_verification/phone_verification_screen.dart';
import 'package:pet_style_mobile/src/view/app/pet_form/pet_form_screen.dart';
import 'package:pet_style_mobile/src/view/app/schedule/schedule_screen.dart';
import 'package:pet_style_mobile/src/view/app/setting/edit_profile/edit_profile_screen.dart';
import 'package:pet_style_mobile/src/view/app/setting/setting_screen.dart';
import 'package:pet_style_mobile/src/view/app/splash/splash_screen.dart';
import 'package:pet_style_mobile/src/view/router/app_routes.dart';

import 'package:talker_flutter/talker_flutter.dart';

final _shellNavigatorKey = GlobalKey<NavigatorState>();
final StorageServices _storageServices = GetIt.I<StorageServices>();
final bool showOnboarding = _storageServices.getDeviceOnboardingOpen();

class AppRouter {
  final router = GoRouter(
    initialLocation: AppRoutes.onboardingPath,
    routes: [
      GoRoute(
        path: AppRoutes.onboardingPath,
        name: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.splashPath,
        name: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.signInPath,
        name: AppRoutes.signIn,
        builder: (context, state) => const SignInScreen(),
        routes: [
          GoRoute(
            path: AppRoutes.signUp,
            name: AppRoutes.signUp,
            builder: (context, state) => const SignUpScreen(),
          ),
        ],
      ),
      // GoRoute(
      //   path: AppRoutes.noInternetPath,
      //   name: AppRoutes.noInternet,
      //   builder: (context, state) => NoInternetScreen(
      //     onRetry: () {
      //       context.go(state.extra as String? ?? '/');
      //     },
      //   ),
      // ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => BottomNavigation(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.homePath,
            name: AppRoutes.home,
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: AppRoutes.petForm,
                name: AppRoutes.petForm,
                builder: (context, state) =>
                    PetFormScreen(id: state.extra as String?),
                parentNavigatorKey: _shellNavigatorKey,
              ),
              GoRoute(
                path: AppRoutes.appointment,
                name: AppRoutes.appointment,
                builder: (context, state) => const AppointmentScreen(),
                parentNavigatorKey: _shellNavigatorKey,
                routes: [
                  GoRoute(
                    path: AppRoutes.phoneVerification,
                    name: AppRoutes.phoneVerification,
                    builder: (context, state) =>
                        const PhoneVerificationScreen(),
                    routes: [
                      GoRoute(
                        path: AppRoutes.otpCode,
                        name: AppRoutes.otpCode,
                        builder: (context, state) => OtpCodeScreen(
                          phone: state.extra as String,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.schedulePath,
            name: AppRoutes.schedule,
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const ScheduleScreen(),
            routes: [
              GoRoute(
                  path: AppRoutes.editSchedule,
                  name: AppRoutes.editSchedule,
                  builder: (context, state) {
                    final Appointment? editAppointment =
                        state.extra as Appointment?;
                    return AppointmentScreen(editAppointment: editAppointment);
                  }),
            ],
          ),
          GoRoute(
            path: AppRoutes.chatPath,
            name: AppRoutes.chat,
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const ChatScreen(),
          ),
          GoRoute(
            path: AppRoutes.settingPath,
            name: AppRoutes.setting,
            builder: (context, state) => const SettingScreen(),
            routes: [
              GoRoute(
                path: AppRoutes.editProfile,
                name: AppRoutes.editProfile,
                builder: (context, state) => const EditProfileScreen(),
              ),
            ],
          ),
        ],
      )
    ],
    observers: [TalkerRouteObserver(GetIt.I<Talker>())],
    redirect: (context, state) async {
      bool isLoggedIn = _storageServices.getIsLoggedIn();
      logDebug(state.matchedLocation);

      final protectedRoutes = [
        AppRoutes.homePath,
        AppRoutes.schedulePath,
        AppRoutes.chatPath,
        AppRoutes.settingPath,
        AppRoutes.appointmentPath,
        AppRoutes.petFormPath,
        AppRoutes.phoneVerificationPath,
        AppRoutes.otpCodePath,
        AppRoutes.editSchedulePath,
        AppRoutes.editProfilePath,
      ];
      if (!isLoggedIn && protectedRoutes.contains(state.matchedLocation)) {
        return AppRoutes.signInPath;
      }

      if (state.matchedLocation == AppRoutes.onboardingPath &&
          !showOnboarding) {
        if (isLoggedIn && state.matchedLocation == AppRoutes.onboardingPath) {
          return AppRoutes.splashPath;
        } else {
          return AppRoutes.signInPath;
        }
      }
      return null;
    },
  );
}
