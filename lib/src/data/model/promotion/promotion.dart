import 'package:freezed_annotation/freezed_annotation.dart';

part 'promotion.freezed.dart';
part 'promotion.g.dart';

@freezed
class Promotion with _$Promotion {
  const factory Promotion({
    String? id,
    String? nameRu,
    String? nameRo,
    String? descriptionRu,
    String? descriptionRo,
    String? image,
    int? discount,
    DateTime? startDate,
    DateTime? endDate,
  }) = _Promotion;

  factory Promotion.fromJson(Map<String, dynamic> json) =>
      _$PromotionFromJson(json);
}
