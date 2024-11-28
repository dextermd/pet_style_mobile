import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:pet_style_mobile/core/helpers/api_exception.dart';
import 'package:pet_style_mobile/core/helpers/log_helper.dart';
import 'package:pet_style_mobile/core/secrets/app_secrets.dart';
import 'package:pet_style_mobile/src/data/model/user/user.dart';
import 'package:pet_style_mobile/src/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final Dio dio;

  UserRepositoryImpl({required this.dio});

  @override
  Future<User?> getUserData() async {
    try {
      final response = await dio.get(
        AppSecrets.meUrl,
      );
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (error) {
      throw ApiException.checkException(error);
    } catch (e, st) {
      logHandle(e.toString(), st);
      throw ('Ошибка\nПопробуйте позже');
    }
  }

  @override
  Future<User?> getUserById(String id) async {
    try {
      final response = await dio.get(
        '${AppSecrets.usersUrl}/$id',
      );
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (error) {
      throw ApiException.checkException(error);
    } catch (e, st) {
      logHandle(e.toString(), st);
      throw ('Ошибка\nПопробуйте позже');
    }
  }

  @override
  Future<bool> isPhoneNumberExist() async {
    try {
      final response = await dio.get(
        AppSecrets.checkPhone,
      );
      return response.data.isNotEmpty;
    } on DioException catch (error) {
      throw ApiException.checkException(error);
    } catch (e, st) {
      logHandle(e.toString(), st);
      throw ('Ошибка\nПопробуйте позже');
    }
  }

  @override
  Future<void> updatePhoneNumber(String phoneNumber) {
    try {
      return dio.post(
        AppSecrets.updatePhone,
        data: {'phone': phoneNumber},
      );
    } on DioException catch (error) {
      throw ApiException.checkException(error);
    } catch (e, st) {
      logHandle(e.toString(), st);
      throw ('Ошибка\nПопробуйте позже');
    }
  }

  @override
  Future<void> updateUserData(User? user, String? newPassword) async {
    try {
      await dio.put(
        AppSecrets.usersUrl,
        data: {
          "user": user?.toJson(),
          "newPassword": newPassword,
        },
      );
    } on DioException catch (error) {
      throw ApiException.checkException(error);
    } catch (e, st) {
      logHandle(e.toString(), st);
      throw ('Ошибка\nПопробуйте позже');
    }
  }

  @override
  Future<void> updateImage(File image) async {
    try {
      final String fileExtension = image.path.split('.').last;
      final MediaType mediaType = MediaType('image', fileExtension);

      // Создаем FormData
      final FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          image.path,
          contentType: mediaType,
        ),
      });

      await dio.post(
        AppSecrets.updateImage,
        data: formData,
      );
    } on DioException catch (error) {
      throw ApiException.checkException(error);
    } catch (e, st) {
      logHandle(e.toString(), st);
      throw ('Ошибка\nПопробуйте позже');
    }
  }
}
