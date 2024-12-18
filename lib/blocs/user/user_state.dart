part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
  final User user;
  final List<Pet> pets;
  final List<Appointment> activeAppointments;
  const UserLoaded(this.user, this.pets, this.activeAppointments);

  @override
  List<Object> get props => [user, pets, ];
}

final class UserError extends UserState {
  final String message;
  const UserError(this.message);
}

final class SenderLoading extends UserState {}

final class SenderLoaded extends UserState {
  final User user;
  const SenderLoaded(this.user);

  @override
  List<Object> get props => [user];
}

final class UpdateUserDataError extends UserState {
  final String message;
  const UpdateUserDataError(this.message);
}

final class UserUpdated extends UserState {}

final class UpdateImageError extends UserState {
  final String message;
  const UpdateImageError(this.message);
}

final class ImageUpdated extends UserState {}
