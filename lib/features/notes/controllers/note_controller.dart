import 'package:get/get.dart';
import '../services/notes_service.dart';
import '../models/note_model.dart';
import '../../../app/core/network/api_exceptions.dart';

class NoteController extends GetxController {
  final NotesService service;
  NoteController({required this.service});

  final Rxn<NoteModel> note = Rxn<NoteModel>();
  final RxBool isLoading = false.obs;

  Future<void> loadNoteById(int id) async {
    try {
      isLoading.value = true;
      final n = await service.getNote(id);
      note.value = n;
    } on ApiException catch (e) {
      Get.snackbar('Error', e.message);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateNoteById(int id, String title, String content) async {
    try {
      isLoading.value = true;
      final updated = await service.updateNote(id, title, content);
      note.value = updated;
      Get.back();
      Get.snackbar('Success', 'Note updated');
    } on ApiException catch (e) {
      Get.snackbar('Update failed', e.message);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> patch(int id, Map<String, dynamic> patchData) async {
    try {
      isLoading.value = true;
      final updated = await service.patchNote(id, patchData);
      note.value = updated;
      Get.back();
      Get.snackbar('Success', 'Note updated');
    } on ApiException catch (e) {
      Get.snackbar('Update failed', e.message);
    } finally {
      isLoading.value = false;
    }
  }
}
