import 'package:case_connectinno/core/util/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color.dart';

class AppUI {
  AppUI._();

  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration pageTransitionDuration = Duration(milliseconds: 400);

  static const double paddingValue = 20;

  static const double radiusValue = 6;
  static Radius radius = const Radius.circular(radiusValue).r;
  static BorderRadius cardBorderRadius = BorderRadius.circular(radiusValue).r;
  static RoundedRectangleBorder rectangelBorder = RoundedRectangleBorder(borderRadius: cardBorderRadius);

  static const innerRadius = 12.0;
  static const outerRadius = innerRadius + paddingValue;

  static BoxDecoration boxDecoration = BoxDecoration(color: AppColor.primary, borderRadius: AppUI.borderRadius);

  static BorderRadius borderRadius = BorderRadius.circular(innerRadius);

  static SizedBox verticalBlankSpace = 21.vb;
  static SizedBox horizontalBlankSpace = 12.hb;

  static const horizontal = EdgeInsets.symmetric(horizontal: paddingValue);
  static const vertical = EdgeInsets.symmetric(vertical: paddingValue);
  static EdgeInsets get fullPadding => vertical + horizontal;

  static BoxDecoration borderedBoxDecoration = BoxDecoration(
    color: AppColor.primary,
    borderRadius: AppUI.borderRadius,
    border: Border.all(color: AppColor.gray, style: BorderStyle.solid),
  );

  static EdgeInsets pagePadding = const EdgeInsets.all(paddingValue).r;
  static EdgeInsets pageHalfPadding = const EdgeInsets.all(paddingValue / 2).r;
  static EdgeInsets pagePaddingHorizontal = const EdgeInsets.symmetric(horizontal: paddingValue).r;
  static EdgeInsets pagePaddingHalfHorizontal = const EdgeInsets.symmetric(horizontal: paddingValue / 2).r;
  static EdgeInsets pagePaddingVertical = const EdgeInsets.symmetric(vertical: paddingValue).r;
  static EdgeInsets pagePaddingVerticalQuarter = const EdgeInsets.symmetric(vertical: paddingValue / 4).r;
  static EdgeInsets pagePaddingQuarter = const EdgeInsets.all(paddingValue / 4).r;
  static EdgeInsets pageMarginBottom = const EdgeInsets.only(bottom: paddingValue).r;
  static EdgeInsets onboardBottomPadding = const EdgeInsets.only(left: paddingValue / 2, right: paddingValue / 2, bottom: paddingValue / 2).r;
  static EdgeInsets buttonPadding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10).r;
  static EdgeInsets pageScrollPadding(BuildContext context) => EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + paddingValue).r;

  /// ([paddingValue] = 12.0) * [multipler]
  static SizedBox horizontalGap([double multipler = 1]) => SizedBox(width: paddingValue * multipler);

  /// ([paddingValue] = 12.0) * [multipler]
  static SizedBox verticalGap([double multipler = 1]) => SizedBox(height: paddingValue * multipler);

  static SizedBox get zeroGap => const SizedBox.shrink();

  static EdgeInsets pageFullPadding(BuildContext context) =>
      EdgeInsets.only(left: paddingValue, right: paddingValue, top: paddingValue, bottom: MediaQuery.of(context).padding.bottom + paddingValue).r;
}
