
import 'package:pet_style_mobile/src/data/model/appointment/hw_day_of_week_appointmen.dart';
import 'package:pet_style_mobile/src/data/model/appointment/time_slot_appointment.dart';

abstract interface class AppointmentRepository {
  Future<HwDayOfWeekAppointmen> getAvailableDaysOfWeek(String groomerId);
  Future<TimeSlotAppointment> getAvailableTimeSlots(String date, String groomerId);
}
