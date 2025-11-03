import 'package:case_connectinno/core/constant/color.dart';
import 'package:case_connectinno/core/constant/navigation.dart';
import 'package:case_connectinno/core/constant/theme.dart';
import 'package:case_connectinno/core/providers/auth_provider.dart';
import 'package:case_connectinno/core/providers/note_provider.dart';
import 'package:case_connectinno/core/repository/auth_rep.dart';
import 'package:case_connectinno/core/repository/note_rep.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'firebase_options.dart';

late FirebaseAuth auth;
late FirebaseFirestore firestore;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: 'case-connectinno',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  auth = FirebaseAuth.instance;

  firestore = FirebaseFirestore.instance;

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top],
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

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
          create: (_) => NotesCubit(NotesRepository())..loadNotes(),
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
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: TextScaler.noScaling),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
