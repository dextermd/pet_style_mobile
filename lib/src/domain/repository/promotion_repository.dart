import 'package:pet_style_mobile/src/data/model/promotion/promotion.dart';

abstract interface class PromotionRepository {
  Future<List<Promotion>> getAll();
}