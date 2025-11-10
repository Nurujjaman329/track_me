import 'package:get/get.dart';
import 'package:getx_practise/app/core/network/api_client.dart';
import '../controllers/auth_controller.dart';
import '../services/auth_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthService(ApiClient()));
    Get.lazyPut(() => AuthController(authService: Get.find()));
  }
}
