import 'package:dio/dio.dart';
import '../storage/token_storage.dart';
import '../utils/error_handler.dart';
import '../../core/config/app_config.dart';

import 'package:dio/dio.dart';
import '../storage/token_storage.dart';

class ApiClient {
  final Dio dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl));

  ApiClient() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await TokenStorage.getAccessToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },

      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          // Access token expired → try refresh
          final success = await _refreshToken();

          if (success) {
            // Retry request with new access token
            final newToken = await TokenStorage.getAccessToken();
            error.requestOptions.headers['Authorization'] = 'Bearer $newToken';

            final cloneReq = await dio.fetch(error.requestOptions);
            return handler.resolve(cloneReq);
          }
        }

        return handler.next(error);
      },
    ));
  }

  Future<bool> _refreshToken() async {
    try {
      final refresh = await TokenStorage.getRefreshToken();
      if (refresh == null) return false;

      final response = await dio.post('/api/accounts/refresh/', data: {
        'refresh': refresh,
      });

      final newAccess = response.data['access'];
      await TokenStorage.saveTokens(access: newAccess, refresh: refresh);

      return true;
    } catch (_) {
      await TokenStorage.clear();
      return false;
    }
  }
}

