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
