// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdateUserRequestImpl _$$UpdateUserRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateUserRequestImpl(
      updateUser: json['updateUser'] == null
          ? null
          : User.fromJson(json['updateUser'] as Map<String, dynamic>),
      newPassword: json['newPassword'] as String?,
    );

Map<String, dynamic> _$$UpdateUserRequestImplToJson(
        _$UpdateUserRequestImpl instance) =>
    <String, dynamic>{
      'updateUser': instance.updateUser,
      'newPassword': instance.newPassword,
    };
