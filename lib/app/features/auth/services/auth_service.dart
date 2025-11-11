import 'package:dio/dio.dart';
import 'package:track_me/app/core/config/api_endpoints.dart';
import 'package:track_me/app/core/network/api_client.dart';
import 'package:track_me/app/core/utils/error_handler.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../models/register_request_model.dart';
import '../models/register_response_model.dart';

class AuthService {
  final ApiClient apiClient;

  AuthService(this.apiClient);

  Future<RegisterResponseModel> register(RegisterRequestModel body) async {
    try {
      final response = await apiClient.dio.post(ApiEndpoints.register, data: body.toJson());
      return RegisterResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<LoginResponseModel> login(LoginRequestModel body) async {
    try {
      final response = await apiClient.dio.post(ApiEndpoints.login, data: body.toJson());
      return LoginResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}
