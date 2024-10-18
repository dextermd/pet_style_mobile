part of 'appointment_bloc.dart';

sealed class AppointmentState extends Equatable {
  const AppointmentState();

  static List<Pet> pets = [];
  static List<DateTime> activeDates = [];
  static TimeSlotAppointment timeSlotAppointment =
      const TimeSlotAppointment(availableTimeSlot: [], allTimeSlot: []);

  @override
  List<Object> get props => [];
}

final class AppointmentInitial extends AppointmentState {}

final class AppointmentAvailableSlotsLoading extends AppointmentState {}

final class AppointmentAvailableSlotsError extends AppointmentState {
  final String message;

  const AppointmentAvailableSlotsError(this.message);

  @override
  List<Object> get props => [message];
}

final class AppointmentAvailableDaysOfWeekLoading extends AppointmentState {}

final class AppointmentAvailableDaysOfWeekError extends AppointmentState {
  final String message;

  const AppointmentAvailableDaysOfWeekError(this.message);

  @override
  List<Object> get props => [message];
}

final class AppointmentPetsProfileLoading extends AppointmentState {}

final class AppointmentPetsProfileError extends AppointmentState {
  final String message;

  const AppointmentPetsProfileError(this.message);

  @override
  List<Object> get props => [message];
}
