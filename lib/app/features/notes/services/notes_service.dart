import 'package:dio/dio.dart';
import 'package:track_me/app/core/config/api_endpoints.dart';
import 'package:track_me/app/core/network/api_client.dart';
import 'package:track_me/app/core/utils/error_handler.dart';
import '../models/note_model.dart';

class NotesService {
  final ApiClient apiClient;

  NotesService(this.apiClient);

  /// Fetch all notes
  Future<List<NoteModel>> getNotes() async {
    try {
      final response = await apiClient.dio.get(ApiEndpoints.notes);
      return (response.data as List)
          .map((json) => NoteModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  /// Fetch single note by ID
  Future<NoteModel> getNoteById(int id) async {
    try {
      final response = await apiClient.dio.get('${ApiEndpoints.notes}$id/');
      return NoteModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  /// Create new note
  Future<NoteModel> createNote(NoteModel note) async {
    try {
      final response = await apiClient.dio.post(
        ApiEndpoints.notes,
        data: note.toJson(),
      );
      return NoteModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  /// Update note by ID
  Future<NoteModel> updateNote(int id, NoteModel note) async {
    try {
      final response = await apiClient.dio.put(
        '${ApiEndpoints.notes}$id/',
        data: note.toJson(),
      );
      return NoteModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  /// Update note title only
  Future<NoteModel> patchNoteTitle(int id, String title) async {
    try {
      final response = await apiClient.dio.patch(
        '${ApiEndpoints.notes}$id/',
        data: {'title': title},
      );
      return NoteModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  /// Delete note
  Future<void> deleteNote(int id) async {
    try {
      await apiClient.dio.delete('${ApiEndpoints.notes}$id/');
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}

