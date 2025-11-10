import 'package:dio/dio.dart';
import '../storage/token_storage.dart';
import '../utils/error_handler.dart';
import '../../core/config/app_config.dart';

class ApiClient {
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl));

  ApiClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TokenStorage.getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          final apiError = ErrorHandler.handle(error);
          return handler.reject(DioException(
            requestOptions: error.requestOptions,
            error: apiError.message,
            response: error.response,
            type: DioExceptionType.unknown,
          ));
        },
      ),
    );
  }

  Dio get dio => _dio;
}
