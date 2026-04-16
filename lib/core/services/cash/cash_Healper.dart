import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _preferences;

  // 1. تهيئة SharedPreferences
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

 
  static Future<bool> saveData({required String key, required dynamic value}) async {
    if (_preferences == null) return false;

    if (value is String) return await _preferences!.setString(key, value);
    if (value is int) return await _preferences!.setInt(key, value);
    if (value is bool) return await _preferences!.setBool(key, value);
    if (value is double) return await _preferences!.setDouble(key, value);

    return false;
  }

  // 3. قراءة قيمة
  static dynamic getData({required String key}) {
    return _preferences?.get(key);
  }

  // 4. حذف قيمة
  static Future<bool> removeData({required String key}) async {
    return await _preferences!.remove(key);
  }

  // 5. مسح كل البيانات
  static Future<bool> clear() async {
    return await _preferences!.clear();
  }
}