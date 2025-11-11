import 'package:get/get.dart';
import 'package:track_me/app/core/storage/token_storage.dart';
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
      RegisterResponseModel user = await authService.register(body);
      Get.snackbar('Success', 'Registered as ${user.username}');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> loginUser(LoginRequestModel body) async {
    try {
      isLoading(true);
      LoginResponseModel user = await authService.login(body);
      await TokenStorage.saveAccessToken(user.access);
      Get.snackbar('Success', 'Welcome ${user.username}');
      Get.offAllNamed('/home'); // navigate to home
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
