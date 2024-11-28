import 'package:dio/dio.dart';
import 'package:pet_style_mobile/src/domain/repository/device_repository.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  final Dio dio;

  DeviceRepositoryImpl({required this.dio});
}
