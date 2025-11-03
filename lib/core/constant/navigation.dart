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
      /*GoRoute(
            path: '/productDetail',
            parentNavigatorKey: rootKey,
            name: 'Ürün Detay Sayfası',
            builder: (context, state) =>
                ProductDetailScreen(data: state.extra as SingleProductModel),
            onExit: (context, state) {
              context.read<ProductProvider>().clearCache();
              return true;
            }),
        GoRoute(
            path: '/profile',
            parentNavigatorKey: rootKey,
            name: 'Profil Sayfası',
            builder: (context, state) => const ProfileScreen()),
        GoRoute(
            path: '/myCoupons',
            parentNavigatorKey: rootKey,
            name: 'Kuponlarım',
            builder: (context, state) => MyCouponsScreen(
                  lastScreen: state.extra as String,
                )),
        GoRoute(
            path: '/couponsCampaigns',
            parentNavigatorKey: rootKey,
            name: 'Kuponlarım & Kampanyalarım',
            builder: (context, state) => CouponsCampaignsScreen(
                  lastScreen: state.extra as String,
                )),
        GoRoute(
            path: '/guest',
            parentNavigatorKey: rootKey,
            name: 'Misafir Adres Sayfası',
            builder: (context, state) =>
                GuestAddressScreen(model: state.extra as LocationModel),
            onExit: (context, state) {
              context.read<AuthProvider>().updateGuestCustomerModel(null);
              return true;
            }),
        GoRoute(
          path: '/settings',
          parentNavigatorKey: rootKey,
          name: 'Ayarlar Sayfası',
          builder: (context, state) =>
              ProfileSettingsScreen(model: state.extra as CustomerModel),
        ),
        GoRoute(
            path: '/setPassword',
            parentNavigatorKey: rootKey,
            name: 'Şifre Değiştirme Sayfası',
            builder: (context, state) => const PasswordChangeScreen()),
        GoRoute(
            path: '/updateInfo',
            parentNavigatorKey: rootKey,
            name: 'Bilgileri Güncelleme Sayfası',
            builder: (context, state) =>
                InfoChangeScreen(model: state.extra as CustomerModel)),
        GoRoute(
            path: '/cart',
            parentNavigatorKey: rootKey,
            name: 'Sepet Sayfası',
            builder: (context, state) => const CartScreen()),
        GoRoute(
            path: '/checkout',
            parentNavigatorKey: rootKey,
            name: 'Ödeme Sayfası',
            builder: (context, state) => CheckoutScreen(
                  couponPaymentType: (state.extra as Map)['couponPaymentType'],
                  productPaymentType:
                      (state.extra as Map)['productPaymentType'],
                )),
        GoRoute(
            path: '/securePay/:id',
            parentNavigatorKey: rootKey,
            name: '3D Ödeme Sayfası',
            builder: (context, state) => SecurePayScreen(
                html: state.extra as String,
                orderID: state.pathParameters['id'] as String)),
        GoRoute(
            path: '/stories',
            parentNavigatorKey: rootKey,
            name: 'Hikayeler Sayfası',
            builder: (context, state) =>
                StoriesSlider(index: state.extra as int)),
        GoRoute(
            path: '/map',
            parentNavigatorKey: rootKey,
            name: 'Adres Seçim Sayfası',
            builder: (context, state) => const MapScreen()),
        GoRoute(
            path: '/address',
            parentNavigatorKey: rootKey,
            name: 'Adres Güncelleme Sayfası',
            builder: (context, state) =>
                ProfileAddressScreen(model: state.extra as LocationModel)),
        GoRoute(
            path: '/orderStatus',
            parentNavigatorKey: rootKey,
            name: 'Sipariş Durum Sayfası',
            builder: (context, state) => OrderResultScreen()),
        GoRoute(
            path: '/previous',
            parentNavigatorKey: rootKey,
            name: 'Önceki Siparişleri Görüntüleme Sayfası',
            builder: (context, state) => const ProfilePreviousScreen()),
        GoRoute(
            path: '/otp/:id',
            parentNavigatorKey: rootKey,
            name: 'OTP Onay Sayfası',
            builder: (context, state) => OtpScreen(
                customerID: state.pathParameters['id'] ?? '',
                phone: state.extra as String)),
        // AUTH ROUTES
        GoRoute(
            path: '/register',
            parentNavigatorKey: rootKey,
            name: 'Kayıt Sayfası',
            builder: (context, state) => const RegisterScreen()),
        GoRoute(
            path: '/login',
            parentNavigatorKey: rootKey,
            name: 'Giriş Sayfası',
            builder: (context, state) => const LoginScreen())*/
      //END OF ROUTES
    ],
  );
}
