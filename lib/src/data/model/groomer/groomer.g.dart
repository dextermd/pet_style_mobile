// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groomer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroomerImpl _$$GroomerImplFromJson(Map<String, dynamic> json) =>
    _$GroomerImpl(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      rating: (json['rating'] as num?)?.toInt(),
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      durationTime: json['durationTime'] as String?,
    );

Map<String, dynamic> _$$GroomerImplToJson(_$GroomerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'rating': instance.rating,
      'email': instance.email,
      'phone': instance.phone,
      'durationTime': instance.durationTime,
    };
