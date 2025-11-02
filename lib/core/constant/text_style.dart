
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color.dart';

class AppTextStyle {
  AppTextStyle._();


  // Mobile Heading Styles

  static TextStyle display1 = TextStyle(fontSize: 44.sp, fontWeight: FontWeight.w700);
  static TextStyle display2 = TextStyle(fontSize: 40.sp, fontWeight: FontWeight.w700);
  static TextStyle display3 = TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w700);

  static TextStyle heading1 = TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w700);
  static TextStyle heading2 = TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700);
  static TextStyle priceTitle = TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600);
  static TextStyle heading3 = TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700);
  static TextStyle heading4 = TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700);

  static TextStyle featureBold = TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700);
  static TextStyle featureStandard = TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic);

  static TextStyle highlightBold = TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700);
  static TextStyle selectedSize = TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600);
  static TextStyle highlightStandard = TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400);

  static TextStyle contentBold = TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700);
  static TextStyle productTitle = TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600);
  static TextStyle studentName = TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500);
  static TextStyle studentNameDefault = TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400);
  static TextStyle contentStandard = TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic);

  static TextStyle campaignSwitchText = TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400);

  static TextStyle caption = TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700, fontStyle: FontStyle.italic);
  static TextStyle captionStandard = TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700);
  static TextStyle bannerText = TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600);
  static TextStyle eventTitle = TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400);
  static TextStyle forgottenPassword = TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500);
  static TextStyle cartText = TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600);
  static TextStyle footnote = TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w700);
  static TextStyle profileCategory = TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600);
  static TextStyle ingredient = TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500);
  static TextStyle footnoteThin = TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400);

  //End of mobile text styles

  static TextStyle title = TextStyle(fontSize: 18.sp);
  static TextStyle defaultBlackText = const TextStyle();
  static TextStyle defaultWhiteText = const TextStyle();
  static TextStyle description = const TextStyle();
  static TextStyle subtitle = const TextStyle();

  static TextStyle bigButtonText = TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600);
  static TextStyle smallButtonText = TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500);
  static TextStyle smallText = TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500);

  static TextStyle dialogTitle = TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600);
  static TextStyle addressTitle = TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500);
  static TextStyle dialogText = TextStyle(fontSize: 14.sp);

  static TextStyle fieldText = TextStyle(fontSize: 11.sp);
  static TextStyle contentText = TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500);
  static TextStyle orderTitleText = TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400);
  static TextStyle fieldHint = TextStyle(fontSize: 11.sp, color: AppColor.gray);
  static TextStyle dateHint = TextStyle(fontSize: 13.sp, color: AppColor.gray);
  static TextStyle fieldError = TextStyle(fontSize: 11.sp);
  static TextStyle fieldTitle = TextStyle(fontSize: 12.sp);
  static TextStyle formCardTitle = TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500);

  static TextStyle settingTile = TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500);
  static TextStyle promotion = TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400);
  static TextStyle priceText = TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700);

  static TextStyle sliderChip = TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w300, color: AppColor.white);
  static TextStyle sliderTitle = TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColor.white);
  static TextStyle sliderDesc = TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300, color: AppColor.white.withOpacity(0.9));

  static TextStyle mainSubtitle = TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500);
  static TextStyle paninoText = TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500);
  static TextStyle paninoContactText = TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w500);
  static TextStyle subtitleTextButton = TextStyle(fontSize: 13.sp, color: AppColor.primary);

  static TextStyle smallCardTitle = TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500);
  static TextStyle smallCardDesc = TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w300);

  static TextStyle drawerButton = TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500);
  static TextStyle messageSenderStyle = TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: Colors.black, letterSpacing: -0.5);

  static TextStyle textProductHeader = TextStyle(fontSize: 30.sp, fontFamily: 'Cheddar', fontWeight: FontWeight.w500, color: AppColor.black);
  static TextStyle fastMenuText = TextStyle(fontSize: 20.sp, fontFamily: 'Cheddar', fontWeight: FontWeight.w500, color: AppColor.black);
  static TextStyle franchiseStepsHeader = TextStyle(fontSize: 24.sp, fontFamily: 'Cheddar', fontWeight: FontWeight.w400, color: AppColor.primary);
  static TextStyle textProductSub = TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400, color: AppColor.gray);

  static TextStyle imagePageHeaderTitle = TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColor.white);
  static TextStyle imagePageHeaderDesc = TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300, color: AppColor.white.withOpacity(0.8));

  static TextStyle blogText = TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w300);

  static TextStyle chipText = TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w300);

  static TextStyle notificationTitle = TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500);
  static TextStyle notificationDesc = TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w300, color: AppColor.gray.withOpacity(0.8));

  static TextStyle contactCardTitle = TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500, color: AppColor.white);

  static TextStyle imageError = TextStyle(fontSize: 11.sp, color: AppColor.primary);
  static TextStyle imageErrorCode = TextStyle(fontSize: 11.sp, color: AppColor.gray);
}