import 'package:dio/dio.dart';
import '../../../app/core/network/api_client.dart';
import '../../../app/core/storage/token_storage.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';

class AuthService {
  final ApiClient api;
  final TokenStorage tokenStorage;

  AuthService({required this.api, required this.tokenStorage});

  Future<UserModel> register(String username, String email, String password) async {
    return api.request(() async {
      final resp = await api.dio.post('accounts/register/', data: {
        'username': username,
        'email': email,
        'password': password,
      });
      return UserModel.fromJson(resp.data);
    });
  }

  Future<AuthResponse> login(String username, String password) async {
    return api.request(() async {
      final resp = await api.dio.post('accounts/login/', data: {
        'username': username,
        'password': password,
      });
      final body = resp.data;
      // backend returns {"username","refresh","access"}
      final auth = AuthResponse.fromJson(body);
      await tokenStorage.saveTokens(auth.access, auth.refresh);
      return auth;
    });
  }

  Future<UserModel> profile() async {
    return api.request(() async {
      final resp = await api.dio.get('accounts/profile/');
      return UserModel.fromJson(resp.data);
    });
  }

  Future<void> logout() async {
    await tokenStorage.clear();
  }
}
