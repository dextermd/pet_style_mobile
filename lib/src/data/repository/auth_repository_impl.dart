import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pet_style_mobile/core/helpers/log_helper.dart';
import 'package:pet_style_mobile/core/secrets/app_secrets.dart';
import 'package:pet_style_mobile/core/services/storage_services.dart';
import 'package:pet_style_mobile/core/values/constants.dart';
import 'package:pet_style_mobile/src/data/model/auth_response/auth_response.dart';
import 'package:pet_style_mobile/src/data/model/user/user.dart';
import 'package:pet_style_mobile/src/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio dio;
  final StorageServices _storageServices = GetIt.I.get<StorageServices>();

  AuthRepositoryImpl({required this.dio});

  @override
  Future<AuthResponse?> login(String email, String password) async {
    try {
      final Response response = await dio.post(
        AppSecrets.loginUrl,
        data: json.encode({'email': email, 'password': password}),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      final Map<String, dynamic> data = response.data;
      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthResponse authResponse = AuthResponse.fromJson(data);

        await _storageServices.setString(
            AppConstants.STORAGE_ACCESS_TOKEN, authResponse.accessToken!);
        await _storageServices.setString(
            AppConstants.STORAGE_REFRESH_TOKEN, authResponse.refreshToken!);
        await _storageServices.setBool(
            AppConstants.STORAGE_SHOW_ONBOARDING, false);

        return authResponse;
      }
    } catch (e, st) {
      logHandle(e.toString(), st);
      rethrow;
    }
    return null;
  }

  @override
  Future<AuthResponse> register(User user) {
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() async {
    try {
      await _storageServices.remove(AppConstants.STORAGE_ACCESS_TOKEN);
      await _storageServices.remove(AppConstants.STORAGE_REFRESH_TOKEN);
      await _storageServices.remove(AppConstants.STORAGE_SHOW_ONBOARDING);
    } catch (e) {
      logDebug(e.toString());
      rethrow;
    }
  }

  @override
  Future<AuthResponse?> refreshToken(String oldToken) async {
    oldToken = oldToken.replaceFirst('Bearer ', '');
    try {
      final Response response = await dio.post(
        AppSecrets.refreshTokenUrl,
        data: json.encode({'refresh_token': oldToken}),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      final Map<String, dynamic> data = response.data;
      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthResponse authResponse = AuthResponse.fromJson(data);

        await _storageServices.setString(
            AppConstants.STORAGE_ACCESS_TOKEN, authResponse.accessToken!);
        await _storageServices.setString(
            AppConstants.STORAGE_REFRESH_TOKEN, authResponse.refreshToken!);

        logDebug(
            'RefreshToken(accessToken) saved: ${authResponse.accessToken}');
        logDebug(
            'RefreshToken(refreshToken) saved: ${authResponse.refreshToken}');

        return authResponse;
      }
    } catch (e, st) {
      logHandle(e.toString(), st);
      rethrow;
    }
    return null;
  }

  @override
  Future<AuthResponse?> googleSignIn(String token) async {
    try {
      final Response response = await dio.post(
        AppSecrets.googleSignInUrl,
        data: {'token': token},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      final Map<String, dynamic> data = response.data;
      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthResponse authResponse = AuthResponse.fromJson(data);

        await _storageServices.setString(
            AppConstants.STORAGE_ACCESS_TOKEN, authResponse.accessToken!);
        await _storageServices.setString(
            AppConstants.STORAGE_REFRESH_TOKEN, authResponse.refreshToken!);
        await _storageServices.setBool(
            AppConstants.STORAGE_SHOW_ONBOARDING, false);

        return authResponse;
      }
    } catch (e, st) {
      logHandle(e.toString(), st);
      rethrow;
    }
    return null;
  }
}
