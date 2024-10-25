import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_style_mobile/src/data/model/appointment/appointment.dart';
import 'package:pet_style_mobile/src/data/model/pet/pet.dart';
import 'package:pet_style_mobile/src/data/model/user/user.dart';
import 'package:pet_style_mobile/src/domain/repository/appointment_repository.dart';
import 'package:pet_style_mobile/src/domain/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  final AppointmentRepository _appointmentRepository;
  UserBloc(this._userRepository, this._appointmentRepository)
      : super(UserInitial()) {
    on<FetchUserData>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await _userRepository.getUserData();
        final List<Appointment> activeAppointments =
            await _appointmentRepository.getActiveAppointmentsByUser();
        final List<Pet> pets = user?.pets?.toList() ?? [];

        if (user != null) {
          emit(UserLoaded(user, pets, activeAppointments));
        } else {
          emit(const UserError('Failed to load user data'));
        }
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<GetSenderUserEvent>((event, emit) async {
      emit(SenderLoading());
      try {
        final user =
            await _userRepository.getUserById(event.senderId.toString());
        if (user != null) {
          emit(SenderLoaded(user));
        } else {
          emit(const UserError('Failed to load user data'));
        }
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
