import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> save(String key, dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(data));
  }

  static Future<List<Map<String, dynamic>>> loadList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List;
    return list.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  static Future<void> clear(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
