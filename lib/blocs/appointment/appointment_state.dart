part of 'appointment_bloc.dart';

sealed class AppointmentState extends Equatable {
  const AppointmentState();

  static List<Pet> pets = [];
  static List<DateTime> activeDates = [];
  static TimeSlotAppointment timeSlotAppointment =
      const TimeSlotAppointment(availableTimeSlot: [], allTimeSlot: []);

  @override
  List<Object> get props => [pets, activeDates, timeSlotAppointment];
}

final class AppointmentInitial extends AppointmentState {}

final class AppointmentError extends AppointmentState {
  final String message;
  const AppointmentError(this.message);

  @override
  List<Object> get props => [message];
}

final class SlotsLoading extends AppointmentState {}

final class SlotsLoaded extends AppointmentState {}

final class SlotsEmpty extends AppointmentState {}

final class AvailableSlotsError extends AppointmentState {
  final String message;

  const AvailableSlotsError(this.message);

  @override
  List<Object> get props => [message];
}

final class AvailableDaysOfWeekLoading extends AppointmentState {}

final class AvailableDaysOfWeekError extends AppointmentState {
  final String message;

  const AvailableDaysOfWeekError(this.message);

  @override
  List<Object> get props => [message];
}

final class PetsProfileLoading extends AppointmentState {}

final class PetsProfileLoaded extends AppointmentState {}

final class PetsProfileError extends AppointmentState {
  final String message;

  const PetsProfileError(this.message);

  @override
  List<Object> get props => [message];
}

final class PhoneNumberEmpty extends AppointmentState {}

final class PhoneNumberExist extends AppointmentState {}

final class CreateAppointmentSuccess extends AppointmentState {}

final class AppointmentExist extends AppointmentState {}

final class AppointmentNotExist extends AppointmentState {}
