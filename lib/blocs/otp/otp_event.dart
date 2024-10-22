part of 'otp_bloc.dart';

sealed class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}

class OtpSendEvent extends OtpEvent {
  final String phoneNumber;

  const OtpSendEvent(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class OtpVerifyEvent extends OtpEvent {
  final String phoneNumber;
  final String otp;

  const OtpVerifyEvent(this.phoneNumber, this.otp);

  @override
  List<Object> get props => [phoneNumber, otp];
}

class UpdatePhoneNumber extends OtpEvent {
  final String phoneNumber;

  const UpdatePhoneNumber(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}