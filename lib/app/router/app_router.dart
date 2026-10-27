
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/injection_container.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/cars/presentation/pages/home_page.dart';
import 'auth_state_notifier.dart';

class AppRouter {
  static final AuthStateNotifier authStateNotifier =
      AuthStateNotifier(
    firebaseAuth: sl<FirebaseAuth>(),
  );

  static final GoRouter router = GoRouter(
    initialLocation: '/loading',
    refreshListenable: authStateNotifier,
    redirect: (context, state) {
      final location = state.matchedLocation;

      if (!authStateNotifier.isInitialized) {
        return location == '/loading' ? null : '/loading';
      }

      final isLoggedIn = authStateNotifier.user != null;

      if (isLoggedIn) {
        if (location == '/login' || location == '/loading') {
          return '/home';
        }

        return null;
      }

      if (location == '/home' || location == '/loading') {
        return '/login';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/loading',
        name: 'loading',
        builder: (context, state) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
