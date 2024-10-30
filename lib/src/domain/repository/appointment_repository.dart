
import 'package:pet_style_mobile/src/data/model/appointment/appointment.dart';
import 'package:pet_style_mobile/src/data/model/appointment/hw_day_of_week_appointmen.dart';
import 'package:pet_style_mobile/src/data/model/appointment/time_slot_appointment.dart';

abstract interface class AppointmentRepository {
  Future<HwDayOfWeekAppointmen> getAvailableDaysOfWeek(String groomerId);
  Future<TimeSlotAppointment> getAvailableTimeSlots(String date, String groomerId);
  Future<void> createAppointment(Appointment appointment);
  Future<List<Appointment>> getAppointmentsByUser();
  Future<List<Appointment>> getActiveAppointmentsByUser();
  Future<bool> isAppointmentExistByDateAndPetId(DateTime date, String petId);
  Future<void> cancelAppointment(String appointmentId);
  Future<Appointment?> isAvailableEditAppointment(String appointmentId);
  Future<void> updateAppointment(String id, Appointment appointment);
}
