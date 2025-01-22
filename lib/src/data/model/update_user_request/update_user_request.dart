import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pet_style_mobile/src/data/model/user/user.dart';


part 'update_user_request.freezed.dart';  
part 'update_user_request.g.dart';


@freezed
class UpdateUserRequest with _$UpdateUserRequest {
  const factory UpdateUserRequest({
    User? updateUser,
    String? newPassword,

  }) = _UpdateUserRequest;

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserRequestFromJson(json);

}
