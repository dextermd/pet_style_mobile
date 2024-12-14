import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pet_style_mobile/core/helpers/log_helper.dart';
import 'package:pet_style_mobile/src/data/model/auth_response/auth_response.dart';
import 'package:pet_style_mobile/src/domain/repository/auth_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository _authRepository;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  SignInBloc(this._authRepository) : super(SignInInitial()) {
    on<SignInRequired>((event, emit) async {
      emit(SignInProcess());
      try {
        AuthResponse? authResponse =
            await _authRepository.login(event.email, event.password);
        if (authResponse != null) {
          emit(SignInSuccess());
        }
      } on Exception catch (e, st) {
        emit(const SignInFailure());
        logHandle(e.toString(), st);
      }
    });

    on<GoogleSignInRequired>((event, emit) async {
      emit(SignInProcess());
      try {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser != null) {
          logDebug('$googleUser');

          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;

          logDebug('Google Auth ID Token: ${googleAuth.accessToken}');
          logDebug('Google Auth ID Token: ${googleAuth.idToken}');

          if (googleAuth.idToken == null) {
            emit(const SignInFailure(message: 'Token NULL'));
            await _googleSignIn.signOut();
            return;
          }

          AuthResponse? authResponse =
              await _authRepository.googleSignIn(googleAuth.idToken!);
          if (authResponse != null) {
            emit(SignInSuccess());
          } else {
            emit(const SignInFailure(message: 'Authentication failed'));
            await _googleSignIn.signOut();
          }
        } else {
          emit(const SignInFailure(message: 'Google sign-in canceled'));
          await _googleSignIn.signOut();
        }
      } catch (error, stackTrace) {
        logHandle('GoogleSignInError: $error', stackTrace);
        emit(const SignInFailure(message: 'Google sign-in failed'));
        await _googleSignIn.signOut();
      }
    });
    on<SignOutRequired>((event, emit) async {
      await _authRepository.logOutDB();
    });
  }
}
