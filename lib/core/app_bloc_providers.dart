import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pet_style_mobile/blocs/appointment/appointment_bloc.dart';
import 'package:pet_style_mobile/blocs/chat/chat_bloc.dart';
import 'package:pet_style_mobile/blocs/onboarding_bloc/onboarding_bloc.dart';
import 'package:pet_style_mobile/blocs/otp/otp_bloc.dart';
import 'package:pet_style_mobile/blocs/pet_form/pet_form_bloc.dart';
import 'package:pet_style_mobile/blocs/sign_in/sign_in_bloc.dart';
import 'package:pet_style_mobile/blocs/sign_up/sign_up_bloc.dart';
import 'package:pet_style_mobile/blocs/user/user_bloc.dart';
import 'package:pet_style_mobile/core/services/socket_service.dart';
import 'package:pet_style_mobile/src/domain/repository/appointment_repository.dart';
import 'package:pet_style_mobile/src/domain/repository/auth_repository.dart';
import 'package:pet_style_mobile/src/domain/repository/chat_repository.dart';
import 'package:pet_style_mobile/src/domain/repository/otp_repository.dart';
import 'package:pet_style_mobile/src/domain/repository/pet_repository.dart';
import 'package:pet_style_mobile/src/domain/repository/user_repository.dart';


class AppBlocProviders {
  static get allBlocProviders => [
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
            GetIt.I<AppointmentRepository>(),
          ),
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
            GetIt.I<ChatRepository>(),
            GetIt.I<SocketService>(),
          ),
        ),
        //otp
        BlocProvider<OtpBloc>(
          lazy: true,
          create: (context) => OtpBloc(
            GetIt.I<UserRepository>(),
            GetIt.I<OtpRepository>(),
          ),
        ),
      ];
}
