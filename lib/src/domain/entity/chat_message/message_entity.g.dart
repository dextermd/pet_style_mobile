// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageEntityImpl _$$MessageEntityImplFromJson(Map<String, dynamic> json) =>
    _$MessageEntityImpl(
      id: json['id'] as String?,
      text: json['text'] as String?,
      senderId: json['senderId'] as String?,
      receiverId: json['receiverId'] as String?,
      status: (json['status'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$MessageEntityImplToJson(_$MessageEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
