import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pet_style_mobile/blocs/appointment/appointment_bloc.dart';
import 'package:pet_style_mobile/blocs/chat/chat_bloc.dart';
import 'package:pet_style_mobile/blocs/faq/faq_bloc.dart';
import 'package:pet_style_mobile/blocs/localization/localization_bloc.dart';
import 'package:pet_style_mobile/blocs/onboarding_bloc/onboarding_bloc.dart';
import 'package:pet_style_mobile/blocs/otp/otp_bloc.dart';
import 'package:pet_style_mobile/blocs/pet_form/pet_form_bloc.dart';
import 'package:pet_style_mobile/blocs/promotion/promotion_bloc.dart';
import 'package:pet_style_mobile/blocs/schedule/schedule_bloc.dart';
import 'package:pet_style_mobile/blocs/service/service_bloc.dart';
import 'package:pet_style_mobile/blocs/sign_in/sign_in_bloc.dart';
import 'package:pet_style_mobile/blocs/sign_up/sign_up_bloc.dart';
import 'package:pet_style_mobile/blocs/user/user_bloc.dart';
import 'package:pet_style_mobile/core/services/socket_service.dart';
import 'package:pet_style_mobile/src/domain/repository/appointment_repository.dart';
import 'package:pet_style_mobile/src/domain/repository/auth_repository.dart';
import 'package:pet_style_mobile/src/domain/repository/faq_repository.dart';
import 'package:pet_style_mobile/src/domain/repository/otp_repository.dart';
import 'package:pet_style_mobile/src/domain/repository/pet_repository.dart';
import 'package:pet_style_mobile/src/domain/repository/promotion_repository.dart';
import 'package:pet_style_mobile/src/domain/repository/service_repository.dart';
import 'package:pet_style_mobile/src/domain/repository/user_repository.dart';

class AppBlocProviders {
  static get allBlocProviders => [
        BlocProvider(
          lazy: true,
          create: (context) => LocalizationBloc()..add(GetLanguage()),
        ),
        BlocProvider<OnboardingBloc>(
          lazy: true,
          create: (context) => OnboardingBloc(),
        ),
        BlocProvider<SignInBloc>(
          lazy: true,
          create: (context) => SignInBloc(
            GetIt.I<AuthRepository>(),
          ),
        ),
        BlocProvider<SignUpBloc>(
          lazy: true,
          create: (context) => SignUpBloc(
            GetIt.I<AuthRepository>(),
          ),
        ),
        BlocProvider<UserBloc>(
          lazy: true,
          create: (context) => UserBloc(
            GetIt.I<UserRepository>(),
          )..add(FetchUserData()),
        ),
        BlocProvider<PetFormBloc>(
          lazy: true,
          create: (context) => PetFormBloc(
            GetIt.I<PetRepository>(),
          ),
        ),
        BlocProvider<AppointmentBloc>(
          lazy: true,
          create: (context) => AppointmentBloc(
            GetIt.I<AppointmentRepository>(),
            GetIt.I<UserRepository>(),
          ),
        ),
        BlocProvider<ChatBloc>(
          lazy: true,
          create: (context) => ChatBloc(
            GetIt.I<SocketService>(),
          ),
        ),
        BlocProvider<OtpBloc>(
          lazy: true,
          create: (context) => OtpBloc(
            GetIt.I<UserRepository>(),
            GetIt.I<OtpRepository>(),
          ),
        ),
        BlocProvider<ScheduleBloc>(
          lazy: true,
          create: (context) => ScheduleBloc(
            GetIt.I<AppointmentRepository>(),
          )..add(ScheduleLoad()),
        ),
        BlocProvider<FaqBloc>(
          lazy: true,
          create: (context) => FaqBloc(
            GetIt.I<FaqRepository>(),
          ),
        ),
        BlocProvider<PromotionBloc>(
          lazy: true,
          create: (context) => PromotionBloc(
            GetIt.I<PromotionRepository>(),
          ),
        ),
        BlocProvider<ServiceBloc>(
          lazy: true,
          create: (context) => ServiceBloc(
            GetIt.I<ServiceRepository>(),
          ),
        ),
      ];
}
