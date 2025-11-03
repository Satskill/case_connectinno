import 'package:case_connectinno/core/constant/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthNavigationText extends StatelessWidget {
  final bool isLogin;

  const AuthNavigationText({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isLogin) {
          context.go('/register');
        } else {
          context.go('/login');
        }
      },
      child: Text.rich(
        TextSpan(
          text: isLogin ? "Hesabın yok mu? " : "Hesabın var mı? ",
          style: AppTextStyle.authNoneSwitchText,
          children: [
            TextSpan(
              text: isLogin ? "Kayıt Ol" : "Giriş Yap",
              style: AppTextStyle.authSwitchText,
            ),
          ],
        ),
      ),
    );
  }
}
