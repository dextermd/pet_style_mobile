// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_slot_appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeSlotAppointmentImpl _$$TimeSlotAppointmentImplFromJson(
        Map<String, dynamic> json) =>
    _$TimeSlotAppointmentImpl(
      allTimeSlot: (json['allTimeSlot'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      availableTimeSlot: (json['availableTimeSlot'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$TimeSlotAppointmentImplToJson(
        _$TimeSlotAppointmentImpl instance) =>
    <String, dynamic>{
      'allTimeSlot': instance.allTimeSlot,
      'availableTimeSlot': instance.availableTimeSlot,
    };
