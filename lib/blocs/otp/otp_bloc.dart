import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_style_mobile/src/data/model/update_user_request/update_user_request.dart';
import 'package:pet_style_mobile/src/data/model/user/user.dart';
import 'package:pet_style_mobile/src/domain/repository/otp_repository.dart';
import 'package:pet_style_mobile/src/domain/repository/user_repository.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final UserRepository _userRepository;
  final OtpRepository _otpRepository;

  OtpBloc(this._userRepository, this._otpRepository) : super(OtpInitial()) {
    on<OtpSendEvent>(_onOtpSend);
    on<OtpVerifyEvent>(_onOtpVerify);
    on<UpdatePhoneNumber>(_onChangePhoneNumber);
    on<UpdateUserData>(_onUpdateUserData);
  }

  FutureOr<void> _onOtpSend(OtpSendEvent event, Emitter<OtpState> emit) async {
    try {
      await _otpRepository.sendOtp(event.phoneNumber);
      emit(OtpSent(event.phoneNumber));
      emit(OtpInitial());
    } catch (e) {
      emit(OtpSentError(e.toString()));
      emit(OtpInitial());
    }
  }

  FutureOr<void> _onOtpVerify(
      OtpVerifyEvent event, Emitter<OtpState> emit) async {
    emit(OtpInitial());
    try {
      await _otpRepository.verifyOtp(event.phoneNumber, event.otp);
      if (event.updateUserRequest != null) {
        add(
          UpdateUserData(
            event.updateUserRequest!.updateUser!,
            event.updateUserRequest!.newPassword!,
          ),
        );
      } else {
        add(UpdatePhoneNumber(event.phoneNumber));
      }
      emit(OtpInitial());
    } catch (e) {
      emit(OtpVerifyError(e.toString()));
      emit(OtpInitial());
    }
  }

  FutureOr<void> _onUpdateUserData(
      UpdateUserData event, Emitter<OtpState> emit) async {
    emit(OtpInitial());
    try {
      await _userRepository.updateUserData(event.updateUser, event.newPassword);
      emit(OtpUserUpdated());
      emit(OtpInitial());
    } catch (e) {
      emit(OtpUserUpdateError(e.toString()));
      emit(OtpInitial());
    }
  }

  FutureOr<void> _onChangePhoneNumber(
      UpdatePhoneNumber event, Emitter<OtpState> emit) async {
    emit(OtpInitial());
    try {
      await _userRepository.updatePhoneNumber(event.phoneNumber);
      emit(PhoneNumberUpdated());
      emit(OtpInitial());
    } catch (e) {
      emit(OtpSentError(e.toString()));
      emit(OtpInitial());
    }
  }
}
