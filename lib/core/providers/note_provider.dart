import 'package:case_connectinno/core/util/extension.dart';
import 'package:case_connectinno/widget/dialog/app_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:case_connectinno/core/models/note.dart';
import 'package:case_connectinno/core/repository/note_rep.dart';
import 'package:go_router/go_router.dart';

class NotesState {
  final List<NoteModel> notes;
  final bool loading;
  final String? error;

  const NotesState({this.notes = const [], this.loading = false, this.error});

  NotesState copyWith({List<NoteModel>? notes, bool? loading, String? error}) {
    return NotesState(
      notes: notes ?? this.notes,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}

class NotesCubit extends Cubit<NotesState> {
  final NotesRepository repository;

  NotesCubit(this.repository) : super(const NotesState());

  /// 🔄 Notları yükle
  Future<void> loadNotes() async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final notes = await repository.getNotes();
      emit(state.copyWith(notes: notes, loading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), loading: false));
    }
  }

  /// ➕ Not ekle
  Future<void> addNote(NoteModel note, BuildContext context) async {
    try {
      await repository.createNote(note);
      await loadNotes(); // 🔁 Firestore’dan tekrar yükle

      if (context.mounted) {
        _showDialog(context, 'Not Eklendi');
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  /// ✏️ Not güncelle
  Future<void> updateNote(NoteModel note, BuildContext context) async {
    try {
      await repository.updateNote(note);
      await loadNotes(); // 🔁 Firestore’dan tekrar yükle

      if (context.mounted) {
        _showDialog(context, 'Not Güncellendi');
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  /// 🗑 Not sil
  Future<void> deleteNote(String id, BuildContext context) async {
    try {
      await repository.deleteNote(id);
      await loadNotes(); // 🔁 Firestore’dan tekrar yükle

      if (context.mounted) {
        _showDialog(context, 'Not Silindi');
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  /// ♻️ Not geri yükle
  Future<void> restore(String id) async {
    try {
      await repository.restoreNote(id);
      await loadNotes(); // 🔁 Firestore’dan tekrar yükle
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> togglePin(NoteModel note) async {
    try {
      await repository.togglePin(note);
      await loadNotes();
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  /// ⚡️ Tekrar eden dialog fonksiyonu
  void _showDialog(BuildContext context, String title) {
    context.showAppDialog(
      AppAlertDialog(
        type: AlertType.approved,
        isSingleButton: false,
        leftButtonText: 'Tamam',
        rightButtonText: 'İptal',
        title: title,
        leftFunction: () {
          if (context.mounted) context.pop();
        },
      ),
    );
  }
}
