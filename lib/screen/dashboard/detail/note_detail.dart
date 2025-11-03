import 'package:case_connectinno/core/constant/app_text_style.dart';
import 'package:case_connectinno/core/constant/color.dart';
import 'package:case_connectinno/core/constant/ui.dart';
import 'package:case_connectinno/core/models/note.dart';
import 'package:case_connectinno/core/providers/note_provider.dart';
import 'package:case_connectinno/core/util/validator.dart';
import 'package:case_connectinno/widget/Form/app_form_field.dart';
import 'package:case_connectinno/widget/button/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteDetail extends StatelessWidget {
  final NoteModel note;
  const NoteDetail({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final TextEditingController title = TextEditingController(text: note.title);
    final TextEditingController content = TextEditingController(
      text: note.content,
    );

    final notedetailformKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: Text('Not Düzenle')),
      body: SingleChildScrollView(
        padding: AppUI.fullPadding,
        child: Form(
          key: notedetailformKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppUI.verticalGap(),
              Container(
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: AppFormField(
                  controller: title,
                  padding: AppUI.fullPadding,
                  hintText: 'Başlık',
                  keyboardType: TextInputType.text,
                  validator: AppValidator.emptyValidator,
                  textInputAction: TextInputAction.next,
                ),
              ),
              AppUI.verticalGap(1.5),
              Container(
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: AppFormField(
                  controller: content,
                  padding: AppUI.fullPadding,
                  hintText: 'İçerik',
                  keyboardType: TextInputType.text,
                  validator: AppValidator.emptyValidator,
                  textInputAction: TextInputAction.done,
                  isBigField: true,
                ),
              ),
              AppUI.verticalGap(4),
              Padding(
                padding: AppUI.horizontal * 2,
                child: LoadingButton(
                  padding: AppUI.fullPadding / 1.5,
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  onTap: () async {
                    if (notedetailformKey.currentState!.validate()) {
                      context.read<NotesCubit>().updateNote(
                        NoteModel(
                          id: note.id,
                          title: title.text,
                          content: content.text,
                        ),
                        context,
                      );
                    }
                  },
                  child: Text(
                    'Güncelle',
                    style: AppTextStyle.selectedSize.copyWith(
                      color: AppColor.baseWhite,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: AppUI.horizontal * 2,
                child: LoadingButton(
                  padding: AppUI.fullPadding / 1.5,
                  decoration: BoxDecoration(
                    color: AppColor.baseWhite,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  onTap: () async {
                    context.read<NotesCubit>().deleteNote(note.id, context);
                  },
                  child: Text(
                    'Sil',
                    style: AppTextStyle.selectedSize.copyWith(
                      color: AppColor.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
