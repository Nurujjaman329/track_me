import 'package:dio/dio.dart';
import 'package:getx_practise/app/core/config/api_endpoints.dart';
import 'package:getx_practise/app/core/network/api_client.dart';
import 'package:getx_practise/app/core/utils/error_handler.dart';
import '../models/profile_model.dart';

class ProfileService {
  final ApiClient apiClient;

  ProfileService(this.apiClient);

  Future<ProfileModel> getProfile() async {
    try {
      final response = await apiClient.dio.get(ApiEndpoints.profile);
      return ProfileModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}
