// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppointmentImpl _$$AppointmentImplFromJson(Map<String, dynamic> json) =>
    _$AppointmentImpl(
      appointmentDate: _fromJsonDate(json['appointment_date'] as String?),
      location: json['location'] as String?,
      status: (json['status'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      pet: json['pet'] == null
          ? null
          : Pet.fromJson(json['pet'] as Map<String, dynamic>),
      groomer: json['groomer'] == null
          ? null
          : Groomer.fromJson(json['groomer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AppointmentImplToJson(_$AppointmentImpl instance) =>
    <String, dynamic>{
      'appointment_date': instance.appointmentDate?.toIso8601String(),
      'location': instance.location,
      'status': instance.status,
      'user': instance.user,
      'pet': instance.pet,
      'groomer': instance.groomer,
    };
