import 'package:freezed_annotation/freezed_annotation.dart';

part 'hw_day_of_week_appointmen.freezed.dart';
part 'hw_day_of_week_appointmen.g.dart';

@freezed
class HwDayOfWeekAppointmen with _$HwDayOfWeekAppointmen {
    const factory HwDayOfWeekAppointmen({
        List<int>? homeWorkDayOfWeek,
    }) = _HwDayOfWeekAppointmen;

      factory HwDayOfWeekAppointmen.fromJson(Map<String, Object?> json)
      => _$HwDayOfWeekAppointmenFromJson(json);
}
