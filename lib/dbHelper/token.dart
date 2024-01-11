import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static const String KEY_IS_LOGGED_IN = 'isLoggedIn';

  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(KEY_IS_LOGGED_IN) ?? false;
  }

  static Future<void> setLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(KEY_IS_LOGGED_IN, value);
  }
}
