// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'],
      image: json['image'],
      password: json['password'] as String?,
      provider: json['provider'],
      notificationToken: json['notificationToken'],
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList(),
      pets: (json['pets'] as List<dynamic>?)
          ?.map((e) => Pet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'image': instance.image,
      'password': instance.password,
      'provider': instance.provider,
      'notificationToken': instance.notificationToken,
      'roles': instance.roles,
      'pets': instance.pets,
    };
