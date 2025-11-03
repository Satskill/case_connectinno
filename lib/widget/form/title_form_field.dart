import 'package:case_connectinno/core/constant/app_text_style.dart';
import 'package:case_connectinno/core/constant/color.dart';
import 'package:case_connectinno/widget/form/app_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleFormField extends StatelessWidget {
  final Widget? field;
  final String? title;
  final bool isPrimary;
  final String? error;
  const TitleFormField({
    super.key,
    this.field,
    this.title,
    required this.isPrimary,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Text(
                title!,
                style: AppTextStyle.cartText.copyWith(
                  color: isPrimary
                      ? AppColor.primary
                      : AppColor.ingredientColor,
                ),
              )
            : const SizedBox(),
        SizedBox(height: 4.h),
        field ?? const AppFormField(),
        error != null
            ? Text(error!, style: AppTextStyle.fieldError)
            : const SizedBox.shrink(),
      ],
    );
  }
}
