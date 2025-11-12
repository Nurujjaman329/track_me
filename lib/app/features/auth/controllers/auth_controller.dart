import 'package:get/get.dart';
import 'package:track_me/app/core/network/api_exception.dart';
import 'package:track_me/app/core/storage/token_storage.dart';
import 'package:track_me/app/routes/app_routes.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';
import '../services/auth_service.dart';
import '../models/login_response_model.dart';
import '../models/register_response_model.dart';


class AuthController extends GetxController {
  final AuthService authService;
  AuthController({required this.authService});

  var isLoading = false.obs;

  Future<void> registerUser(RegisterRequestModel body) async {
    try {
      isLoading(true);

      final RegisterResponseModel user = await authService.register(body);

      Get.snackbar('Success', 'Registered as ${user.username}');
      Get.offAllNamed(AppRoutes.login);

    } catch (e) {
      final message = ApiException.getErrorMessage(e);
      Get.snackbar('Error', message);
    } finally {
      isLoading(false);
    }
  }

  Future<void> loginUser(LoginRequestModel body) async {
    try {
      isLoading(true);

      final LoginResponseModel user = await authService.login(body);

      // ✅ Save both access + refresh tokens now
      await TokenStorage.saveTokens(
        access: user.access,
        refresh: user.refresh,
      );

      Get.snackbar('Welcome', user.username);
      Get.offAllNamed(AppRoutes.home);

    } catch (e) {
      final message = ApiException.getErrorMessage(e);
      Get.snackbar('Login Failed', message);
    } finally {
      isLoading(false);
    }
  }
}

