import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  }

  FutureOr<void> _onOtpSend(OtpSendEvent event, Emitter<OtpState> emit) async {
    try {
      await _otpRepository.sendOtp(event.phoneNumber);
      emit(OtpSent(event.phoneNumber));
    } catch (e) {
      emit(OtpSentError(e.toString()));
    }
  }

  FutureOr<void> _onOtpVerify(OtpVerifyEvent event, Emitter<OtpState> emit) async {
    emit(OtpInitial());
    try {
      await _otpRepository.verifyOtp(event.phoneNumber, event.otp);
      add(UpdatePhoneNumber(event.phoneNumber));
    } catch (e) {
      emit(OtpVerifyError(e.toString()));
    }
  }

  FutureOr<void> _onChangePhoneNumber(UpdatePhoneNumber event, Emitter<OtpState> emit) async {
    emit(OtpInitial());
    try {
      await _userRepository.updatePhoneNumber(event.phoneNumber);
      emit(PhoneNumberUpdated());

    } catch (e) {
      emit(OtpSentError(e.toString()));
    }
  }
}
