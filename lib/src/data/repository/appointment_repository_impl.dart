import 'package:dio/dio.dart';
import 'package:pet_style_mobile/core/helpers/api_exception.dart';
import 'package:pet_style_mobile/core/helpers/log_helper.dart';
import 'package:pet_style_mobile/core/secrets/app_secrets.dart';
import 'package:pet_style_mobile/src/data/model/appointment/appointment.dart';
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

  @override
  Future<void> createAppointment(Appointment appointment) async {
    try {
      await dio.post(
        AppSecrets.appointmentUrl,
        data: appointment.toJson(),
      );
    } on DioException catch (error, st) {
      logHandle(error.toString(), st);
      throw ApiException.checkException(error);
    } catch (e, st) {
      logHandle(e.toString(), st);
      throw ('Ошибка\nПопробуйте позже');
    }
  }

  @override
  Future<bool> isAppointmentExistByDateAndPetId(
      DateTime date, String petId) async {
    try {
      final Response response = await dio.get(
        AppSecrets.checkAppointmentUrl,
        data: {'date': date.toIso8601String(), 'petId': petId},
      );
      return response.data.isNotEmpty;
    } on DioException catch (error, st) {
      logHandle(error.toString(), st);
      throw ApiException.checkException(error);
    } catch (e, st) {
      logHandle(e.toString(), st);
      throw ('Ошибка\nПопробуйте позже');
    }
  }

  @override
  Future<List<Appointment>> getAppointmentsByUser() async {
    try {
      final Response response = await dio.get(
        AppSecrets.appointmentsByUserUrl,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return (response.data as List)
            .map((e) => Appointment.fromJson(e))
            .toList();
      }
      return [];
    } on DioException catch (error, st) {
      logHandle(error.toString(), st);
      throw ApiException.checkException(error);
    } catch (e, st) {
      logHandle(e.toString(), st);
      throw ('Ошибка\nПопробуйте позже');
    }
  }

  @override
  Future<List<Appointment>> getActiveAppointmentsByUser() async {
    try {
      final Response response =
          await dio.get(AppSecrets.activeAppointmentsByUserUrl);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return (response.data as List)
            .map((e) => Appointment.fromJson(e))
            .toList();
      }
      return [];
    } on DioException catch (error, st) {
      logHandle(error.toString(), st);
      throw ApiException.checkException(error);
    } catch (e, st) {
      logHandle(e.toString(), st);
      throw ('Ошибка\nПопробуйте позже');
    }
  }

  @override
  Future<void> cancelAppointment(String appointmentId) async {
    try {
      await dio.patch('${AppSecrets.cancelAppointmentUrl}/$appointmentId');
    } on DioException catch (error, st) {
      logHandle(error.toString(), st);
      throw ApiException.checkException(error);
    } catch (e, st) {
      logHandle(e.toString(), st);
      throw ('Ошибка\nПопробуйте позже');
    }
  }

  @override
  Future<Appointment?> isAvailableEditAppointment(String appointmentId) async {
    try {
      final Response response = await dio.get(
        '${AppSecrets.isAvailableEditAppointmentUrl}/$appointmentId',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data.isNotEmpty) {
          return Appointment.fromJson(response.data);
        } else {
          return null;
        }
      }
      return null;
    } on DioException catch (error, st) {
      logHandle(error.toString(), st);
      throw ApiException.checkException(error);
    } catch (e, st) {
      logHandle(e.toString(), st);
      throw ('Ошибка\nПопробуйте позже');
    }
  }

  @override
  Future<void> updateAppointment(String id, Appointment appointment) async {
    try {
      await dio.patch(
        '${AppSecrets.appointmentUrl}/$id',
        data: appointment.toJson(),
      );
    } on DioException catch (error, st) {
      logHandle(error.toString(), st);
      throw ApiException.checkException(error);
    } catch (e, st) {
      logHandle(e.toString(), st);
      throw ('Ошибка\nПопробуйте позже');
    }
  }
}
