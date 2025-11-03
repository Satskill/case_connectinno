import 'package:case_connectinno/core/constant/app_text_style.dart';
import 'package:case_connectinno/core/constant/color.dart';
import 'package:case_connectinno/core/constant/ui.dart';
import 'package:case_connectinno/core/providers/auth_provider.dart';
import 'package:case_connectinno/core/util/extension.dart';
import 'package:case_connectinno/widget/dialog/app_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfilePopup extends StatelessWidget {
  const ProfilePopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PopupMenuButton(
          menuPadding: AppUI.fullPadding / 3,
          position: PopupMenuPosition.under,
          borderRadius: BorderRadius.circular(16.r),
          child: Image.asset('assets/images/user.png', height: 40.h),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                onTap: () async {
                  await context.push('/profile');
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .3,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/setting.png',
                        height: 20.h,
                        color: AppColor.gray,
                      ),
                      AppUI.horizontalGap(),
                      Text('Profilim', style: AppTextStyle.profilePopUp),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  context.showAppDialog(
                    AppAlertDialog(
                      type: AlertType.warn,
                      isSingleButton: false,
                      leftButtonText: 'Çıkış Yap',
                      rightButtonText: 'Vazgeç',
                      title: 'Çıkış yapmak ister misiniz?',

                      leftFunction: () async {
                        await context.read<AuthCubit>().logout();
                        if (context.mounted) {
                          context.go('/login');
                        }
                      },
                    ),
                  );
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .3,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/logout.png',
                        height: 20.h,
                        color: AppColor.campaignRed,
                      ),
                      AppUI.horizontalGap(),
                      Text(
                        'Çıkış Yap',
                        style: AppTextStyle.profilePopUp.copyWith(
                          color: AppColor.campaignRed,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
        ),
        AppUI.horizontalGap(),
      ],
    );
  }
}
