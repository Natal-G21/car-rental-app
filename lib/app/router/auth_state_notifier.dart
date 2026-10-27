
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthStateNotifier extends ChangeNotifier {
  final FirebaseAuth firebaseAuth;

  late final StreamSubscription<User?> _subscription;

  User? user;
  bool isInitialized = false;

  AuthStateNotifier({
    required this.firebaseAuth,
  }) {
    _subscription = firebaseAuth.authStateChanges().listen(
      (firebaseUser) {
        user = firebaseUser;
        isInitialized = true;
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
