import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pet_style_mobile/src/data/model/groomer/groomer.dart';
import 'package:pet_style_mobile/src/data/model/pet/pet.dart';
import 'package:pet_style_mobile/src/data/model/user/user.dart';

part 'appointment.freezed.dart';
part 'appointment.g.dart';

@freezed
class Appointment with _$Appointment {
  const factory Appointment({
    @JsonKey(name: 'appointment_date', fromJson: _fromJsonDate) DateTime? appointmentDate,
    String? location,
    int? status,
    User? user,
    Pet? pet,
    Groomer? groomer,
  }) = _Appointment;

  factory Appointment.fromJson(Map<String, Object?> json) =>
      _$AppointmentFromJson(json);
}

DateTime? _fromJsonDate(String? date) =>
    date != null ? DateTime.parse(date).toLocal() : null;
