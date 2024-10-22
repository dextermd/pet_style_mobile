import 'package:dio/dio.dart';

class ApiException implements Exception {
  static List<String> _getExeptionMessage(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.badResponse:
        return [
          exception.response?.data['error'] ?? 'Ошибка',
          exception.response?.data['message'] ?? 'Попробуйте позже'
        ];

      case DioExceptionType.connectionError:
        return [
          'Ошибка соединения',
          'Произошла ошибка соединения. Попробуйте чуть позже'
        ];

      case DioExceptionType.connectionTimeout:
        return [
          'Подключение прервано',
          'Проверьте ваше интернет соединение и попробуйте еще раз'
        ];

      case DioExceptionType.cancel:
        return [
          'Запрос отменен',
          'Запрос был отменен. Попробуйте еще раз',
        ];

      case DioExceptionType.unknown:
        return [
          'Неизвестная ошибка',
          'Проверьте API url или параметры запроса',
        ];

      case DioExceptionType.sendTimeout:
        return [
          'Превышено время отправки запроса',
          'Проверьте ваше интернет соединение и попробуйте еще раз'
        ];

      case DioExceptionType.receiveTimeout:
        return [
          'Превышено время получения ответа',
          'Проверьте ваше интернет соединение и попробуйте еще раз'
        ];

      case DioExceptionType.badCertificate:
        return [
          'Ошибка сертификата',
          'Проверьте ваше интернет соединение и попробуйте еще раз'
        ];

      default:
        return ['Ошибка', 'Попробуйте позже'];
    }
  }

  static String checkException(DioException error) {
    final List<String> errorMessage = _getExeptionMessage(error);
    return '${errorMessage[0]}\n${errorMessage[1]}';
  }
}
