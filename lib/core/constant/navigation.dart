import 'package:case_connectinno/screen/auth/login/login.dart';
import 'package:case_connectinno/screen/auth/register/register.dart';
import 'package:case_connectinno/screen/dashboard/add/add_note.dart';
import 'package:case_connectinno/screen/dashboard/detail/note_detail.dart';
import 'package:case_connectinno/screen/dashboard/notes.dart';
import 'package:case_connectinno/screen/dashboard/profile/profile.dart';
import 'package:case_connectinno/screen/landing/landing_page.dart';
import 'package:case_connectinno/widget/base/loading.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const rootKey = GlobalObjectKey<NavigatorState>('root');
const _mainShellKey = GlobalObjectKey<NavigatorState>('shell');

class AppRouterConfig {
  static final analytics = FirebaseAnalytics.instance;
  static final firebaseObserver = FirebaseAnalyticsObserver(
    analytics: analytics,
  );

  static GoRouter router = GoRouter(
    navigatorKey: rootKey,
    initialLocation: '/landing_screen',
    redirect: (context, state) {
      if (state.error != null) {
        return '/';
      } else {
        return null;
      }
    },
    errorPageBuilder: (context, state) => NoTransitionPage(
      child: Scaffold(
        appBar: AppBar(),
        body: const SafeArea(child: PageError()),
      ),
    ),
    observers: [firebaseObserver],
    routes: [
      GoRoute(
        path: '/',
        parentNavigatorKey: rootKey,
        name: 'Ana Sayfa',
        builder: (context, state) => const NotesSearchView(),
      ),
      GoRoute(
        path: '/landing_screen',
        parentNavigatorKey: rootKey,
        name: 'Karşılama Sayfası',
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        path: '/register',
        parentNavigatorKey: rootKey,
        name: 'Kayıt Sayfası',
        builder: (context, state) => const Register(),
      ),
      GoRoute(
        path: '/login',
        parentNavigatorKey: rootKey,
        name: 'Giriş Sayfası',
        builder: (context, state) => const Login(),
      ),
      GoRoute(
        path: '/profile',
        parentNavigatorKey: rootKey,
        name: 'Profil',
        builder: (context, state) => const Profile(),
      ),
      GoRoute(
        path: '/addNote',
        parentNavigatorKey: rootKey,
        name: 'Not Ekle',
        builder: (context, state) => const AddNote(),
      ),
      GoRoute(
        path: '/noteDetail',
        parentNavigatorKey: rootKey,
        name: 'Not Detay',
        builder: (context, state) => NoteDetail(note: state.extra as dynamic),
      ),
    ],
  );
}
