part of 'appointment_bloc.dart';

sealed class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object> get props => [];
}

class AppointmentGetAvailableDaysOfWeekEvent extends AppointmentEvent {
  final String groomerId;

  const AppointmentGetAvailableDaysOfWeekEvent(this.groomerId);

  @override
  List<Object> get props => [groomerId];
}

class AppointmentGetAvailableTimeSlotsEvent extends AppointmentEvent {
  final String date;
  final String groomerId;

  const AppointmentGetAvailableTimeSlotsEvent(this.date, this.groomerId);

  @override
  List<Object> get props => [date, groomerId];
}

class AppointmentInitDatesEvent extends AppointmentEvent {
  final HwDayOfWeekAppointmen hwDayOfWeekAppointmen;

  const AppointmentInitDatesEvent(this.hwDayOfWeekAppointmen);

  @override
  List<Object> get props => [hwDayOfWeekAppointmen];
}

class AppointmentGetPetsProfleEvent extends AppointmentEvent {
  final bool isHomeAppointment;

  const AppointmentGetPetsProfleEvent(this.isHomeAppointment);

  @override
  List<Object> get props => [];
}
