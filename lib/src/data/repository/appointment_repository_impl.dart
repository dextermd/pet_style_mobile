import 'package:dio/dio.dart';
import 'package:pet_style_mobile/core/helpers/api_exception.dart';
import 'package:pet_style_mobile/core/helpers/log_helper.dart';
import 'package:pet_style_mobile/core/secrets/app_secrets.dart';
import 'package:pet_style_mobile/src/data/model/appointment/hw_day_of_week_appointmen.dart';
import 'package:pet_style_mobile/src/data/model/appointment/time_slot_appointment.dart';
import 'package:pet_style_mobile/src/domain/repository/appointment_repository.dart';


class AppointmentRepositoryImpl implements AppointmentRepository {
  final Dio dio;

  AppointmentRepositoryImpl({required this.dio});

  @override
  Future<HwDayOfWeekAppointmen> getAvailableDaysOfWeek(String groomerId) async {
    try {
      final Response response =
          await dio.get('${AppSecrets.availableDaysOfWeekUrl}/$groomerId');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return HwDayOfWeekAppointmen.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: RequestOptions(
              path: '${AppSecrets.availableDaysOfWeekUrl}}/$groomerId'),
          response: response,
          type: DioExceptionType.connectionError,
        );
      }
    } on DioException catch (error, st) {
      logHandle(error.toString(), st);
      throw ApiException.checkException(error);
    } catch (e, st) {
      logHandle(e.toString(), st);
      throw ('Ошибка\nПопробуйте позже');
    }
  }

  @override
  Future<TimeSlotAppointment> getAvailableTimeSlots(
      String date, String groomerId) async {
    try {
      final Response response =
          await dio.get('${AppSecrets.availableSlotsUrl}/$date/$groomerId');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return TimeSlotAppointment.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: RequestOptions(
              path: '${AppSecrets.availableSlotsUrl}/$date/$groomerId'),
          response: response,
          type: DioExceptionType.connectionError,
        );
      }
    } on DioException catch (error, st) {
      logHandle(error.toString(), st);
      throw ApiException.checkException(error);
    } catch (e, st) {
      logHandle(e.toString(), st);
      throw ('Ошибка\nПопробуйте позже');
    }
  }
}
