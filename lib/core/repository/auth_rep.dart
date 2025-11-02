import 'package:dio/dio.dart';
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<UserModel> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final res = await _dio.post('/auth/register', data: {
      'email': email,
      'password': password,
      'fullName': fullName,
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', res.data['token']);

    return UserModel.fromJson(res.data['user']);
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final res = await _dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', res.data['token']);

    return UserModel.fromJson(res.data['user']);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  Future<UserModel> updateProfile(UserModel user) async {
    final res = await _dio.put('/auth/profile', data: user.toJson());
    return UserModel.fromJson(res.data['user']);
  }

  Future<void> deleteAccount() async {
    await _dio.delete('/auth/delete');
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
