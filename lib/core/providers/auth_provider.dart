import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';

class AuthState {
  final UserModel? user;
  final bool loading;
  final String? error;

  const AuthState({
    this.user,
    this.loading = false,
    this.error,
  });

  AuthState copyWith({
    UserModel? user,
    bool? loading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  AuthCubit(this.repository) : super(const AuthState());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(loading: true));
    try {
      final user = await repository.login(email: email, password: password);
      emit(state.copyWith(user: user, loading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), loading: false));
    }
  }

  Future<void> register(String email, String password, String fullName) async {
    emit(state.copyWith(loading: true));
    try {
      final user = await repository.register(
        email: email,
        password: password,
        fullName: fullName,
      );
      emit(state.copyWith(user: user, loading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), loading: false));
    }
  }

  Future<void> updateProfile(UserModel updatedUser) async {
    emit(state.copyWith(loading: true));
    try {
      final newUser = await repository.updateProfile(updatedUser);
      emit(state.copyWith(user: newUser, loading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), loading: false));
    }
  }

  Future<void> deleteAccount() async {
    emit(state.copyWith(loading: true));
    try {
      await repository.deleteAccount();
      emit(const AuthState(user: null, loading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), loading: false));
    }
  }

  Future<void> logout() async {
    await repository.logout();
    emit(const AuthState(user: null));
  }
}
