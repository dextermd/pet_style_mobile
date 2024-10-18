import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_slot_appointment.freezed.dart';
part 'time_slot_appointment.g.dart';

@freezed
class TimeSlotAppointment with _$TimeSlotAppointment {
    const factory TimeSlotAppointment({
        List<String>? allTimeSlot,
        List<String>? availableTimeSlot,
    }) = _TimeSlotAppointment;

      factory TimeSlotAppointment.fromJson(Map<String, Object?> json)
      => _$TimeSlotAppointmentFromJson(json);
}
