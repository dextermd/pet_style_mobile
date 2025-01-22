import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_style_mobile/src/data/model/pet/pet.dart';
import 'package:pet_style_mobile/src/data/model/user/user.dart';
import 'package:pet_style_mobile/src/domain/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  UserBloc(this._userRepository)
      : super(UserInitial()) {
    on<FetchUserData>((event, emit) async {
      if (state is! UserLoaded) {
        emit(UserLoading());
      }
      try {
        final user = await _userRepository.getUserData();
        final List<Pet> pets = user?.pets?.toList() ?? [];

        if (user != null) {
          emit(UserLoaded(user, pets));
        } else {
          emit(const UserError('Failed to load user data'));
        }
      } catch (e) {
        emit(UserError(e.toString()));
      } finally {
        event.completer?.complete();
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

    on<UpdateUserDataEvent>((event, emit) async {
      try {
        await _userRepository.updateUserData(event.user, event.newPassword);
        emit(UserUpdated());
      } catch (e) {
        emit(UpdateUserDataError(e.toString()));
      }
    });

    on<UpdateImageEvent>((event, emit) async {
      try {
        await _userRepository.updateImage(event.image);
        emit(ImageUpdated());
      } catch (e) {
        emit(UpdateImageError(e.toString()));
      }
    });
  }
}
