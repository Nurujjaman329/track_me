import 'package:get/get.dart';
import '../models/note_model.dart';
import '../services/notes_service.dart';

class NotesController extends GetxController {
  final NotesService notesService;

  NotesController({required this.notesService});

  var notesList = <NoteModel>[].obs;
  var isLoading = false.obs;

  /// Fetch all notes
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

  /// Add new note
  Future<void> addNote(NoteModel note) async {
    try {
      isLoading(true);
      final createdNote = await notesService.createNote(note);
      notesList.add(createdNote);
      Get.back();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  /// Update existing note
  Future<void> updateNote(NoteModel note) async {
    try {
      isLoading(true);
      final updatedNote = await notesService.updateNote(note.id, note);
      int index = notesList.indexWhere((n) => n.id == note.id);
      if (index != -1) notesList[index] = updatedNote;
      Get.back();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  /// Delete note
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

  /// Update only note title
  Future<void> patchNoteTitle(int id, String title) async {
    try {
      isLoading(true);
      final updatedNote = await notesService.patchNoteTitle(id, title);
      int index = notesList.indexWhere((n) => n.id == id);
      if (index != -1) notesList[index] = updatedNote;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
