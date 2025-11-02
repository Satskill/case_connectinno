import 'package:flutter/material.dart';

class AppColor {
  const AppColor._();

  static const baseWhite = Color(0xfffafafa);
  static const baseBlack = Color(0xff221F20);

  static const primary = Color(0xffEC1C24);
  static const secondary = Color(0xffFFC10E);
  static const success = Color(0xffA4F4E7);
  static const warning = Color(0xffF4C790);
  static const error = Color(0xffE4626F);
  static const campaignRed = Color(0xff810000);

  static const policyBlue = Color(0xff007BFF);

  static const borderColor = Color(0xffEAEBEC);
  static const activeBorderColor = Color(0xff0B7B69);
  static const boldBorderColor = Color(0xff5E5858);
  static const settingsColor = Color(0xff726B6C);
  static const mailboxColor = Color(0xffFCD9DB);
  static const buttonPassiveColor = Color(0xffE6E6E6);
  static const ingredientColor = Color(0xff867F80);
  static const passiveButtonTextColor = Color(0xff999494);

  static const white = Color(0xffffffff);
  static const gray = Color(0xff9E9E9E);
  static const black = Color(0xff000000);

  static Color hexToColor(String hexString) {
    hexString = hexString.replaceAll("#", "");
    if (hexString.length == 6) {
      hexString = "FF$hexString";
    }
    return Color(int.parse(hexString, radix: 16));
  }
}
