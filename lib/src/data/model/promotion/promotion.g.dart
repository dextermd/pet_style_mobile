// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PromotionImpl _$$PromotionImplFromJson(Map<String, dynamic> json) =>
    _$PromotionImpl(
      id: json['id'] as String?,
      nameRu: json['nameRu'] as String?,
      nameRo: json['nameRo'] as String?,
      descriptionRu: json['descriptionRu'] as String?,
      descriptionRo: json['descriptionRo'] as String?,
      image: json['image'] as String?,
      discount: (json['discount'] as num?)?.toInt(),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$$PromotionImplToJson(_$PromotionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nameRu': instance.nameRu,
      'nameRo': instance.nameRo,
      'descriptionRu': instance.descriptionRu,
      'descriptionRo': instance.descriptionRo,
      'image': instance.image,
      'discount': instance.discount,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
    };
