
import '../repositories/auth_repository.dart';

class LogoutUser {
  final AuthRepository repository;

  const LogoutUser({
    required this.repository,
  });

  Future<void> call() {
    return repository.logout();
  }
}
