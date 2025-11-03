import 'package:case_connectinno/core/models/note.dart';
import 'package:case_connectinno/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotesRepository {
  String get _uid {
    final user = auth.currentUser;
    if (user == null) throw Exception("Kullanıcı oturumu bulunamadı.");
    return user.uid;
  }

  CollectionReference<Map<String, dynamic>> get _notesRef =>
      firestore.collection('users').doc(_uid).collection('notes');

  Future<List<NoteModel>> getNotes({String? query}) async {
    try {
      Query<Map<String, dynamic>> q = _notesRef.orderBy(
        'createdAt',
        descending: true,
      );

      if (query != null && query.isNotEmpty) {
        q = q
            .where('title', isGreaterThanOrEqualTo: query)
            .where('title', isLessThanOrEqualTo: '$query\uf8ff');
      }

      final snapshot = await q.get();

      final notes = snapshot.docs
          .map((doc) => NoteModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();

      // 🟢 Pinli notları üste taşı
      notes.sort((a, b) {
        if (a.pinned && !b.pinned) return -1;
        if (!a.pinned && b.pinned) return 1;
        return b.createdAt?.compareTo(a.createdAt ?? DateTime.now()) ?? 0;
      });

      return notes;
    } catch (e) {
      throw Exception("Notlar yüklenemedi: $e");
    }
  }

  Future<NoteModel> createNote(NoteModel note) async {
    try {
      final data = note.toJson()..['createdAt'] = FieldValue.serverTimestamp();
      final docRef = await _notesRef.add(data);
      final doc = await docRef.get();
      return NoteModel.fromJson({...doc.data()!, 'id': doc.id});
    } catch (e) {
      throw Exception("Not oluşturulamadı: $e");
    }
  }

  Future<NoteModel> updateNote(NoteModel note) async {
    try {
      final data = note.toJson()..['updatedAt'] = FieldValue.serverTimestamp();
      await _notesRef.doc(note.id).update(data);
      final updatedDoc = await _notesRef.doc(note.id).get();
      return NoteModel.fromJson({...updatedDoc.data()!, 'id': note.id});
    } catch (e) {
      throw Exception("Not güncellenemedi: $e");
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      await _notesRef.doc(id).delete();
    } catch (e) {
      throw Exception("Not silinemedi: $e");
    }
  }

  Future<NoteModel> restoreNote(String id) async {
    try {
      await _notesRef.doc(id).update({'deleted': false});
      final restored = await _notesRef.doc(id).get();
      return NoteModel.fromJson({...restored.data()!, 'id': id});
    } catch (e) {
      throw Exception("Not geri yüklenemedi: $e");
    }
  }

  /// 🟢 Pin/Unpin toggle
  Future<NoteModel> togglePin(NoteModel note) async {
    try {
      final updated = note.copyWith(pinned: !note.pinned);
      await _notesRef.doc(note.id).update({'pinned': updated.pinned});
      final doc = await _notesRef.doc(note.id).get();
      return NoteModel.fromJson({...doc.data()!, 'id': doc.id});
    } catch (e) {
      throw Exception("Pin durumu güncellenemedi: $e");
    }
  }
}
