// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groomer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroomerImpl _$$GroomerImplFromJson(Map<String, dynamic> json) =>
    _$GroomerImpl(
      id: json['id'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      rating: (json['rating'] as num?)?.toInt(),
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$$GroomerImplToJson(_$GroomerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'rating': instance.rating,
      'email': instance.email,
      'phone': instance.phone,
    };
