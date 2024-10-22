part of 'otp_bloc.dart';

sealed class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object> get props => [];
}

final class OtpInitial extends OtpState {}

final class OtpSent extends OtpState {
  final String phone;
  const OtpSent(this.phone);

  @override
  List<Object> get props => [phone];
}

final class OtpSentError extends OtpState {
  final String message;
  const OtpSentError(this.message);

  @override
  List<Object> get props => [message];
}

final class OtpVerifyError extends OtpState {
  final String message;
  const OtpVerifyError(this.message);

  @override
  List<Object> get props => [message];
}

final class PhoneNumberUpdated extends OtpState {}

final class PhoneNumberUpdateError extends OtpState {
  final String message;
  const PhoneNumberUpdateError(this.message);

  @override
  List<Object> get props => [message];
}
