import 'package:dio/dio.dart';
import 'package:pet_style_mobile/core/helpers/api_exception.dart';
import 'package:pet_style_mobile/core/helpers/log_helper.dart';
import 'package:pet_style_mobile/core/secrets/app_secrets.dart';
import 'package:pet_style_mobile/src/data/model/faq/faq.dart';
import 'package:pet_style_mobile/src/domain/repository/faq_repository.dart';

class FaqRepositoryImpl implements FaqRepository {
  final Dio dio;

  FaqRepositoryImpl({required this.dio});

  @override
  Future<List<Faq>> getAll() async {
    try {
      final response = await dio.get(AppSecrets.faqUrl);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return (response.data as List).map((e) => Faq.fromJson(e)).toList();
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
