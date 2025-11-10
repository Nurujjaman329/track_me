import 'package:get/get.dart';
import '../services/notes_service.dart';
import '../models/note_model.dart';

class NotesController extends GetxController {
  final NotesService notesService;

  NotesController({required this.notesService});

  var notesList = <NoteModel>[].obs;
  var isLoading = false.obs;

  Future<void> fetchNotes() async {
    try {
      isLoading(true);
      notesList.value = await notesService.getNotes();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> addNote(NoteModel note) async {
    try {
      isLoading(true);
      NoteModel newNote = await notesService.createNote(note);
      notesList.add(newNote);
      Get.back();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateNote(NoteModel note) async {
    try {
      isLoading(true);
      NoteModel updatedNote = await notesService.updateNote(note.id, note);
      int index = notesList.indexWhere((n) => n.id == note.id);
      if (index != -1) notesList[index] = updatedNote;
      Get.back();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> patchNoteTitle(int id, String title) async {
    try {
      isLoading(true);
      NoteModel updatedNote = await notesService.patchNoteTitle(id, title);
      int index = notesList.indexWhere((n) => n.id == id);
      if (index != -1) notesList[index] = updatedNote;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      isLoading(true);
      await notesService.deleteNote(id);
      notesList.removeWhere((n) => n.id == id);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
