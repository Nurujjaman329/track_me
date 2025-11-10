import 'package:get/get.dart';
import '../services/notes_service.dart';
import '../models/note_model.dart';
import '../../../app/core/network/api_exceptions.dart';

class NotesController extends GetxController {
  final NotesService notesService;
  NotesController({required this.notesService});

  final RxList<NoteModel> notes = <NoteModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotes();
  }

  Future<void> loadNotes() async {
    try {
      isLoading.value = true;
      final list = await notesService.getNotes();
      notes.assignAll(list);
    } on ApiException catch (e) {
      Get.snackbar('Error', e.message);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createNote(String title, String content) async {
    try {
      isLoading.value = true;
      final n = await notesService.createNote(title, content);
      notes.insert(0, n);
      Get.back(); // close create screen
      Get.snackbar('Success', 'Note created');
    } on ApiException catch (e) {
      Get.snackbar('Create failed', e.message);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      await notesService.deleteNote(id);
      notes.removeWhere((n) => n.id == id);
      Get.snackbar('Deleted', 'Note deleted successfully');
    } on ApiException catch (e) {
      Get.snackbar('Delete failed', e.message);
    }
  }
}
