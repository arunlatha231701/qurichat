// shared_prefs.dart
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<void> saveLoginData(String token, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setString('user_id', userId);
  }

  static Future<Map<String, String?>> getLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'token': prefs.getString('auth_token'),
      'userId': prefs.getString('user_id'),
    };
  }

  static Future<void> clearLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_id');
  }
}