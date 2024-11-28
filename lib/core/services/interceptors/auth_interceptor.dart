import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pet_style_mobile/core/helpers/log_helper.dart';
import 'package:pet_style_mobile/core/services/storage_services.dart';
import 'package:pet_style_mobile/core/values/constants.dart';
import 'package:pet_style_mobile/src/data/model/auth_response/auth_response.dart';
import 'package:pet_style_mobile/src/domain/repository/auth_repository.dart';

class AuthInterceptor implements InterceptorsWrapper {
  final Dio dio;
  final AuthRepository _authRepository = GetIt.I<AuthRepository>();
  final StorageServices _storageServices = GetIt.I<StorageServices>();

  AuthInterceptor({required this.dio});

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken =
        _storageServices.getString(AppConstants.STORAGE_ACCESS_TOKEN);
    if (accessToken != null) {
      options.headers['Authorization'] = accessToken;
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      logDebug('Error 401');
      final refreshToken =
          _storageServices.getString(AppConstants.STORAGE_REFRESH_TOKEN);
      logDebug('refreshToken $refreshToken');
      if (refreshToken != null) {
        try {
          final AuthResponse? newTokens =
              await _authRepository.refreshToken(refreshToken);
          if (newTokens != null) {
            final newOptions = Options(
              method: err.requestOptions.method,
              headers: {
                ...err.requestOptions.headers,
                'Authorization': '${newTokens.accessToken}',
                'Content-Type': 'multipart/form-data',
              },
            );

            final cloneReq = await dio.request(
              err.requestOptions.path,
              options: newOptions,
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters,
            );

            return handler.resolve(cloneReq);
          }
        } catch (e) {
          await _authRepository.logOutUI();
        }
      }
    }
    return handler.next(err);
  }
}
