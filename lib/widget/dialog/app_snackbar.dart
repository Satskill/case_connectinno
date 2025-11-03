import 'package:case_connectinno/core/constant/app_text_style.dart';
import 'package:case_connectinno/core/constant/color.dart';
import 'package:flutter/material.dart';

class AppSnackbar {
  showCopySnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text('Kopyalandı', style: AppTextStyle.contentBold),
        ),
        behavior: SnackBarBehavior.floating,
        shape: StadiumBorder(),
        width: MediaQuery.of(context).size.width * 0.35,
        backgroundColor: AppColor.primary.withValues(alpha: .7),
      ),
    );
  }

  showSnackText(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(text, style: AppTextStyle.contentBold)),
        behavior: SnackBarBehavior.floating,
        shape: StadiumBorder(),
        width: MediaQuery.of(context).size.width * 0.7,
        backgroundColor: AppColor.primary.withValues(alpha: .7),
      ),
    );
  }
}
