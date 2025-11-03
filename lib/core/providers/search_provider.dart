import 'package:case_connectinno/core/models/note.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<List<NoteModel>> {
  final List<NoteModel> _allNotes;

  SearchCubit(this._allNotes) : super(_allNotes);

  void search(String query) {
    if (query.isEmpty) {
      emit(_allNotes);
    } else {
      final filtered = _allNotes.where((note) {
        final q = query.toLowerCase();
        return note.title.toLowerCase().contains(q) ||
            note.content.toLowerCase().contains(q);
      }).toList();
      emit(filtered);
    }
  }
}
