import 'package:case_connectinno/core/constant/app_text_style.dart';
import 'package:case_connectinno/core/constant/color.dart';
import 'package:case_connectinno/core/constant/ui.dart';
import 'package:case_connectinno/core/providers/auth_provider.dart';
import 'package:case_connectinno/core/util/validator.dart';
import 'package:case_connectinno/widget/Form/app_form_field.dart';
import 'package:case_connectinno/widget/base/auth_header.dart';
import 'package:case_connectinno/widget/button/loading_button.dart';
import 'package:case_connectinno/widget/custom/auth_navigation_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.baseWhite,
      extendBody: true,
      body: Stack(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: MediaQuery.of(context).size.width * .7,
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * .75,
                        minWidth: double.infinity,
                      ),
                      child: Image.asset(
                        'assets/images/auth.png',
                        fit: BoxFit.fitWidth,
                        color: AppColor.primary,
                        colorBlendMode: BlendMode.srcATop,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .3),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .7,
                  child: Center(
                    child: SingleChildScrollView(
                      padding: AppUI.fullPadding,
                      child: Column(
                        children: [
                          AuthHeader(
                            title: 'Giriş Yap',
                            subtitle:
                                'Hesabınıza giriş yapmak için bilgilerinizi girin.',
                          ),
                          20.verticalSpace,
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppUI.verticalGap(),
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  child: AppFormField(
                                    controller: emailController,
                                    padding: AppUI.fullPadding,
                                    hintText: 'E-Postanızı giriniz',
                                    keyboardType: TextInputType.emailAddress,
                                    validator: AppValidator.emailValidator,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                AppUI.verticalGap(1.5),
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  child: AppFormField(
                                    hintText: 'Şifre',
                                    obscureText: true,
                                    controller: passwordController,
                                    padding: AppUI.fullPadding,
                                    textInputAction: TextInputAction.done,
                                    validator: AppValidator.passwordValidator,
                                    keyboardType: TextInputType.visiblePassword,
                                  ),
                                ),
                                AppUI.verticalGap(),
                                AuthNavigationText(isLogin: true),
                                AppUI.verticalGap(4),
                                Padding(
                                  padding: AppUI.horizontal * 2,
                                  child: LoadingButton(
                                    padding: AppUI.fullPadding / 1.5,
                                    decoration: BoxDecoration(
                                      color: AppColor.baseWhite,
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        await context.read<AuthCubit>().login(
                                          emailController.text,

                                          passwordController.text,
                                          context,
                                        );
                                      }
                                    },
                                    child: Text(
                                      'Giriş Yap',
                                      style: AppTextStyle.selectedSize.copyWith(
                                        color: AppColor.primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
