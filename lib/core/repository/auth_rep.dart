import 'package:case_connectinno/core/models/user.dart';
import 'package:case_connectinno/core/services/log.dart';
import 'package:case_connectinno/main.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<UserModel> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    LogService.logLn('asdasdasdasd');

    final uid = credential.user!.uid;
    final user = UserModel(id: uid, email: email, fullName: fullName);

    LogService.logLn('saving');

    await firestore.collection('users').doc(uid).set(user.toJson());

    LogService.logLn('returning');

    return user;
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final credential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;
    final snapshot = await firestore.collection('users').doc(uid).get();

    if (!snapshot.exists) {
      throw Exception('User profile not found in Firestore.');
    }

    return UserModel.fromJson(snapshot.data()!..['id'] = uid);
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  Future<UserModel> updateProfile(UserModel user) async {
    final uid = auth.currentUser?.uid;
    if (uid == null) throw Exception('User not logged in.');

    await firestore.collection('users').doc(uid).update(user.toJson());
    final updated = await firestore.collection('users').doc(uid).get();

    return UserModel.fromJson(updated.data()!..['id'] = uid);
  }

  Future<void> deleteAccount() async {
    final uid = auth.currentUser?.uid;
    if (uid == null) return;

    await firestore.collection('users').doc(uid).delete();
    await auth.currentUser?.delete();
  }

  Future<String?> getToken() async {
    final user = auth.currentUser;
    return user != null ? await user.getIdToken() : null;
  }

  Future<Response> getNotes() async {
    final token = await getToken();
    if (token == null) throw Exception('No auth token found.');

    return _dio.get(
      '/notes',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
