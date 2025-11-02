import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/note_model.dart';
import '../../data/repositories/notes_repository.dart';

class NotesState {
  final List<NoteModel> notes;
  final bool loading;
  final String? error;

  const NotesState({
    this.notes = const [],
    this.loading = false,
    this.error,
  });

  NotesState copyWith({
    List<NoteModel>? notes,
    bool? loading,
    String? error,
  }) {
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

  Future<void> loadNotes() async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final notes = await repository.getNotes();
      emit(state.copyWith(notes: notes, loading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), loading: false));
    }
  }

  Future<void> addNote(NoteModel note) async {
    try {
      final created = await repository.createNote(note);
      emit(state.copyWith(notes: [created, ...state.notes]));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> updateNote(NoteModel note) async {
    try {
      final updated = await repository.updateNote(note);
      final newList = state.notes
          .map((n) => n.id == updated.id ? updated : n)
          .toList();
      emit(state.copyWith(notes: newList));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      await repository.deleteNote(id);
      emit(state.copyWith(
          notes: state.notes.where((n) => n.id != id).toList()));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> restore(String id) async {
    try {
      final restored = await repository.restoreNote(id);
      final newList = [restored, ...state.notes];
      emit(state.copyWith(notes: newList));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
