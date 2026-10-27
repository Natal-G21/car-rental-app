
import 'package:firebase_auth/firebase_auth.dart' as firebase;

class AuthRemoteDataSource {
  final firebase.FirebaseAuth firebaseAuth;

  AuthRemoteDataSource({
    required this.firebaseAuth,
  });

  Future<firebase.User> login({
    required String email,
    required String password,
  }) async {
    final credential =
        await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;

    if (user == null) {
      throw Exception('Login succeeded without a user.');
    }

    return user;
  }
  Future<void> logout() async {
  await firebaseAuth.signOut();
}
}
