import 'package:get/get.dart';
import '../services/profile_service.dart';
import '../models/profile_model.dart';

class ProfileController extends GetxController {
  final ProfileService profileService;

  ProfileController({required this.profileService});

  var isLoading = false.obs;
  var profile = Rxn<ProfileModel>();

  Future<void> fetchProfile() async {
    try {
      isLoading(true);
      profile.value = await profileService.getProfile();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
