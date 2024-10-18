import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pet_style_mobile/src/data/model/user/user.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  const factory Message(
      {String? id,
      String? text,
      User? sender,
      User? receiver,
      int? status,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'is_active') bool? isActive}) = _Message;

  factory Message.fromJson(Map<String, Object?> json) =>
      _$MessageFromJson(json);
}
