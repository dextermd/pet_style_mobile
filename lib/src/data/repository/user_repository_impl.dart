import 'package:dio/dio.dart';
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
    } catch (e) {
      throw Exception('Failed to load user data');
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
    } catch (e) {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Future<bool> isPhoneNumberExist() async {
    try {
      final response = await dio.get(
        AppSecrets.checkPhone,
      );
      return response.data.isNotEmpty;
    } catch (e) {
      throw Exception('Failed to check user phone number');
    }
  }

  @override
  Future<void> updatePhoneNumber(String phoneNumber) {
    try {
      return dio.post(
        AppSecrets.updatePhone,
        data: {'phone': phoneNumber},
      );
    } catch (e) {
      throw Exception('Failed to update phone number');
    }
  }
}
