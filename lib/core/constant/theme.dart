import 'package:flutter/material.dart';
import 'color.dart';

class AppTheme {
  AppTheme._();

  static ThemeData theme = ThemeData(
    fontFamily: 'Nunito',
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColor.white,
    colorScheme: ColorScheme.light(primary: AppColor.white),
  );
}
