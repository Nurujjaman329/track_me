import 'package:dio/dio.dart';
import '../storage/token_storage.dart';
import 'api_exceptions.dart';

class ApiClient {
  final Dio dio;
  final TokenStorage tokenStorage;

  ApiClient(String baseUrl, this.tokenStorage)
      : dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Attach Authorization header if token exists
          final access = await tokenStorage.getAccessToken();
          if (access != null) {
            options.headers['Authorization'] = 'Bearer $access';
          }
          print('--> ${options.method} ${options.uri}');
          print('Headers: ${options.headers}');
          print('Data: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('<-- ${response.statusCode} ${response.requestOptions.uri}');
          print('Response: ${response.data}');
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          print('<-- Error ${e.response?.statusCode} ${e.requestOptions.uri}');
          print('Message: ${e.message}');
          print('Data: ${e.response?.data}');
          return handler.next(e);
        },
      ),
    );
  }

  // Wrap requests to handle ApiException etc.
  Future<T> request<T>(Future<T> Function() callback) async {
    try {
      return await callback();
    } on DioError catch (e) {
      if (e.response != null) {
        final data = e.response?.data;
        if (data is Map<String, dynamic> && data.containsKey('detail')) {
          throw ApiException(data['detail']);
        } else {
          throw ApiException('Server returned non-JSON response: $data');
        }
      } else {
        throw ApiException(e.message!);
      }
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}

