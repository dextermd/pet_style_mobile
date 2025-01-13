// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceImpl _$$ServiceImplFromJson(Map<String, dynamic> json) =>
    _$ServiceImpl(
      id: json['id'] as String?,
      nameRu: json['nameRu'] as String?,
      nameRo: json['nameRo'] as String?,
      price: json['price'] as String?,
      duration: json['duration'],
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$$ServiceImplToJson(_$ServiceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nameRu': instance.nameRu,
      'nameRo': instance.nameRo,
      'price': instance.price,
      'duration': instance.duration,
      'isActive': instance.isActive,
    };
