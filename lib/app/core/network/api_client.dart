import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:track_me/app/routes/app_routes.dart';
import '../storage/token_storage.dart';
import '../../core/config/app_config.dart';


class ApiClient {
  final Dio dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl));

  ApiClient() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add access token to every request
        final token = await TokenStorage.getAccessToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },

      onError: (DioException error, handler) async {
        // If 401 → try refresh token
        if (error.response?.statusCode == 401) {
          final success = await _refreshToken();

          if (success) {
            // Retry the original request
            final newToken = await TokenStorage.getAccessToken();
            error.requestOptions.headers['Authorization'] = 'Bearer $newToken';
            final cloneReq = await dio.fetch(error.requestOptions);
            return handler.resolve(cloneReq);
          } else {
            // Refresh failed → logout user
            await TokenStorage.clear();
            Get.offAllNamed(AppRoutes.login);
          }
        }

        handler.next(error);
      },
    ));
  }


  Future<bool> _refreshToken() async {
    try {
      final refresh = await TokenStorage.getRefreshToken();
      if (refresh == null) return false;

      final response = await dio.post('accounts/token/refresh/', data: {
        'refresh': refresh,
      });

      final newAccess = response.data['access'];
      // Save new access token, keep refresh same
      await TokenStorage.saveTokens(access: newAccess, refresh: refresh);

      return true;
    } catch (_) {
      return false;
    }
  }
}

