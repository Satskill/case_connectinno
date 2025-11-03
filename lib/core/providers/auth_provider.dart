import 'dart:convert';
import 'package:case_connectinno/core/models/user.dart';
import 'package:case_connectinno/core/repository/auth_rep.dart';
import 'package:case_connectinno/core/services/log.dart';
import 'package:case_connectinno/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState {
  final UserModel? user;
  final bool loading;
  final String? error;

  const AuthState({this.user, this.loading = false, this.error});

  AuthState copyWith({UserModel? user, bool? loading, String? error}) {
    return AuthState(
      user: user ?? this.user,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;
  AuthSuccess({required this.message});
}

class AuthError extends AuthState {
  final String error;
  AuthError(this.error);
}

class AuthLoggedOut extends AuthState {}

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  AuthCubit(this.repository) : super(const AuthState());

  /// 🔹 App başlarken local storage'dan kullanıcıyı yükler
  Future<void> init() async {
    emit(state.copyWith(loading: true));
    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString('user_data');
      if (userData != null) {
        final user = UserModel.fromJson(jsonDecode(userData));
        emit(state.copyWith(user: user, loading: false));
      } else {
        emit(state.copyWith(loading: false));
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString(), loading: false));
    }
  }

  /// 🔹 Giriş yapar ve local'e kaydeder
  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    emit(state.copyWith(loading: true));
    try {
      final user = await repository.login(email: email, password: password);
      await _saveUserToLocal(user);
      emit(state.copyWith(user: user, loading: false));

      context.go('/');
    } catch (e) {
      emit(state.copyWith(error: e.toString(), loading: false));
    }
  }

  /// 🔹 Kayıt olur ve local'e kaydeder
  Future<void> register(
    String email,
    String password,
    String fullName,
    BuildContext context,
  ) async {
    emit(state.copyWith(loading: true));
    try {
      LogService.logLn('fsdfsdf');
      final user = await repository.register(
        email: email,
        password: password,
        fullName: fullName,
      );

      LogService.logLn(user.toJson().toString());
      await _saveUserToLocal(user);
      emit(state.copyWith(user: user, loading: false));

      context.go('/');
    } catch (e) {
      emit(state.copyWith(error: e.toString(), loading: false));
    }
  }

  Future<void> updateUserName(String newName) async {
    try {
      emit(AuthLoading());
      final uid = auth.currentUser?.uid;
      if (uid == null) throw Exception("Kullanıcı oturumu bulunamadı");

      await firestore.collection('users').doc(uid).update({
        'fullName': newName,
      });

      emit(AuthSuccess(message: "Ad soyad başarıyla güncellendi."));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// 🔹 Hesabı siler ve local veriyi temizler
  Future<void> deleteAccount() async {
    emit(state.copyWith(loading: true));
    try {
      await repository.deleteAccount();
      await _clearLocalUser();
      emit(const AuthState(user: null, loading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), loading: false));
    }
  }

  /// 🔹 Çıkış yapar ve local veriyi siler
  Future<void> logout() async {
    await repository.logout();
    await _clearLocalUser();
    emit(const AuthState(user: null));
  }

  /// 🔸 SharedPreferences'e user kaydeder
  Future<void> _saveUserToLocal(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', jsonEncode(user.toJson()));
  }

  /// 🔸 SharedPreferences'ten user siler
  Future<void> _clearLocalUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
  }
}
