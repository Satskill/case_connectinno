import 'package:case_connectinno/core/constant/color.dart';
import 'package:case_connectinno/core/constant/navigation.dart';
import 'package:case_connectinno/core/constant/theme.dart';
import 'package:case_connectinno/core/providers/auth_provider.dart';
import 'package:case_connectinno/core/providers/note_provider.dart';
import 'package:case_connectinno/core/repository/auth_rep.dart';
import 'package:case_connectinno/core/repository/note_rep.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_http_request.dart' as intl;
import 'package:intl/intl.dart';

import 'firebase_options.dart';

const appLocale = Locale('tr', 'TR');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: 'case-connectinno',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top],
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Intl.defaultLocale = 'tr_TR';
  await intl.initializeDateFormatting('tr_TR', '');
  await Future.delayed(const Duration(milliseconds: 500));

  runApp(const CaseConnectinnoApp());
}

class CaseConnectinnoApp extends StatelessWidget {
  const CaseConnectinnoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(AuthRepository(dio))..init(),
        ),
        BlocProvider<NotesCubit>(
          create: (_) => NotesCubit(NotesRepository(dio))..loadNotes(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, __) {
          return MaterialApp.router(
            color: AppColor.primary,
            theme: AppTheme.theme,
            routerConfig: AppRouterConfig.router,
            debugShowCheckedModeBanner: false,
            scrollBehavior: const CupertinoScrollBehavior(),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [appLocale],
            locale: appLocale,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.noScaling),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
