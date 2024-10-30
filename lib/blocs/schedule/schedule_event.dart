part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {}

final class ScheduleLoad extends ScheduleEvent {
  final Completer? completer;
  ScheduleLoad({
    this.completer,
  });

  @override
  List<Object?> get props => [completer];
}

final class ScheduleCancelEvent extends ScheduleEvent {
  final String appointmentId;
  ScheduleCancelEvent(this.appointmentId);

  @override
  List<Object?> get props => [appointmentId];
}

// check if edit appointment is available
final class ScheduleEditEvent extends ScheduleEvent {
  final String appointmentId;
  ScheduleEditEvent(this.appointmentId);

  @override
  List<Object?> get props => [appointmentId];
}
