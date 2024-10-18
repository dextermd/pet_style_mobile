import 'dart:convert';

import 'package:pet_style_mobile/src/data/model/user/user.dart';

class AuthResponse {
    final User? user;
    final String? accessToken;
    final String? refreshToken;

    AuthResponse({
        this.user,
        this.accessToken,
        this.refreshToken,
    });

    factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],

    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "accessToken": accessToken,
        "refreshToken": refreshToken,
    };
  
}

AuthResponse authResponseFromJson(String str) => AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());