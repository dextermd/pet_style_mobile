import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment.freezed.dart';
part 'appointment.g.dart';

@freezed
class Appointment with _$Appointment {
  const factory Appointment({
    @JsonKey(name: 'appointment_date')  DateTime? appointmentDate,
    String? location,
    int? status,
    String? userId,
    String? petId,
    String? groomerId,
  }) = _Appointment;

  factory Appointment.fromJson(Map<String, Object?> json) =>
      _$AppointmentFromJson(json);
}

