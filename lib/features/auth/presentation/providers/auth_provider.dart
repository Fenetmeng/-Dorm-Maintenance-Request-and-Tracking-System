import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/auth_repository.dart';
import '../../domain/models/user_model.dart';

class AuthState {
  final UserModel? currentUser;
  final bool isLoading;
  final String? errorMessage;

  const AuthState({
    this.currentUser,
    this.isLoading = false,
    this.errorMessage,
  });

  bool get isLoggedIn => currentUser != null;
  bool get isAdmin => currentUser?.role == 'admin';
  bool get isUser => currentUser?.role == 'user';

  AuthState copyWith({
    UserModel? currentUser,
    bool? isLoading,
    String? errorMessage,
    bool clearUser = false,
    bool clearError = false,
  }) {
    return AuthState(
      currentUser: clearUser ? null : currentUser ?? this.currentUser,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  late final AuthRepository _repository;

  @override
  AuthState build() {
    _repository = ref.read(authRepositoryProvider);
    return const AuthState();
  }

  Future<void> createDefaultAdminIfNeeded() async {
    await _repository.createDefaultAdminIfNeeded();
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
    String role = 'user',
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final user = await _repository.signup(
        name: name,
        email: email,
        password: password,
        role: role,
      );

      state = AuthState(
        currentUser: user,
        isLoading: false,
      );
    } catch (e) {
      state = AuthState(
        currentUser: null,
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final user = await _repository.login(
        email: email,
        password: password,
      );

      state = AuthState(
        currentUser: user,
        isLoading: false,
      );
    } catch (e) {
      state = AuthState(
        currentUser: null,
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> deleteAccount() async {
    final user = state.currentUser;

    if (user == null) return;

    state = state.copyWith(isLoading: true, clearError: true);

    await _repository.deleteAccount(user.email);

    state = const AuthState();
  }

  void logout() {
    state = const AuthState();
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }
}