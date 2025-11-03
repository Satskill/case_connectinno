import 'package:case_connectinno/core/providers/auth_provider.dart';
import 'package:case_connectinno/core/util/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:case_connectinno/core/constant/app_text_style.dart';
import 'package:case_connectinno/core/constant/color.dart';
import 'package:case_connectinno/core/constant/ui.dart';
import 'package:case_connectinno/core/util/validator.dart';
import 'package:case_connectinno/widget/Form/app_form_field.dart';
import 'package:case_connectinno/widget/base/profile_field.dart';
import 'package:case_connectinno/widget/button/loading_button.dart';
import 'package:case_connectinno/widget/dialog/app_alert_dialog.dart';
import 'package:case_connectinno/widget/form/title_form_field.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  static final _formKey = GlobalKey<FormState>();
  final fullnameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fullnameController.text =
        context.read<AuthCubit>().state.user?.fullName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.baseWhite,
      appBar: AppBar(title: const Text('Profil')),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is AuthLoggedOut) {
            context.go('/login');
          }
        },
        builder: (context, state) {
          return Padding(
            padding: AppUI.fullPadding,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const ProfileField(
                        text: 'Kullanıcı Bilgileri',
                        image: 'profile-edit',
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppUI.verticalGap(),
                            TitleFormField(
                              title: 'Ad Soyad',
                              isPrimary: true,
                              field: Container(
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: AppFormField(
                                  hintText: 'Ad Soyad',
                                  obscureText: false,
                                  controller: fullnameController,
                                  validator: AppValidator.emptyValidator,
                                  padding: AppUI.fullPadding,
                                  selectedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: AppColor.primary,
                                    ),
                                  ),
                                  keyboardType: TextInputType.name,
                                ),
                              ),
                            ),
                            Padding(
                              padding: AppUI.vertical * 2,
                              child: LoadingButton(
                                padding: AppUI.fullPadding / 1.5,
                                decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthCubit>().updateUserName(
                                      fullnameController.text.trim(),
                                    );
                                  }
                                },
                                child: Text(
                                  'Güncelle',
                                  style: AppTextStyle.selectedSize.copyWith(
                                    color: AppColor.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const ProfileField(
                        text: 'Hesap Ayarları',
                        image: 'profile-edit',
                      ),
                      AppUI.verticalGap(),
                      GestureDetector(
                        onTap: () {
                          context.showAppDialog(
                            AppAlertDialog(
                              type: AlertType.warn,
                              isSingleButton: false,
                              leftButtonText: 'Sil',
                              rightButtonText: 'Vazgeç',
                              title:
                                  'Hesabınızı silmek istediğinize emin misiniz?',
                              leftFunction: () async {
                                context.read<AuthCubit>().deleteAccount();
                              },
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * .9,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: AppColor.campaignRed.withValues(alpha: .7),
                            ),
                            borderRadius: BorderRadius.circular(16.r),
                            color: AppColor.campaignRed.withValues(alpha: .15),
                          ),
                          child: Padding(
                            padding: AppUI.fullPadding * .9,
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/delete.png',
                                  color: AppColor.campaignRed.withValues(
                                    alpha: .7,
                                  ),
                                  height: 28.h,
                                ),
                                AppUI.horizontalGap(.5),
                                Text(
                                  'Hesabımı Sil',
                                  style: AppTextStyle.selectedSize.copyWith(
                                    color: AppColor.campaignRed.withValues(
                                      alpha: .7,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
