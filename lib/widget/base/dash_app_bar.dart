import 'package:case_connectinno/core/constant/color.dart';
import 'package:case_connectinno/core/constant/ui.dart';
import 'package:case_connectinno/widget/button/profile_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.baseWhite,
      toolbarHeight: 54.h,
      centerTitle: false,
      title: Padding(
        padding: EdgeInsets.only(bottom: 6.h, left: 12.w),
        child: Image.asset(
          'assets/images/logo.png',
          width: MediaQuery.of(context).size.width * .1,
          fit: BoxFit.contain,
        ),
      ),
      leading: Container(),
      leadingWidth: 0,
      shadowColor: AppColor.primary,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8.r),
          bottomRight: Radius.circular(8.r),
        ),
      ),
      actions: [
        Padding(
          padding: AppUI.horizontal / 2 + EdgeInsets.only(bottom: 4.h),
          child: ProfilePopup(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(54.h);
}
