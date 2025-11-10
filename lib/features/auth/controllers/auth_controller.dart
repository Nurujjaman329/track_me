import 'package:get/get.dart';
import '../../../app/core/storage/token_storage.dart';
import '../../../app/core/network/api_client.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';
import '../../../app/core/network/api_exceptions.dart';

class AuthController extends GetxController {
  final AuthService authService;
  final TokenStorage tokenStorage;

  AuthController({required this.authService, required this.tokenStorage});

  final Rxn<UserModel> user = Rxn<UserModel>();
  final RxBool isLoading = false.obs;

  Future<void> register(String username, String email, String password) async {
    try {
      isLoading.value = true;
      final u = await authService.register(username, email, password);
      user.value = u;
      Get.snackbar('Success', 'Registration successful. Please log in.');
    } on ApiException catch (e) {
      Get.snackbar('Registration failed', e.message);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login(String username, String password) async {
    print('Login attempt: username=$username, password=$password');

    try {
      isLoading.value = true;
      final authResp = await authService.login(username, password);
      print('Login response: ${authResp.toJson()}');

      // fetch profile after login
      final profile = await authService.profile();
      print('Profile response: ${profile.toJson()}');

      user.value = profile;
      Get.offAllNamed('/notes'); // navigate to notes list
    } on ApiException catch (e) {
      print('Login failed: ${e.message}');
      Get.snackbar('Login failed', e.message);
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      final profile = await authService.profile();
      user.value = profile;
    } on ApiException catch (e) {
      Get.snackbar('Error', e.message);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await authService.logout();
    user.value = null;
    Get.offAllNamed('/login');
  }
}
