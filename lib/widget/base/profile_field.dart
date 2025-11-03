import 'package:case_connectinno/core/constant/app_text_style.dart';
import 'package:case_connectinno/core/constant/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileField extends StatelessWidget {
  final String text;
  final String image;
  const ProfileField({required this.text, required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/images/$image.png', height: 18.h),
        AppUI.horizontalGap(.5),
        Text(text, style: AppTextStyle.profileHeaderStyle),
      ],
    );
  }
}
