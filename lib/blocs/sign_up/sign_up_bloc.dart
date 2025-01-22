import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_style_mobile/src/data/model/auth_response/auth_response.dart';
import 'package:pet_style_mobile/src/domain/repository/auth_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepository;
  SignUpBloc(this.authRepository) : super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess());
      try {
        final AuthResponse? authResponse = await authRepository.register(
          event.name,
          event.email,
          event.password,
        );

        if (authResponse == null) {
          emit(SignUpFailure(message: 'Что-то пошло не так, попробуйте позже'));
          emit(SignUpInitial());
          return;
        }

        emit(SignUpSuccess());
      } catch (e) {
        log(e.toString());
        emit(SignUpFailure(message: e.toString()));
        emit(SignUpInitial());
      }
    });
  }
}
