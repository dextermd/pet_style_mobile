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
      userId: json['userId'] as String?,
      petId: json['petId'] as String?,
      groomerId: json['groomerId'] as String?,
    );

Map<String, dynamic> _$$AppointmentImplToJson(_$AppointmentImpl instance) =>
    <String, dynamic>{
      'appointment_date': instance.appointmentDate?.toIso8601String(),
      'location': instance.location,
      'status': instance.status,
      'userId': instance.userId,
      'petId': instance.petId,
      'groomerId': instance.groomerId,
    };
