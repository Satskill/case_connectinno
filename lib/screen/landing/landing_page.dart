import 'package:case_connectinno/core/constant/color.dart';
import 'package:case_connectinno/core/constant/ui.dart';
import 'package:case_connectinno/core/providers/auth_provider.dart';
import 'package:case_connectinno/core/services/device_service.dart';
import 'package:case_connectinno/core/services/log.dart';
import 'package:case_connectinno/widget/base/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

String? fcmToken;
String? apnsToken;

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    try {
      initApp();
    } catch (e) {
      LogService.logLn('init App Error:', error: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (DeviceService.isInit == false) {
      DeviceService.init(context);
    }
    return Scaffold(
      backgroundColor: AppColor.baseWhite,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: AppUI.fullPadding * 2,
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width * .3,
                  ),
                ),
              ),
            ),
            const LoadingWidget(color: AppColor.primary, size: 48),
          ],
        ),
      ),
    );
  }

  void initApp() async {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
      value,
    ) {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          if (context.read<AuthCubit>().state.user != null) {
            context.go('/');
          } else {
            context.go('/login');
          }
        }
      });
    });
  }
}
