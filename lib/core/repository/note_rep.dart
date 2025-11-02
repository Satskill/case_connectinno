import 'package:case_connectinno/core/models/note.dart';
import 'package:dio/dio.dart';
import '../services/local_storage.dart';

class NotesRepository {
  final Dio _dio;
  static const cacheKey = 'cached_notes';

  NotesRepository(this._dio);

  Future<List<NoteModel>> getNotes({String? query, bool? pinned}) async {
    try {
      final response = await _dio.get('/notes', queryParameters: {
        if (query != null) 'q': query,
        if (pinned != null) 'pinned': pinned.toString(),
      });

      final data = (response.data['notes'] as List)
          .map((e) => NoteModel.fromJson(e))
          .toList();

      await LocalStorage.save(cacheKey, data.map((e) => e.toJson()).toList());
      return data;
    } catch (_) {
      final cached = await LocalStorage.loadList(cacheKey);
      return cached.map((e) => NoteModel.fromJson(e)).toList();
    }
  }

  Future<NoteModel> createNote(NoteModel note) async {
    try {
      final response = await _dio.post('/notes', data: note.toJson());
      return NoteModel.fromJson({...response.data['data'], 'id': response.data['id']});
    } catch (_) {
      // offline queue mantığı
      final offline = await LocalStorage.loadList('offline_notes');
      offline.add(note.toJson());
      await LocalStorage.save('offline_notes', offline);
      return note;
    }
  }

  Future<void> syncOffline() async {
    final offlineNotes = await LocalStorage.loadList('offline_notes');
    if (offlineNotes.isEmpty) return;

    for (final n in offlineNotes) {
      try {
        await _dio.post('/notes', data: n);
      } catch (_) {
        continue;
      }
    }
    await LocalStorage.clear('offline_notes');
  }

  Future<NoteModel> updateNote(NoteModel note) async {
    final response = await _dio.put('/notes/${note.id}', data: note.toJson());
    return NoteModel.fromJson({...response.data['data'], 'id': response.data['id']});
  }

  Future<void> deleteNote(String id, {bool force = false}) async {
    await _dio.delete('/notes/$id', queryParameters: {'force': force.toString()});
  }

  Future<NoteModel> restoreNote(String id) async {
    final response = await _dio.post('/notes/$id/restore');
    return NoteModel.fromJson({...response.data['data'], 'id': response.data['id']});
  }
}
