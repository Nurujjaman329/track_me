import 'package:dio/dio.dart';
import '../network/api_exception.dart';


class ErrorHandler {
static ApiException handle(DioException error) {
switch (error.type) {
case DioExceptionType.connectionTimeout:
return ApiException("Connection Timeout. Try again.");
case DioExceptionType.receiveTimeout:
return ApiException("Server not responding.");
case DioExceptionType.badResponse:
return ApiException(error.response?.data.toString() ?? "Unexpected Error");
default:
return ApiException("Something went wrong. Try again.");
}
}
}