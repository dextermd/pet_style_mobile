// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppointmentImpl _$$AppointmentImplFromJson(Map<String, dynamic> json) =>
    _$AppointmentImpl(
      appointmentDate: json['appointment_date'] == null
          ? null
          : DateTime.parse(json['appointment_date'] as String),
      location: json['location'] as String?,
      status: (json['status'] as num?)?.toInt(),
      user: json['userId'] == null
          ? null
          : User.fromJson(json['userId'] as Map<String, dynamic>),
      pet: json['petId'] == null
          ? null
          : Pet.fromJson(json['petId'] as Map<String, dynamic>),
      groomer: json['groomerId'] == null
          ? null
          : Groomer.fromJson(json['groomerId'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AppointmentImplToJson(_$AppointmentImpl instance) =>
    <String, dynamic>{
      'appointment_date': instance.appointmentDate?.toIso8601String(),
      'location': instance.location,
      'status': instance.status,
      'userId': _userToJson(instance.user),
      'petId': _petToJson(instance.pet),
      'groomerId': _groomerToJson(instance.groomer),
    };
