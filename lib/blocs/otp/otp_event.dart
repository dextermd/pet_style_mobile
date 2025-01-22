part of 'otp_bloc.dart';

sealed class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object?> get props => [];
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
  final UpdateUserRequest? updateUserRequest;

  const OtpVerifyEvent(this.phoneNumber, this.otp, {this.updateUserRequest});

  @override
  List<Object?> get props => [phoneNumber, otp, updateUserRequest];
}

class UpdateUserData extends OtpEvent {
  final User updateUser;
  final String newPassword;

  const UpdateUserData(this.updateUser, this.newPassword);

  @override
  List<Object> get props => [updateUser, newPassword];
}

class UpdatePhoneNumber extends OtpEvent {
  final String phoneNumber;

  const UpdatePhoneNumber(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}
