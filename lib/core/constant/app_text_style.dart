import 'package:case_connectinno/core/constant/color.dart';
import 'package:case_connectinno/core/services/device_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle highlightBold = GoogleFonts.manrope(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle selectedSize = GoogleFonts.manrope(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle highlightStandard = GoogleFonts.manrope(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle contentBold = GoogleFonts.manrope(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle contentStandard = GoogleFonts.manrope(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  );

  static TextStyle authNoneSwitchText = GoogleFonts.manrope(
    fontWeight: FontWeight.w400,
    color: AppColor.baseWhite,
    decoration: TextDecoration.none,
  );

  static TextStyle authSwitchText = GoogleFonts.manrope(
    fontWeight: FontWeight.bold,
    color: AppColor.white,
    decoration: TextDecoration.underline,
  );

  static TextStyle profileHeaderStyle = GoogleFonts.manrope(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: AppColor.baseBlack,
  );

  static TextStyle generalHeaderStyle = GoogleFonts.manrope(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: AppColor.baseBlack,
  );

  static TextStyle profilePopUp = GoogleFonts.manrope(
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
    color: AppColor.gray,
  );

  static TextStyle userNameBar = GoogleFonts.manrope(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: AppColor.baseBlack,
  );

  static TextStyle captionStandard = GoogleFonts.manrope(
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle bannerText = GoogleFonts.manrope(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle eventTitle = GoogleFonts.manrope(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle forgottenPassword = GoogleFonts.manrope(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle cartText = GoogleFonts.manrope(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle bigButtonText = GoogleFonts.manrope(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle smallButtonText = GoogleFonts.manrope(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle smallText = GoogleFonts.manrope(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle dialogTitle = GoogleFonts.manrope(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle dialogText = GoogleFonts.manrope(fontSize: 14.sp);

  static TextStyle fieldText = TextStyle(fontSize: 11.sp);
  static TextStyle contentText = GoogleFonts.manrope(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle fieldHint = GoogleFonts.manrope(
    fontSize: 11.sp,
    color: AppColor.gray,
  );
  static TextStyle dateHint = GoogleFonts.manrope(
    fontSize: 13.sp,
    color: AppColor.gray,
  );
  static TextStyle fieldError = GoogleFonts.manrope(fontSize: 11.sp);
  static TextStyle fieldTitle = GoogleFonts.manrope(fontSize: 12.sp);
  static TextStyle formCardTitle = GoogleFonts.manrope(
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
    color: AppColor.baseBlack,
  );

  static TextStyle offerCardDetailTitle = GoogleFonts.manrope(
    fontSize: 15.sp,
    fontWeight: FontWeight.bold,
    color: AppColor.baseWhite,
  );
  static TextStyle offerCardDetailText = GoogleFonts.manrope(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: AppColor.baseBlack.withValues(alpha: .9),
  );

  static TextStyle leadHeadName = GoogleFonts.manrope(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: AppColor.white,
  );

  static TextStyle authHeaderTitle = GoogleFonts.manrope(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: AppColor.white,
  );

  static TextStyle authHeaderText = GoogleFonts.manrope(
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
    color: AppColor.baseWhite,
  );

  static TextStyle sliderTitle = GoogleFonts.manrope(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.white,
  );

  static TextStyle drawerButton = GoogleFonts.manrope(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle messageSenderStyle = GoogleFonts.manrope(
    fontSize: 13.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    letterSpacing: -0.5,
  );

  static TextStyle imageError = GoogleFonts.manrope(
    fontSize: 11.sp,
    color: AppColor.primary,
  );
  static TextStyle imageErrorCode = GoogleFonts.manrope(
    fontSize: 11.sp,
    color: AppColor.gray,
  );
}
