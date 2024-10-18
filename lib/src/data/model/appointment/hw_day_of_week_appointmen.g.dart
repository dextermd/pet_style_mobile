// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hw_day_of_week_appointmen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HwDayOfWeekAppointmenImpl _$$HwDayOfWeekAppointmenImplFromJson(
        Map<String, dynamic> json) =>
    _$HwDayOfWeekAppointmenImpl(
      homeWorkDayOfWeek: (json['homeWorkDayOfWeek'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$$HwDayOfWeekAppointmenImplToJson(
        _$HwDayOfWeekAppointmenImpl instance) =>
    <String, dynamic>{
      'homeWorkDayOfWeek': instance.homeWorkDayOfWeek,
    };
