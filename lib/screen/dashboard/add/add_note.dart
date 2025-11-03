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

class AddNote extends StatelessWidget {
  const AddNote({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController title = TextEditingController();
    final TextEditingController content = TextEditingController();

    final addnoteformKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: Text('Not Ekle')),
      body: SingleChildScrollView(
        padding: AppUI.fullPadding,
        child: Form(
          key: addnoteformKey,
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
                    if (addnoteformKey.currentState!.validate()) {
                      context.read<NotesCubit>().addNote(
                        NoteModel(
                          id: '',
                          title: title.text,
                          content: content.text,
                        ),
                        context,
                      );
                    }
                  },
                  child: Text(
                    'Ekle',
                    style: AppTextStyle.selectedSize.copyWith(
                      color: AppColor.baseWhite,
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
