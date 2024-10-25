import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pet_style_mobile/src/data/model/groomer/groomer.dart';
import 'package:pet_style_mobile/src/data/model/pet/pet.dart';
import 'package:pet_style_mobile/src/data/model/user/user.dart';

part 'appointment.freezed.dart';
part 'appointment.g.dart';

@freezed
class Appointment with _$Appointment {
  const factory Appointment({
    @JsonKey(name: 'appointment_date') DateTime? appointmentDate,
    String? location,
    int? status,
    @JsonKey(name: 'userId', toJson: _userToJson) User? user,
    @JsonKey(name: 'petId', toJson: _petToJson) Pet? pet,
    @JsonKey(name: 'groomerId', toJson: _groomerToJson) Groomer? groomer,
  }) = _Appointment;

  factory Appointment.fromJson(Map<String, Object?> json) =>
      _$AppointmentFromJson(json);
}

String? _userToJson(User? user) => user?.id;
String? _petToJson(Pet? pet) => pet?.id;
String? _groomerToJson(Groomer? groomer) => groomer?.id;
