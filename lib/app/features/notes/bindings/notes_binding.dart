import 'package:get/get.dart';
import 'package:track_me/app/core/network/api_client.dart';
import '../controllers/notes_controller.dart';
import '../services/notes_service.dart';

class NotesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotesService(ApiClient()));
    Get.lazyPut(() => NotesController(notesService: Get.find()));
  }
}
