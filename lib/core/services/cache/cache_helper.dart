import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({required String key, required dynamic value}) async {
    if (_preferences == null) return false;

    if (value is String) return await _preferences!.setString(key, value);
    if (value is int) return await _preferences!.setInt(key, value);
    if (value is bool) return await _preferences!.setBool(key, value);
    if (value is double) return await _preferences!.setDouble(key, value);
    if (value is List<String>) return await _preferences!.setStringList(key, value);

    return await _preferences!.setString(key, jsonEncode(value));
  }

  static dynamic getData({required String key}) {
    return _preferences?.get(key);
  }

  static List<dynamic>? getJsonList(String key) {
    final raw = _preferences?.getString(key);
    if (raw == null || raw.isEmpty) return null;
    final decoded = jsonDecode(raw);
    return decoded is List ? decoded : null;
  }

  static Future<bool> removeData({required String key}) async {
    return await _preferences!.remove(key);
  }

  static Future<bool> clear() async {
    return await _preferences!.clear();
  }
}

