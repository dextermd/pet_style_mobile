import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pet_style_mobile/src/data/model/pet/pet.dart';
import 'package:pet_style_mobile/src/data/model/role/role.dart';



part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    String? id,
    @JsonKey(name: 'created_at')
    DateTime? createdAt,
    @JsonKey(name: 'updated_at')
    DateTime? updatedAt,
    String? name,
    String? email,
    dynamic phone,
    dynamic image,
    String? password,
    dynamic provider,
    dynamic notificationToken,
    List<Role>? roles,
    List<Pet>? pets,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}