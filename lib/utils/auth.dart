import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static Future<bool> isAuthenticate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_auth') ?? false;
  }

  static Future<void> saveSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('is_auth', true);
  }

  static Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('is_auth', false);
  }
}
