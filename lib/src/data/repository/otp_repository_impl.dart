import 'package:dio/dio.dart';
import 'package:pet_style_mobile/core/helpers/api_exception.dart';
import 'package:pet_style_mobile/core/helpers/log_helper.dart';
import 'package:pet_style_mobile/core/secrets/app_secrets.dart';
import 'package:pet_style_mobile/src/domain/repository/otp_repository.dart';

class OtpRepositoryImpl implements OtpRepository {
  final Dio dio;

  OtpRepositoryImpl({required this.dio});

  @override
  Future<void> sendOtp(String phoneNumber) async {
    try {
      await dio.post(
        AppSecrets.sendSmsUrl,
        data: {'phone': phoneNumber},
      );
    } on DioException catch (e, st) {
      logHandle(e.toString(), st);
      throw ApiException.checkException(e);
    } catch (e) {
      throw Exception('Failed to send otp');
    }
  }

  @override
  Future<void> verifyOtp(String phoneNumber, String otp) async {
    try {
      await dio.post(
        AppSecrets.verifyOtpUrl,
        data: {'phone': phoneNumber, 'code': otp},
      );
    } on DioException catch (e, st) {
      logHandle(e.toString(), st);
      throw ApiException.checkException(e);
    } catch (e) {
      throw Exception('Failed to verify otp');
    }
  }
}
