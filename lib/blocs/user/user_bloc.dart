import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pet_style_mobile/core/services/storage_services.dart';
import 'package:pet_style_mobile/core/values/constants.dart';
import 'package:pet_style_mobile/src/data/model/pet/pet.dart';
import 'package:pet_style_mobile/src/data/model/user/user.dart';
import 'package:pet_style_mobile/src/domain/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  final StorageServices _storageServices = GetIt.I<StorageServices>();
  UserBloc(this.userRepository) : super(UserInitial()) {

    on<FetchUserData>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await userRepository.getUserData();
        final List<Pet> pets = user?.pets?.toList() ?? [];
        if (user != null) {
          _storageServices.setString(AppConstants.STORAGE_USER_ID, user.id ?? '');
          emit(UserLoaded(user, pets));
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
        final user = await userRepository.getUserById(event.senderId.toString());
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
