import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/storage/token_storage.dart';
import '../core/network/api_client.dart';
import '../../features/auth/services/auth_service.dart';
import '../../features/notes/services/notes_service.dart';
import '../../features/auth/controllers/auth_controller.dart';
import '../../features/notes/controllers/notes_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Use Get.putAsync to initialize async dependencies
    Get.putAsync<TokenStorage>(() async {
      final prefs = await SharedPreferences.getInstance();
      return TokenStorage(prefs);
    });

    // ApiClient needs TokenStorage, so we use lazyPut with fenix
    Get.lazyPut<ApiClient>(() {
      final tokenStorage = Get.find<TokenStorage>();
      return ApiClient('http://10.0.2.2:8000/api/', tokenStorage);
    }, fenix: true);

    // Services
    Get.lazyPut<AuthService>(() {
      final apiClient = Get.find<ApiClient>();
      final tokenStorage = Get.find<TokenStorage>();
      return AuthService(api: apiClient, tokenStorage: tokenStorage);
    }, fenix: true);

    Get.lazyPut<NotesService>(() {
      final apiClient = Get.find<ApiClient>();
      return NotesService(api: apiClient);
    }, fenix: true);

    // Controllers
    Get.lazyPut<AuthController>(() {
      final authService = Get.find<AuthService>();
      final tokenStorage = Get.find<TokenStorage>();
      return AuthController(authService: authService, tokenStorage: tokenStorage);
    }, fenix: true);

    Get.lazyPut<NotesController>(() {
      final notesService = Get.find<NotesService>();
      return NotesController(notesService: notesService);
    }, fenix: true);
  }
}
