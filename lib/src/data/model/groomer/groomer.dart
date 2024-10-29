import 'package:freezed_annotation/freezed_annotation.dart';

part 'groomer.freezed.dart';
part 'groomer.g.dart';

@freezed
class Groomer with _$Groomer {
  const factory Groomer({
    String? id,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    int? rating,
    String? email,
    String? phone,
  }) = _Groomer;

  factory Groomer.fromJson(Map<String, Object?> json) =>
      _$GroomerFromJson(json);
}
