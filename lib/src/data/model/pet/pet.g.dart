// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PetImpl _$$PetImplFromJson(Map<String, dynamic> json) => _$PetImpl(
      id: json['id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      photo: json['photo'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      breed: json['breed'] as String?,
      gender: json['gender'] as String?,
      weight: (json['weight'] as num?)?.toInt(),
      behavior: json['behavior'] as String?,
      description: json['description'] as String?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$$PetImplToJson(_$PetImpl instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'photo': instance.photo,
      'name': instance.name,
      'type': instance.type,
      'breed': instance.breed,
      'gender': instance.gender,
      'weight': instance.weight,
      'behavior': instance.behavior,
      'description': instance.description,
      'birthDate': instance.birthDate?.toIso8601String(),
      'userId': instance.userId,
    };
