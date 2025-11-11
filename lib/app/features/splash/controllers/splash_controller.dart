import 'package:get/get.dart';
import 'package:track_me/app/core/storage/token_storage.dart';
import 'package:track_me/app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    final token = await TokenStorage.getAccessToken();
    await Future.delayed(const Duration(seconds: 2)); // Splash screen delay

    if (token != null && token.isNotEmpty) {
      // Navigate to home — binding is defined in AppPages
      Get.offAllNamed(AppRoutes.home);
    } else {
      // Navigate to login — binding is defined in AppPages
      Get.offAllNamed(AppRoutes.login);
    }
  }
}

