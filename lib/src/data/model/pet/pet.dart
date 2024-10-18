import 'package:freezed_annotation/freezed_annotation.dart';

part 'pet.freezed.dart';
part 'pet.g.dart';

@freezed
class Pet with _$Pet {
    const factory Pet({
        String? id,
        @JsonKey(name: 'created_at')
        DateTime? createdAt,
        @JsonKey(name: 'updated_at')
        DateTime? updatedAt,
        String? photo,
        String? name,
        String? type,
        String? breed,
        String? gender,
        int? weight,
        String? behavior,
        String? description,
        DateTime? birthDate,
        String? userId,
    }) = _Pet;

      factory Pet.fromJson(Map<String, Object?> json)
      => _$PetFromJson(json);
}