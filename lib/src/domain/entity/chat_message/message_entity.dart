import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_entity.freezed.dart';
part 'message_entity.g.dart';

@freezed
class MessageEntity with _$MessageEntity {
  const factory MessageEntity({
    String? id,
    String? text,
    String? senderId,
    String? receiverId,
    int? status,
    DateTime? createdAt,
  }) = _MessageEntity;

  factory MessageEntity.fromJson(Map<String, Object?> json) =>
      _$MessageEntityFromJson(json);

}
