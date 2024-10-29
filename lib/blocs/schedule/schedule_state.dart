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