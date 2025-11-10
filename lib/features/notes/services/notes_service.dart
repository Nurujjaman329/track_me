import '../../../app/core/network/api_client.dart';
import '../models/note_model.dart';

class NotesService {
  final ApiClient api;
  NotesService({required this.api});

  Future<List<NoteModel>> getNotes() async {
    return api.request(() async {
      final resp = await api.dio.get('notes/');
      final list = (resp.data as List).map((e) => NoteModel.fromJson(e)).toList();
      return list;
    });
  }

  Future<NoteModel> createNote(String title, String content) async {
    return api.request(() async {
      final resp = await api.dio.post('notes/', data: {'title': title, 'content': content});
      return NoteModel.fromJson(resp.data);
    });
  }

  Future<NoteModel> getNote(int id) async {
    return api.request(() async {
      final resp = await api.dio.get('notes/$id/');
      return NoteModel.fromJson(resp.data);
    });
  }

  Future<NoteModel> updateNote(int id, String title, String content) async {
    return api.request(() async {
      final resp = await api.dio.put('notes/$id/', data: {'title': title, 'content': content});
      return NoteModel.fromJson(resp.data);
    });
  }

  Future<NoteModel> patchNote(int id, Map<String, dynamic> patchData) async {
    return api.request(() async {
      final resp = await api.dio.patch('notes/$id/', data: patchData);
      return NoteModel.fromJson(resp.data);
    });
  }

  Future<void> deleteNote(int id) async {
    return api.request(() async {
      await api.dio.delete('notes/$id/');
      return;
    });
  }
}
