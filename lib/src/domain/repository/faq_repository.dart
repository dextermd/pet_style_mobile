import 'package:pet_style_mobile/src/data/model/faq/faq.dart';

abstract interface class FaqRepository {
  Future<List<Faq>> getAll();
}