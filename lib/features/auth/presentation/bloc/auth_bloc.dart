
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/usecase/login_user.dart';
import '../../domain/usecase/logout_user.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final LogoutUser logoutUser;

  AuthBloc({
    required this.loginUser,
    required this.logoutUser,
    }) : super(const AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final user = await loginUser(
        email: event.email,
        password: event.password,
      );

      emit(AuthSuccess(user));
    } catch (_) {
      emit(
        const AuthFailure(
          'Login failed. Please check your credentials and try again.',
        ),
      );
    }
  }

  Future<void> _onLogoutRequested(
  LogoutRequested event,
  Emitter<AuthState> emit,
) async {
  emit(const AuthLoading());

  try {
    await logoutUser();
    emit(const AuthInitial());
  } catch (_) {
    emit(
      const AuthFailure(
        'Logout failed. Please try again.',
      ),
    );
  }
}
  
}
