part of 'schedule_bloc.dart';

sealed class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

final class ScheduleInitial extends ScheduleState {}

final class ScheduleLoading extends ScheduleState {}

final class ScheduleLoaded extends ScheduleState {
  final List<Appointment> active;
  final List<Appointment> completed;
  final List<Appointment> canceled;

  const ScheduleLoaded(this.active, this.completed, this.canceled);

  @override
  List<Object> get props => [active, completed, canceled];
}

final class ScheduleError extends ScheduleState {
  final String message;

  const ScheduleError(this.message);

  @override
  List<Object> get props => [message];
}

final class ScheduleCanceling extends ScheduleState {}

final class ScheduleCanceled extends ScheduleState {}

final class ScheduleCancelError extends ScheduleState {
  final String canceledId;
  final String message;

  const ScheduleCancelError(this.message, this.canceledId);

  @override
  List<Object> get props => [message];
}

final class EditChecking extends ScheduleState {}

final class EditingAvailable extends ScheduleState {
  final Appointment appointment;

  const EditingAvailable(this.appointment);

  @override
  List<Object> get props => [appointment];
}

final class EditingNotAvailable extends ScheduleState {}
