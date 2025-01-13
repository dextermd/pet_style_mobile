import 'package:dio/dio.dart';
import 'package:pet_style_mobile/core/helpers/api_exception.dart';
import 'package:pet_style_mobile/core/helpers/log_helper.dart';
import 'package:pet_style_mobile/core/secrets/app_secrets.dart';
import 'package:pet_style_mobile/src/data/model/services/service.dart';
import 'package:pet_style_mobile/src/domain/repository/service_repository.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final Dio dio;

  ServiceRepositoryImpl({required this.dio});

  @override
  Future<List<Service>> getAll() async {
    try {
      final Response response = await dio.get(AppSecrets.servicesUrl);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return (response.data as List).map((e) => Service.fromJson(e)).toList();
      }
    } on DioException catch (error, st) {
      logHandle(error.toString(), st);
      throw ApiException.checkException(error);
    } catch (e, st) {
      logHandle(e.toString(), st);
      throw ('Ошибка\nПопробуйте позже');
    }
    return [];
  }
}
