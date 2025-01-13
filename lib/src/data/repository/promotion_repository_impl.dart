import 'package:dio/dio.dart';
import 'package:pet_style_mobile/core/helpers/api_exception.dart';
import 'package:pet_style_mobile/core/helpers/log_helper.dart';
import 'package:pet_style_mobile/core/secrets/app_secrets.dart';
import 'package:pet_style_mobile/src/data/model/promotion/promotion.dart';
import 'package:pet_style_mobile/src/domain/repository/promotion_repository.dart';

class PromotionRepositoryImpl implements PromotionRepository {
  final Dio dio;

  PromotionRepositoryImpl({required this.dio});

  @override
  Future<List<Promotion>> getAll() async {
    try {
      final response = await dio.get(AppSecrets.promotionsUrl);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return (response.data as List)
            .map((e) => Promotion.fromJson(e))
            .toList();
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
