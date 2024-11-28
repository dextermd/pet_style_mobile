part of 'appointment_bloc.dart';

sealed class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object> get props => [];
}

class GetAvailableDaysOfWeekEvent extends AppointmentEvent {
  final String groomerId;

  const GetAvailableDaysOfWeekEvent(this.groomerId);

  @override
  List<Object> get props => [groomerId];
}

class GetAvailableTimeSlotsEvent extends AppointmentEvent {
  final String date;
  final String groomerId;

  const GetAvailableTimeSlotsEvent(this.date, this.groomerId);

  @override
  List<Object> get props => [date, groomerId];
}

class InitDatesEvent extends AppointmentEvent {
  final HwDayOfWeekAppointmen hwDayOfWeekAppointmen;

  const InitDatesEvent(this.hwDayOfWeekAppointmen);

  @override
  List<Object> get props => [hwDayOfWeekAppointmen];
}

class GetPetsProfleEvent extends AppointmentEvent {
  final bool isHomeAppointment;

  const GetPetsProfleEvent(this.isHomeAppointment);

  @override
  List<Object> get props => [];
}

class CheckPhoneNumberEvent extends AppointmentEvent {
  const CheckPhoneNumberEvent();
  @override
  List<Object> get props => [];
}

class CreateAppointmentEvent extends AppointmentEvent {
  final Appointment appointment;

  const CreateAppointmentEvent(this.appointment);

  @override
  List<Object> get props => [appointment];
}

class AddPhoneNumberExistStateEvent extends AppointmentEvent {}

class CheckIfExistingAppointmentEvent extends AppointmentEvent {
  final String petId;
  final DateTime date;

  const CheckIfExistingAppointmentEvent(this.petId, this.date);

  @override
  List<Object> get props => [petId, date];
}

// update appointment
class UpdateAppointmentEvent extends AppointmentEvent {
  final String id;
  final Appointment appointment;

  const UpdateAppointmentEvent(this.id, this.appointment);

  @override
  List<Object> get props => [appointment];
}

class SendNotificationToGroomerEvent extends AppointmentEvent {
  final String groomerId;
  final String title;
  final String body;

  const SendNotificationToGroomerEvent(this.groomerId, this.title, this.body);

  @override
  List<Object> get props => [groomerId, title, body];
}