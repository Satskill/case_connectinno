import 'package:case_connectinno/core/constant/color.dart';
import 'package:case_connectinno/core/constant/ui.dart';
import 'package:case_connectinno/core/providers/note_provider.dart';
import 'package:case_connectinno/widget/base/dash_app_bar.dart';
import 'package:case_connectinno/widget/form/app_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class NotesSearchView extends StatelessWidget {
  const NotesSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotesCubit>();

    cubit.loadNotes();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/addNote');
        },
        backgroundColor: AppColor.primary,
        child: Icon(Icons.add, color: AppColor.baseWhite, size: 28.r),
      ),
      appBar: DashAppBar(),
      backgroundColor: AppColor.baseWhite,
      body: const _NotesSearchBody(),
    );
  }
}

class _NotesSearchBody extends StatefulWidget {
  const _NotesSearchBody();

  @override
  State<_NotesSearchBody> createState() => _NotesSearchBodyState();
}

class _NotesSearchBodyState extends State<_NotesSearchBody> {
  late final TextEditingController _controller;
  String _searchQuery = '';

  @override
  void initState() {
    _controller = TextEditingController();
    _controller.addListener(() {
      setState(() {
        _searchQuery = _controller.text.trim();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppUI.fullPadding,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: AppFormField(
              controller: _controller,
              padding: AppUI.fullPadding,
              hintText: 'Ara...',
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ),
          ),
          Expanded(
            child: BlocBuilder<NotesCubit, NotesState>(
              builder: (context, state) {
                if (state.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.error != null) {
                  return Center(child: Text('Hata: ${state.error}'));
                }

                final filteredNotes = state.notes.where((n) {
                  final query = _controller.text.trim().toLowerCase();
                  return query.isEmpty ||
                      n.title.toLowerCase().contains(query) ||
                      n.content.toLowerCase().contains(query);
                }).toList();

                if (filteredNotes.isEmpty) {
                  return const Center(child: Text('Sonuç bulunamadı.'));
                }

                return ListView.builder(
                  itemCount: filteredNotes.length,
                  itemBuilder: (context, index) {
                    final note = filteredNotes[index];
                    return Dismissible(
                      key: Key(note.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      confirmDismiss: (direction) async {
                        final cubit = context.read<NotesCubit>();
                        final currentNotes = List.of(cubit.state.notes);
                        cubit.emit(
                          cubit.state.copyWith(
                            notes: currentNotes
                                .where((n) => n.id != note.id)
                                .toList(),
                          ),
                        );

                        final snackBar = SnackBar(
                          content: Text('Not silindi'),
                          action: SnackBarAction(
                            label: 'İptal',
                            onPressed: () {
                              cubit.emit(
                                cubit.state.copyWith(notes: currentNotes),
                              );
                            },
                          ),
                          duration: const Duration(seconds: 3),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        await Future.delayed(const Duration(seconds: 3));
                        if (cubit.state.notes.every((n) => n.id != note.id)) {
                          await cubit.deleteNote(note.id, context);
                        }

                        return false;
                      },
                      child: ListTile(
                        onTap: () {
                          context.push('/noteDetail', extra: note);
                        },
                        title: Text(note.title),
                        subtitle: Text(
                          note.content,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            note.pinned
                                ? Icons.push_pin
                                : Icons.push_pin_outlined,
                            color: note.pinned ? AppColor.primary : Colors.grey,
                          ),
                          onPressed: () {
                            context.read<NotesCubit>().togglePin(note);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
