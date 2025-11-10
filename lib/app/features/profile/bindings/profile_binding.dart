import 'package:get/get.dart';
import 'package:getx_practise/app/core/network/api_client.dart';
import '../controllers/profile_controller.dart';
import '../services/profile_service.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileService(ApiClient()));
    Get.lazyPut(() => ProfileController(profileService: Get.find()));
  }
}
