// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FaqImpl _$$FaqImplFromJson(Map<String, dynamic> json) => _$FaqImpl(
      id: json['id'] as String?,
      questionRu: json['questionRu'] as String?,
      questionRo: json['questionRo'] as String?,
      answerRu: json['answerRu'] as String?,
      answerRo: json['answerRo'] as String?,
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$$FaqImplToJson(_$FaqImpl instance) => <String, dynamic>{
      'id': instance.id,
      'questionRu': instance.questionRu,
      'questionRo': instance.questionRo,
      'answerRu': instance.answerRu,
      'answerRo': instance.answerRo,
      'isActive': instance.isActive,
    };
