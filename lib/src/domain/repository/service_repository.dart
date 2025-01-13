import 'package:pet_style_mobile/src/data/model/services/service.dart';

abstract interface class ServiceRepository {
  Future<List<Service>> getAll();
}
